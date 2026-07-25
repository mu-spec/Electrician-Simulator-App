class TutorialVideo {
  final String id;
  final String title;
  final String category;
  final String difficulty;
  final String duration;
  final String description;
  final String youtubeUrl;
  final String thumbnailAsset;
  final List<String> tags;
  final List<String> keywords;
  final String? relatedArticleId;
  final String? relatedCalculatorId;
  final String? relatedDiagramId;
  final String? relatedStandardId;
  final String languageCode;
  final String contentVersion;

  const TutorialVideo({
    required this.id,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.duration,
    required this.description,
    required this.youtubeUrl,
    this.thumbnailAsset = '',
    this.tags = const [],
    this.keywords = const [],
    this.relatedArticleId,
    this.relatedCalculatorId,
    this.relatedDiagramId,
    this.relatedStandardId,
    this.languageCode = 'en',
    this.contentVersion = '2.0.0-phase2h',
  });

  String get searchableText => [
        id,
        title,
        category,
        difficulty,
        duration,
        description,
        youtubeUrl,
        ...tags,
        ...keywords,
      ].join(' ').toLowerCase();
}

class VideoCategory {
  final String id;
  final String name;
  final String description;
  final String iconName;
  final String colorHex;
  final int videoCount;
  final List<String> keywords;

  const VideoCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.colorHex,
    required this.videoCount,
    this.keywords = const [],
  });
}
