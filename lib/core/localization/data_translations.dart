import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';

class DataTranslations {
  static final Map<String, Map<String, String>> _cache = {};
  static final Map<String, Future<void>> _loadingFutures = {};

  /// Returns an exact translation from the loaded catalog.
  static String? translate(String languageCode, String english) {
    if (languageCode == 'en') return english;
    final catalog = _cache[languageCode];
    if (catalog != null) {
      return catalog[english];
    }
    // Attempt synchronous file system load if not cached (for tests/CLI)
    loadSync(languageCode);
    final syncCatalog = _cache[languageCode];
    if (syncCatalog != null) {
      return syncCatalog[english];
    }
    // Otherwise trigger asynchronous asset loading
    _loadAsync(languageCode);
    return null;
  }

  static bool hasTranslation(String languageCode, String english) =>
      translate(languageCode, english) != null;

  static Map<String, Map<String, String>> get map => _cache;

  /// Loads the translation catalog for [languageCode] into memory.
  static Future<void> load(String languageCode) async {
    if (languageCode == 'en' || _cache.containsKey(languageCode)) return;
    
    if (_loadingFutures.containsKey(languageCode)) {
      await _loadingFutures[languageCode];
      return;
    }

    final completer = Completer<void>();
    _loadingFutures[languageCode] = completer.future;

    try {
      // 1. Try Flutter asset rootBundle
      final bytes = await rootBundle.load('assets/l10n/$languageCode.json.gz');
      final decompressed = gzip.decode(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
      );
      final jsonString = utf8.decode(decompressed);
      final Map<String, dynamic> rawMap = jsonDecode(jsonString);
      final Map<String, String> stringMap = rawMap.map(
        (key, value) => MapEntry(key, value.toString()),
      );
      _cache[languageCode] = stringMap;
    } catch (_) {
      // 2. Fallback for direct file system loading during unit/widget tests
      loadSync(languageCode);
    } finally {
      _loadingFutures.remove(languageCode);
      completer.complete();
    }
  }

  static void _loadAsync(String languageCode) {
    load(languageCode);
  }

  /// Synchronously loads from file system if possible (useful for CLI / tests).
  static void loadSync(String languageCode) {
    if (languageCode == 'en' || _cache.containsKey(languageCode)) return;
    try {
      final path = 'assets/l10n/$languageCode.json.gz';
      final file = File(path);
      if (file.existsSync()) {
        final decompressed = gzip.decode(file.readAsBytesSync());
        final jsonString = utf8.decode(decompressed);
        final Map<String, dynamic> rawMap = jsonDecode(jsonString);
        final Map<String, String> stringMap = rawMap.map(
          (key, value) => MapEntry(key, value.toString()),
        );
        _cache[languageCode] = stringMap;
      }
    } catch (_) {}
  }

  /// Load all known catalogs synchronously (useful for test setup).
  static Future<void> loadAllForTest() async {
    final codes = [
      'ur', 'hi', 'ar', 'es', 'pt', 'fr', 'de', 'ru', 'zh', 'tr', 'id', 'bn',
      'fa', 'ms', 'it', 'ja', 'ko', 'vi', 'th', 'pl', 'nl', 'uk', 'ro', 'sv',
      'hu', 'cs', 'el', 'bg', 'da', 'fi', 'no', 'sk', 'hr', 'sr', 'ta', 'te',
      'kn', 'mr', 'gu', 'pa', 'sw', 'tl', 'he', 'az', 'uz', 'my', 'km', 'si', 'am',
    ];
    for (final code in codes) {
      await load(code);
      if (!_cache.containsKey(code)) {
        loadSync(code);
      }
    }
  }
}
