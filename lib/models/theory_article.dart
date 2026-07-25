class TheoryArticle {
  final String id;
  final String title;
  final String category;
  final String content;
  final String? imageUrl;
  final String difficulty; // beginner, journeyman, master
  final List<String> tags;
  final bool isBookmarked;
  final DateTime? lastRead;
  final int readTimeMinutes;

  // Phase 2A scalable content metadata.
  final String summary;
  final String languageCode;
  final List<String> keywords;
  final List<String> relatedArticleIds;
  final List<String> pecReferences;
  final List<String> formulas;
  final List<String> safetyNotes;
  final List<String> commonMistakes;
  final List<String> professionalTips;
  final String lastReviewed;
  final String contentVersion;

  const TheoryArticle({
    required this.id,
    required this.title,
    required this.category,
    required this.content,
    this.imageUrl,
    required this.difficulty,
    this.tags = const [],
    this.isBookmarked = false,
    this.lastRead,
    required this.readTimeMinutes,
    this.summary = '',
    this.languageCode = 'en',
    this.keywords = const [],
    this.relatedArticleIds = const [],
    this.pecReferences = const [],
    this.formulas = const [],
    this.safetyNotes = const [],
    this.commonMistakes = const [],
    this.professionalTips = const [],
    this.lastReviewed = '2026-07-10',
    this.contentVersion = '2.0.0-phase2a',
  });

  String get searchableText => [
        id,
        title,
        category,
        summary,
        difficulty,
        content,
        ...tags,
        ...keywords,
        ...pecReferences,
        ...formulas,
      ].join(' ').toLowerCase();

  TheoryArticle copyWith({
    String? id,
    String? title,
    String? category,
    String? content,
    String? imageUrl,
    String? difficulty,
    List<String>? tags,
    bool? isBookmarked,
    DateTime? lastRead,
    int? readTimeMinutes,
    String? summary,
    String? languageCode,
    List<String>? keywords,
    List<String>? relatedArticleIds,
    List<String>? pecReferences,
    List<String>? formulas,
    List<String>? safetyNotes,
    List<String>? commonMistakes,
    List<String>? professionalTips,
    String? lastReviewed,
    String? contentVersion,
  }) {
    return TheoryArticle(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      lastRead: lastRead ?? this.lastRead,
      readTimeMinutes: readTimeMinutes ?? this.readTimeMinutes,
      summary: summary ?? this.summary,
      languageCode: languageCode ?? this.languageCode,
      keywords: keywords ?? this.keywords,
      relatedArticleIds: relatedArticleIds ?? this.relatedArticleIds,
      pecReferences: pecReferences ?? this.pecReferences,
      formulas: formulas ?? this.formulas,
      safetyNotes: safetyNotes ?? this.safetyNotes,
      commonMistakes: commonMistakes ?? this.commonMistakes,
      professionalTips: professionalTips ?? this.professionalTips,
      lastReviewed: lastReviewed ?? this.lastReviewed,
      contentVersion: contentVersion ?? this.contentVersion,
    );
  }
}

class TheoryCategory {
  final String id;
  final String name;
  final String iconName;
  final String colorHex;
  final int articleCount;
  final String description;
  final List<String> keywords;

  const TheoryCategory({
    required this.id,
    required this.name,
    required this.iconName,
    required this.colorHex,
    required this.articleCount,
    this.description = '',
    this.keywords = const [],
  });

  TheoryCategory copyWith({
    String? id,
    String? name,
    String? iconName,
    String? colorHex,
    int? articleCount,
    String? description,
    List<String>? keywords,
  }) {
    return TheoryCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      articleCount: articleCount ?? this.articleCount,
      description: description ?? this.description,
      keywords: keywords ?? this.keywords,
    );
  }
}
