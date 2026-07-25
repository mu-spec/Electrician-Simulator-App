/// Versioned manifest for bundled/offline content.
///
/// Phase 2A keeps the existing offline-first behavior while making the content
/// source explicit. Phase 2I prepares the closed beta candidate with feedback flow, Play Store docs, QA checklist, and release build guidance.
class ContentManifest {
  final String contentVersion;
  final String schemaVersion;
  final String lastUpdated;
  final String defaultLanguageCode;
  final List<String> supportedLanguageCodes;
  final String sourceType;
  final String safetyDisclaimer;

  const ContentManifest({
    required this.contentVersion,
    required this.schemaVersion,
    required this.lastUpdated,
    required this.defaultLanguageCode,
    required this.supportedLanguageCodes,
    required this.sourceType,
    required this.safetyDisclaimer,
  });

  static const ContentManifest phase2A = ContentManifest(
    contentVersion: '2.0.0-phase2i',
    schemaVersion: '1.9.0',
    lastUpdated: '2026-07-10',
    defaultLanguageCode: 'en',
    supportedLanguageCodes: ['en', 'ur', 'hi', 'ar', 'es', 'pt', 'fr', 'de', 'ru', 'zh', 'tr', 'id', 'bn', 'fa', 'ms'],
    sourceType: 'bundled-dart-content-with-metadata-enrichment',
    safetyDisclaimer:
        'Educational reference only. Always verify with the latest PEC, IEC, DISCO/WAPDA/K-Electric, manufacturer, and local authority requirements before installation.',
  );
}
