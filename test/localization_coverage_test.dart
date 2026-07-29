import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/core/localization/app_localizations.dart';
import '../lib/core/localization/data_translations.dart';
import '../lib/core/localization/generated_translations.dart';

void main() {
  test('all 50 locales have complete exact translation catalogs', () async {
    await DataTranslations.loadAllForTest();
    final supported = AppLocalizations.supportedLanguages
        .map((language) => language.code)
        .toList();
    expect(supported, hasLength(50));
    expect(supported.toSet(), hasLength(50));

    final translatedCodes = supported.where((code) => code != 'en').toSet();
    expect(DataTranslations.map.keys.toSet(), translatedCodes);
    expect(GeneratedTranslations.map.keys.toSet(), translatedCodes);

    final allKeys = DataTranslations.map.values.first.keys.toSet();
    // 5,179 original strings + 73 strings added in the full 50-language
    // translation update (2026-07-26): home subtitles, YouTube tab, resistor
    // scanner, settings/version cards, onboarding, projects, invoice, etc.
    expect(allKeys, hasLength(5252));

    // NOTE: memory-lean key comparison.
    //
    // The previous version called `.keys.toSet()` for every locale, which
    // allocated 98 extra Sets of 5,252 strings on top of the 49 catalogs
    // already in memory. That exhausted the Dart VM heap on lower-RAM
    // machines ("Out of memory" in allocation.cc).
    //
    // Comparing length + membership is logically identical for key sets
    // (same size and every key present implies equality) but allocates
    // nothing, because `.keys` is a lazy view.
    //
    // GeneratedTranslations.map is the *same object* as DataTranslations.map
    // (see generated_translations.dart), so it is asserted once here rather
    // than re-checked for every locale.
    expect(identical(GeneratedTranslations.map, DataTranslations.map), isTrue);

    for (final code in translatedCodes) {
      final catalogKeys = DataTranslations.map[code]!.keys;
      expect(catalogKeys, hasLength(allKeys.length), reason: code);
      for (final key in catalogKeys) {
        if (!allKeys.contains(key)) {
          fail('$code: unexpected key not present in reference catalog: $key');
        }
      }
    }
  });

  test('app title is available through AppLocalizations for all locales', () {
    for (final language in AppLocalizations.supportedLanguages) {
      final title = AppLocalizations(Locale(language.code)).t('appTitle');
      expect(title.trim(), isNotEmpty, reason: language.code);
      expect(title, isNot('appTitle'), reason: language.code);
    }
  });

  test('dynamic validation placeholders are preserved', () async {
    await DataTranslations.loadAllForTest();
    const templates = <String>{
      'Please enter {field}.',
      'Please enter a valid value for {field}.',
      '{field} must be at least {value}.',
      '{field} must be no more than {value}.',
    };
    final placeholder = RegExp(r'\{[A-Za-z_][A-Za-z0-9_]*\}');

    for (final entry in GeneratedTranslations.map.entries) {
      for (final source in templates) {
        final translated = entry.value[source]!;
        expect(
          placeholder
              .allMatches(translated)
              .map((match) => match.group(0))
              .toSet(),
          placeholder.allMatches(source).map((match) => match.group(0)).toSet(),
          reason: '${entry.key}: $source',
        );
      }
    }
  });
}
