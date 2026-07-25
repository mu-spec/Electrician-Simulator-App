class CertificationTrack {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String difficulty;
  final String estimatedStudyTime;
  final String iconName;
  final String colorHex;
  final List<String> quizCategoryIds;
  final List<CertificationModule> modules;
  final List<String> recommendedArticleIds;
  final List<String> recommendedCalculatorIds;
  final List<String> recommendedDiagramIds;
  final List<String> tags;

  const CertificationTrack({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.difficulty,
    required this.estimatedStudyTime,
    required this.iconName,
    required this.colorHex,
    required this.quizCategoryIds,
    required this.modules,
    this.recommendedArticleIds = const [],
    this.recommendedCalculatorIds = const [],
    this.recommendedDiagramIds = const [],
    this.tags = const [],
  });

  int get totalLessons => modules.fold(0, (sum, module) => sum + module.lessons.length);
}

class CertificationModule {
  final String id;
  final String title;
  final String description;
  final List<String> lessons;
  final List<String> articleIds;
  final List<String> calculatorIds;
  final List<String> diagramIds;

  const CertificationModule({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
    this.articleIds = const [],
    this.calculatorIds = const [],
    this.diagramIds = const [],
  });
}

class CertificationProgress {
  final String trackId;
  final List<String> completedModuleIds;
  final int bestScore;
  final int attempts;
  final DateTime? lastAttemptAt;

  const CertificationProgress({
    required this.trackId,
    this.completedModuleIds = const [],
    this.bestScore = 0,
    this.attempts = 0,
    this.lastAttemptAt,
  });

  double completionPercent(CertificationTrack track) {
    if (track.modules.isEmpty) return 0;
    return (completedModuleIds.length / track.modules.length) * 100;
  }
}
