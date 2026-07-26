import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/core/localization/app_localizations.dart';
import '../lib/core/localization/data_translations.dart';
import '../lib/core/localization/generated_translations.dart';

void main() {
  const rewardedAdStrings = <String>{
    'Ads',
    'Ads paused (reward active)',
    'Watch Ad · Remove Ads 24h',
    'Optional. Watch a short ad to hide ads for 24 hours.',
    'Banner, interstitial and app-open ads are hidden temporarily.',
    'Ads removed for 24 hours. Enjoy!',
    'Rewarded ad is not ready yet. Please try again in a moment.',
    'Watch Ad to Retry Free',
  };

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

    for (final code in translatedCodes) {
      expect(DataTranslations.map[code]!.keys.toSet(), allKeys, reason: code);
      expect(
        GeneratedTranslations.map[code]!.keys.toSet(),
        allKeys,
        reason: code,
      );
      for (final source in rewardedAdStrings) {
        final translated = DataTranslations.translate(code, source);
        expect(translated, isNotNull, reason: '$code: $source');
        expect(translated!.trim(), isNotEmpty, reason: '$code: $source');
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
