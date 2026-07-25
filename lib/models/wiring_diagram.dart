class WiringDiagram {
  final String id;
  final String title;
  final String category;
  final String description;
  final List<String> steps;
  final List<String> components;
  final String? svgPath;
  final bool isBookmarked;

  // Phase 2A metadata for professional diagram expansion.
  final String difficulty;
  final String languageCode;
  final List<String> tags;
  final List<String> keywords;
  final List<String> safetyWarnings;
  final List<String> commonMistakes;
  final List<String> testingProcedure;
  final List<String> professionalNotes;
  final List<String> standardsReferences;
  final List<String> relatedDiagramIds;
  final String contentVersion;

  const WiringDiagram({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.steps,
    required this.components,
    this.svgPath,
    this.isBookmarked = false,
    this.difficulty = 'beginner',
    this.languageCode = 'en',
    this.tags = const [],
    this.keywords = const [],
    this.safetyWarnings = const [
      'Isolate supply and verify zero energy before working on any circuit.',
    ],
    this.commonMistakes = const [],
    this.testingProcedure = const [],
    this.professionalNotes = const [],
    this.standardsReferences = const [],
    this.relatedDiagramIds = const [],
    this.contentVersion = '2.0.0-phase2a',
  });

  String get searchableText => [
        id,
        title,
        category,
        description,
        difficulty,
        ...steps,
        ...components,
        ...tags,
        ...keywords,
        ...safetyWarnings,
        ...standardsReferences,
      ].join(' ').toLowerCase();

  WiringDiagram copyWith({
    String? id,
    String? title,
    String? category,
    String? description,
    List<String>? steps,
    List<String>? components,
    String? svgPath,
    bool? isBookmarked,
    String? difficulty,
    String? languageCode,
    List<String>? tags,
    List<String>? keywords,
    List<String>? safetyWarnings,
    List<String>? commonMistakes,
    List<String>? testingProcedure,
    List<String>? professionalNotes,
    List<String>? standardsReferences,
    List<String>? relatedDiagramIds,
    String? contentVersion,
  }) {
    return WiringDiagram(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      steps: steps ?? this.steps,
      components: components ?? this.components,
      svgPath: svgPath ?? this.svgPath,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      difficulty: difficulty ?? this.difficulty,
      languageCode: languageCode ?? this.languageCode,
      tags: tags ?? this.tags,
      keywords: keywords ?? this.keywords,
      safetyWarnings: safetyWarnings ?? this.safetyWarnings,
      commonMistakes: commonMistakes ?? this.commonMistakes,
      testingProcedure: testingProcedure ?? this.testingProcedure,
      professionalNotes: professionalNotes ?? this.professionalNotes,
      standardsReferences: standardsReferences ?? this.standardsReferences,
      relatedDiagramIds: relatedDiagramIds ?? this.relatedDiagramIds,
      contentVersion: contentVersion ?? this.contentVersion,
    );
  }
}

class WiringCategory {
  final String id;
  final String name;
  final String iconName;
  final String colorHex;
  final int diagramCount;
  final String description;
  final List<String> keywords;

  const WiringCategory({
    required this.id,
    required this.name,
    required this.iconName,
    required this.colorHex,
    required this.diagramCount,
    this.description = '',
    this.keywords = const [],
  });

  WiringCategory copyWith({
    String? id,
    String? name,
    String? iconName,
    String? colorHex,
    int? diagramCount,
    String? description,
    List<String>? keywords,
  }) {
    return WiringCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      diagramCount: diagramCount ?? this.diagramCount,
      description: description ?? this.description,
      keywords: keywords ?? this.keywords,
    );
  }
}
