class PakistanStandard {
  final String id;
  final String title;
  final String authority;
  final String category;
  final String summary;
  final List<String> keyPoints;
  final List<String> fieldChecklist;
  final List<String> warnings;
  final List<String> relatedArticleIds;
  final List<String> relatedCalculatorIds;
  final List<String> relatedDiagramIds;
  final List<String> relatedQuizCategoryIds;
  final List<String> tags;
  final List<String> keywords;
  final String disclaimer;
  final String lastReviewed;
  final String contentVersion;

  const PakistanStandard({
    required this.id,
    required this.title,
    required this.authority,
    required this.category,
    required this.summary,
    required this.keyPoints,
    required this.fieldChecklist,
    required this.warnings,
    this.relatedArticleIds = const [],
    this.relatedCalculatorIds = const [],
    this.relatedDiagramIds = const [],
    this.relatedQuizCategoryIds = const [],
    this.tags = const [],
    this.keywords = const [],
    this.disclaimer = PakistanStandardsDisclaimer.text,
    this.lastReviewed = '2026-07-10',
    this.contentVersion = '2.0.0-phase2f',
  });

  String get searchableText => [
        id,
        title,
        authority,
        category,
        summary,
        ...keyPoints,
        ...fieldChecklist,
        ...warnings,
        ...tags,
        ...keywords,
      ].join(' ').toLowerCase();
}

class PakistanStandardCategory {
  final String id;
  final String name;
  final String description;
  final String iconName;
  final String colorHex;
  final int standardCount;
  final List<String> keywords;

  const PakistanStandardCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.colorHex,
    required this.standardCount,
    this.keywords = const [],
  });
}

class PakistanStandardsDisclaimer {
  static const String text =
      'Educational reference only. This app is not an official PEC, WAPDA, DISCO, K-Electric, NEPRA, or government publication. Always verify final design, installation, approvals, testing, and inspection requirements with the latest official documents, local authority, utility/DISCO, manufacturer instructions, and a qualified/licensed professional.';
}
