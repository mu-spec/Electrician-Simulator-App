class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String category;
  final String difficulty;

  // Phase 2A metadata for bigger quiz bank, image questions, and standards.
  final String languageCode;
  final String? imageAsset;
  final String? relatedArticleId;
  final String pecReference;
  final List<String> tags;
  final List<String> keywords;
  final String contentVersion;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.category,
    required this.difficulty,
    this.languageCode = 'en',
    this.imageAsset,
    this.relatedArticleId,
    this.pecReference = '',
    this.tags = const [],
    this.keywords = const [],
    this.contentVersion = '2.0.0-phase2a',
  });

  String get searchableText => [
        id,
        question,
        category,
        difficulty,
        explanation,
        pecReference,
        ...options,
        ...tags,
        ...keywords,
      ].join(' ').toLowerCase();

  QuizQuestion copyWith({
    String? id,
    String? question,
    List<String>? options,
    int? correctIndex,
    String? explanation,
    String? category,
    String? difficulty,
    String? languageCode,
    String? imageAsset,
    String? relatedArticleId,
    String? pecReference,
    List<String>? tags,
    List<String>? keywords,
    String? contentVersion,
  }) {
    return QuizQuestion(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      correctIndex: correctIndex ?? this.correctIndex,
      explanation: explanation ?? this.explanation,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      languageCode: languageCode ?? this.languageCode,
      imageAsset: imageAsset ?? this.imageAsset,
      relatedArticleId: relatedArticleId ?? this.relatedArticleId,
      pecReference: pecReference ?? this.pecReference,
      tags: tags ?? this.tags,
      keywords: keywords ?? this.keywords,
      contentVersion: contentVersion ?? this.contentVersion,
    );
  }
}

class QuizCategory {
  final String id;
  final String name;
  final String description;
  final String iconName;
  final String colorHex;
  final int totalQuestions;
  final int? bestScore;
  final List<String> keywords;

  const QuizCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.colorHex,
    required this.totalQuestions,
    this.bestScore,
    this.keywords = const [],
  });

  QuizCategory copyWith({
    String? id,
    String? name,
    String? description,
    String? iconName,
    String? colorHex,
    int? totalQuestions,
    int? bestScore,
    List<String>? keywords,
  }) {
    return QuizCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      bestScore: bestScore ?? this.bestScore,
      keywords: keywords ?? this.keywords,
    );
  }
}

class QuizResult {
  final String categoryId;
  final int score;
  final int totalQuestions;
  final int timeSeconds;
  final DateTime date;

  const QuizResult({
    required this.categoryId,
    required this.score,
    required this.totalQuestions,
    required this.timeSeconds,
    required this.date,
  });

  double get percentage => (score / totalQuestions) * 100;
}
