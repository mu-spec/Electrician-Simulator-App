import '../../models/calculator_model.dart';
import '../../models/pakistan_standard.dart';
import '../../models/quiz_model.dart';
import '../../models/theory_article.dart';
import '../../models/tutorial_video.dart';
import '../../models/wiring_diagram.dart';
import 'content_quality.dart';

class ContentValidationIssue {
  final String severity; // error, warning
  final String collection;
  final String itemId;
  final String message;

  const ContentValidationIssue({
    required this.severity,
    required this.collection,
    required this.itemId,
    required this.message,
  });

  bool get isError => severity == 'error';

  @override
  String toString() => '[$severity] $collection/$itemId: $message';
}

class ContentValidationReport {
  final List<ContentValidationIssue> issues;

  const ContentValidationReport(this.issues);

  bool get isValid => errors.isEmpty;
  List<ContentValidationIssue> get errors => issues.where((i) => i.isError).toList();
  List<ContentValidationIssue> get warnings => issues.where((i) => !i.isError).toList();

  String get summary => 'Content validation: ${errors.length} error(s), ${warnings.length} warning(s)';
}

class ContentValidator {
  static ContentValidationReport validate({
    required List<TheoryCategory> theoryCategories,
    required List<TheoryArticle> theoryArticles,
    required List<CalculatorCategory> calculatorCategories,
    required List<CalculatorModel> calculators,
    required List<QuizCategory> quizCategories,
    required List<QuizQuestion> quizQuestions,
    required List<WiringCategory> wiringCategories,
    required List<WiringDiagram> wiringDiagrams,
    List<PakistanStandardCategory> pakistanStandardCategories = const [],
    List<PakistanStandard> pakistanStandards = const [],
    List<VideoCategory> videoCategories = const [],
    List<TutorialVideo> tutorialVideos = const [],
  }) {
    final issues = <ContentValidationIssue>[];

    _validateUniqueIds(issues, 'theoryArticles', theoryArticles.map((a) => a.id));
    _validateUniqueIds(issues, 'calculators', calculators.map((c) => c.id));
    _validateUniqueIds(issues, 'quizQuestions', quizQuestions.map((q) => q.id));
    _validateUniqueIds(issues, 'wiringDiagrams', wiringDiagrams.map((d) => d.id));

    final theoryCategoryIds = theoryCategories.map((c) => c.id).toSet();
    final articleIds = theoryArticles.map((a) => a.id).toSet();
    for (final category in theoryCategories) {
      _required(issues, 'theoryCategories', category.id, 'name', category.name);
      _metadataRecommended(issues, 'theoryCategories', category.id, 'description', category.description);
      final actualCount = theoryArticles.where((article) => article.category == category.id).length;
      if (category.articleCount != actualCount) {
        _error(issues, 'theoryCategories', category.id, 'articleCount ${category.articleCount} does not match actual count $actualCount');
      }
      if (category.keywords.isEmpty) {
        _warning(issues, 'theoryCategories', category.id, 'Add category keywords for search suggestions');
      }
    }

    for (final article in theoryArticles) {
      _required(issues, 'theoryArticles', article.id, 'title', article.title);
      _required(issues, 'theoryArticles', article.id, 'content', article.content);
      _required(issues, 'theoryArticles', article.id, 'summary', article.summary);
      _validateLanguage(issues, 'theoryArticles', article.id, article.languageCode);
      _validateDifficulty(issues, 'theoryArticles', article.id, article.difficulty, ContentQualityStandards.articleDifficulties);
      if (!theoryCategoryIds.contains(article.category)) {
        _error(issues, 'theoryArticles', article.id, 'Unknown category "${article.category}"');
      }
      if (article.readTimeMinutes <= 0) {
        _error(issues, 'theoryArticles', article.id, 'readTimeMinutes must be greater than zero');
      }
      if (article.tags.isEmpty || article.keywords.isEmpty) {
        _error(issues, 'theoryArticles', article.id, 'Tags and keywords are required for Phase 2 search');
      }
      if (article.safetyNotes.isEmpty) {
        _warning(issues, 'theoryArticles', article.id, 'Add safety notes where topic affects field work');
      }
      if (article.commonMistakes.isEmpty) {
        _warning(issues, 'theoryArticles', article.id, 'Add common mistakes for professional learning value');
      }
      if (article.professionalTips.isEmpty) {
        _warning(issues, 'theoryArticles', article.id, 'Add professional tips for field usefulness');
      }
      for (final relatedId in article.relatedArticleIds) {
        if (!articleIds.contains(relatedId)) {
          _error(issues, 'theoryArticles', article.id, 'Unknown relatedArticleId "$relatedId"');
        }
      }
    }

    final calculatorCategoryIds = calculatorCategories.map((c) => c.id).toSet();
    for (final category in calculatorCategories) {
      _metadataRecommended(issues, 'calculatorCategories', category.id, 'description', category.description);
      if (category.keywords.isEmpty) {
        _warning(issues, 'calculatorCategories', category.id, 'Add category keywords for calculator search');
      }
    }

    for (final calculator in calculators) {
      _required(issues, 'calculators', calculator.id, 'name', calculator.name);
      _required(issues, 'calculators', calculator.id, 'description', calculator.description);
      _required(issues, 'calculators', calculator.id, 'formula', calculator.formula);
      _validateLanguage(issues, 'calculators', calculator.id, calculator.languageCode);
      if (!calculatorCategoryIds.contains(calculator.category)) {
        _error(issues, 'calculators', calculator.id, 'Unknown category "${calculator.category}"');
      }
      if (calculator.inputFields.isEmpty) {
        _error(issues, 'calculators', calculator.id, 'At least one input field is required');
      }
      if (calculator.outputs.isEmpty) {
        _error(issues, 'calculators', calculator.id, 'At least one output is required');
      }
      if (calculator.tags.isEmpty || calculator.keywords.isEmpty) {
        _error(issues, 'calculators', calculator.id, 'Tags and keywords are required for search');
      }
      if (calculator.safetyNotes.isEmpty || calculator.accuracyNote.trim().isEmpty) {
        _error(issues, 'calculators', calculator.id, 'Safety notes and accuracy note are required');
      }
      if (calculator.professionalNotes.isEmpty) {
        _warning(issues, 'calculators', calculator.id, 'Add professional notes explaining field limitations');
      }
      _validateUniqueIds(issues, 'calculatorFields:${calculator.id}', calculator.inputFields.map((f) => f.id));
      _validateUniqueIds(issues, 'calculatorOutputs:${calculator.id}', calculator.outputs.map((o) => o.id));
      for (final field in calculator.inputFields) {
        _required(issues, 'calculatorFields', '${calculator.id}.${field.id}', 'label', field.label);
        if (field.minValue != null && field.maxValue != null && field.minValue! > field.maxValue!) {
          _error(issues, 'calculators', calculator.id, 'Field ${field.id} has minValue greater than maxValue');
        }
      }
      for (final relatedId in calculator.relatedArticleIds) {
        if (!articleIds.contains(relatedId)) {
          _error(issues, 'calculators', calculator.id, 'Unknown relatedArticleId "$relatedId"');
        }
      }
    }

    final quizCategoryIds = quizCategories.map((c) => c.id).toSet();
    for (final category in quizCategories) {
      final actualCount = quizQuestions.where((question) => question.category == category.id).length;
      if (category.totalQuestions != actualCount) {
        _error(issues, 'quizCategories', category.id, 'totalQuestions ${category.totalQuestions} does not match actual count $actualCount');
      }
      if (category.keywords.isEmpty) {
        _warning(issues, 'quizCategories', category.id, 'Add keywords for quiz search/suggestions');
      }
    }

    for (final question in quizQuestions) {
      _required(issues, 'quizQuestions', question.id, 'question', question.question);
      _validateLanguage(issues, 'quizQuestions', question.id, question.languageCode);
      _validateDifficulty(issues, 'quizQuestions', question.id, question.difficulty, ContentQualityStandards.quizDifficulties);
      if (!quizCategoryIds.contains(question.category)) {
        _error(issues, 'quizQuestions', question.id, 'Unknown category "${question.category}"');
      }
      if (question.options.length < 2) {
        _error(issues, 'quizQuestions', question.id, 'At least two answer options are required');
      }
      if (question.correctIndex < 0 || question.correctIndex >= question.options.length) {
        _error(issues, 'quizQuestions', question.id, 'correctIndex is outside options range');
      }
      _required(issues, 'quizQuestions', question.id, 'explanation', question.explanation);
      if (question.tags.isEmpty || question.keywords.isEmpty) {
        _error(issues, 'quizQuestions', question.id, 'Tags and keywords are required for search');
      }
      if (question.relatedArticleId != null && !articleIds.contains(question.relatedArticleId)) {
        _error(issues, 'quizQuestions', question.id, 'Unknown relatedArticleId "${question.relatedArticleId}"');
      }
    }

    final wiringCategoryIds = wiringCategories.map((c) => c.id).toSet();
    final diagramIds = wiringDiagrams.map((d) => d.id).toSet();
    for (final category in wiringCategories) {
      _metadataRecommended(issues, 'wiringCategories', category.id, 'description', category.description);
      final actualCount = wiringDiagrams.where((diagram) => diagram.category == category.id).length;
      if (category.diagramCount != actualCount) {
        _error(issues, 'wiringCategories', category.id, 'diagramCount ${category.diagramCount} does not match actual count $actualCount');
      }
      if (category.keywords.isEmpty) {
        _warning(issues, 'wiringCategories', category.id, 'Add category keywords for diagram search');
      }
    }

    for (final diagram in wiringDiagrams) {
      _required(issues, 'wiringDiagrams', diagram.id, 'title', diagram.title);
      _required(issues, 'wiringDiagrams', diagram.id, 'description', diagram.description);
      _validateLanguage(issues, 'wiringDiagrams', diagram.id, diagram.languageCode);
      _validateDifficulty(issues, 'wiringDiagrams', diagram.id, diagram.difficulty, ContentQualityStandards.wiringDifficulties);
      if (!wiringCategoryIds.contains(diagram.category)) {
        _error(issues, 'wiringDiagrams', diagram.id, 'Unknown category "${diagram.category}"');
      }
      if (diagram.steps.isEmpty) {
        _error(issues, 'wiringDiagrams', diagram.id, 'Step-by-step instructions are required');
      }
      if (diagram.components.isEmpty) {
        _error(issues, 'wiringDiagrams', diagram.id, 'Component list is required');
      }
      if (diagram.tags.isEmpty || diagram.keywords.isEmpty) {
        _error(issues, 'wiringDiagrams', diagram.id, 'Tags and keywords are required for search');
      }
      if (diagram.safetyWarnings.isEmpty) {
        _error(issues, 'wiringDiagrams', diagram.id, 'Safety warnings are required');
      }
      if (diagram.commonMistakes.isEmpty || diagram.testingProcedure.isEmpty || diagram.professionalNotes.isEmpty) {
        _warning(issues, 'wiringDiagrams', diagram.id, 'Add common mistakes, testing procedure, and professional notes');
      }
      for (final relatedId in diagram.relatedDiagramIds) {
        if (!diagramIds.contains(relatedId)) {
          _error(issues, 'wiringDiagrams', diagram.id, 'Unknown relatedDiagramId "$relatedId"');
        }
      }
    }

    if (pakistanStandards.isNotEmpty || pakistanStandardCategories.isNotEmpty) {
      _validateUniqueIds(issues, 'pakistanStandards', pakistanStandards.map((standard) => standard.id));
      final standardCategoryIds = pakistanStandardCategories.map((category) => category.id).toSet();
      final calculatorIds = calculators.map((calculator) => calculator.id).toSet();
      final quizCategoryIdSet = quizCategories.map((category) => category.id).toSet();

      for (final category in pakistanStandardCategories) {
        _required(issues, 'pakistanStandardCategories', category.id, 'name', category.name);
        final actualCount = pakistanStandards.where((standard) => standard.category == category.id).length;
        if (category.standardCount != actualCount) {
          _error(issues, 'pakistanStandardCategories', category.id, 'standardCount ${category.standardCount} does not match actual count $actualCount');
        }
        if (category.keywords.isEmpty) {
          _warning(issues, 'pakistanStandardCategories', category.id, 'Add category keywords for search');
        }
      }

      for (final standard in pakistanStandards) {
        _required(issues, 'pakistanStandards', standard.id, 'title', standard.title);
        _required(issues, 'pakistanStandards', standard.id, 'summary', standard.summary);
        _required(issues, 'pakistanStandards', standard.id, 'authority', standard.authority);
        _required(issues, 'pakistanStandards', standard.id, 'disclaimer', standard.disclaimer);
        if (!standardCategoryIds.contains(standard.category)) {
          _error(issues, 'pakistanStandards', standard.id, 'Unknown category "${standard.category}"');
        }
        if (standard.keyPoints.isEmpty || standard.fieldChecklist.isEmpty || standard.warnings.isEmpty) {
          _error(issues, 'pakistanStandards', standard.id, 'Key points, field checklist, and warnings are required');
        }
        if (standard.tags.isEmpty || standard.keywords.isEmpty) {
          _error(issues, 'pakistanStandards', standard.id, 'Tags and keywords are required');
        }
        for (final relatedId in standard.relatedArticleIds) {
          if (!articleIds.contains(relatedId)) {
            _error(issues, 'pakistanStandards', standard.id, 'Unknown relatedArticleId "$relatedId"');
          }
        }
        for (final relatedId in standard.relatedCalculatorIds) {
          if (!calculatorIds.contains(relatedId)) {
            _error(issues, 'pakistanStandards', standard.id, 'Unknown relatedCalculatorId "$relatedId"');
          }
        }
        for (final relatedId in standard.relatedDiagramIds) {
          if (!diagramIds.contains(relatedId)) {
            _error(issues, 'pakistanStandards', standard.id, 'Unknown relatedDiagramId "$relatedId"');
          }
        }
        for (final relatedId in standard.relatedQuizCategoryIds) {
          if (!quizCategoryIdSet.contains(relatedId)) {
            _error(issues, 'pakistanStandards', standard.id, 'Unknown relatedQuizCategoryId "$relatedId"');
          }
        }
      }
    }

    if (tutorialVideos.isNotEmpty || videoCategories.isNotEmpty) {
      _validateUniqueIds(issues, 'tutorialVideos', tutorialVideos.map((video) => video.id));
      final videoCategoryIds = videoCategories.map((category) => category.id).toSet();
      final calculatorIds = calculators.map((calculator) => calculator.id).toSet();
      final standardIds = pakistanStandards.map((standard) => standard.id).toSet();

      for (final category in videoCategories) {
        _required(issues, 'videoCategories', category.id, 'name', category.name);
        final actualCount = tutorialVideos.where((video) => video.category == category.id).length;
        if (category.videoCount != actualCount) {
          _error(issues, 'videoCategories', category.id, 'videoCount ${category.videoCount} does not match actual count $actualCount');
        }
        if (category.keywords.isEmpty) {
          _warning(issues, 'videoCategories', category.id, 'Add category keywords for video search');
        }
      }

      for (final video in tutorialVideos) {
        _required(issues, 'tutorialVideos', video.id, 'title', video.title);
        _required(issues, 'tutorialVideos', video.id, 'description', video.description);
        _required(issues, 'tutorialVideos', video.id, 'youtubeUrl', video.youtubeUrl);
        _validateLanguage(issues, 'tutorialVideos', video.id, video.languageCode);
        _validateDifficulty(issues, 'tutorialVideos', video.id, video.difficulty, ContentQualityStandards.articleDifficulties);
        if (!videoCategoryIds.contains(video.category)) {
          _error(issues, 'tutorialVideos', video.id, 'Unknown category "${video.category}"');
        }
        if (!video.youtubeUrl.startsWith('https://www.youtube.com/') && !video.youtubeUrl.startsWith('https://youtu.be/')) {
          _error(issues, 'tutorialVideos', video.id, 'YouTube URL must use youtube.com or youtu.be');
        }
        if (video.tags.isEmpty || video.keywords.isEmpty) {
          _error(issues, 'tutorialVideos', video.id, 'Tags and keywords are required');
        }
        if (video.relatedArticleId != null && !articleIds.contains(video.relatedArticleId)) {
          _error(issues, 'tutorialVideos', video.id, 'Unknown relatedArticleId "${video.relatedArticleId}"');
        }
        if (video.relatedCalculatorId != null && !calculatorIds.contains(video.relatedCalculatorId)) {
          _error(issues, 'tutorialVideos', video.id, 'Unknown relatedCalculatorId "${video.relatedCalculatorId}"');
        }
        if (video.relatedDiagramId != null && !diagramIds.contains(video.relatedDiagramId)) {
          _error(issues, 'tutorialVideos', video.id, 'Unknown relatedDiagramId "${video.relatedDiagramId}"');
        }
        if (video.relatedStandardId != null && !standardIds.contains(video.relatedStandardId)) {
          _error(issues, 'tutorialVideos', video.id, 'Unknown relatedStandardId "${video.relatedStandardId}"');
        }
      }
    }

    return ContentValidationReport(issues);
  }

  static void _validateUniqueIds(List<ContentValidationIssue> issues, String collection, Iterable<String> ids) {
    final seen = <String>{};
    for (final id in ids) {
      if (id.trim().isEmpty) {
        _error(issues, collection, '<empty>', 'ID cannot be empty');
      } else if (!seen.add(id)) {
        _error(issues, collection, id, 'Duplicate ID');
      }
    }
  }

  static void _required(List<ContentValidationIssue> issues, String collection, String itemId, String field, String value) {
    if (value.trim().isEmpty) {
      _error(issues, collection, itemId, '$field is required');
    }
  }

  static void _metadataRecommended(List<ContentValidationIssue> issues, String collection, String itemId, String field, String value) {
    if (value.trim().isEmpty) {
      _warning(issues, collection, itemId, '$field is recommended for Phase 2 content quality');
    }
  }

  static void _validateLanguage(List<ContentValidationIssue> issues, String collection, String itemId, String languageCode) {
    if (!ContentQualityStandards.supportedLanguages.contains(languageCode)) {
      _error(issues, collection, itemId, 'Unsupported languageCode "$languageCode"');
    }
  }

  static void _validateDifficulty(List<ContentValidationIssue> issues, String collection, String itemId, String difficulty, List<String> allowed) {
    if (!allowed.contains(difficulty)) {
      _error(issues, collection, itemId, 'Unsupported difficulty "$difficulty"');
    }
  }

  static void _error(List<ContentValidationIssue> issues, String collection, String itemId, String message) {
    issues.add(ContentValidationIssue(severity: 'error', collection: collection, itemId: itemId, message: message));
  }

  static void _warning(List<ContentValidationIssue> issues, String collection, String itemId, String message) {
    issues.add(ContentValidationIssue(severity: 'warning', collection: collection, itemId: itemId, message: message));
  }
}
