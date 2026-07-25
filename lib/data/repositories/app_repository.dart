import '../../models/theory_article.dart';
import '../../models/calculator_model.dart';
import '../../models/quiz_model.dart';
import '../../models/wiring_diagram.dart';
import '../../models/pakistan_standard.dart';
import '../../models/tutorial_video.dart';
import '../../models/certification_track.dart';
import '../content/calculator_content.dart';
import '../content/certification_content.dart';
import '../content/content_enrichment.dart';
import '../content/content_manifest.dart';
import '../content/content_quality.dart';
import '../content/content_validator.dart';
import '../content/pakistan_standards_content.dart';
import '../content/quiz_content.dart';
import '../content/search/search_index.dart';
import '../content/theory_content.dart';
import '../content/video_content.dart';
import '../content/wiring_content.dart';

/// Central repository facade used by the presentation layer.
///
/// Phase 2A moved the large static content blocks into dedicated content files
/// while keeping this public API stable for existing screens. Phase 2A.2 adds
/// metadata enrichment, quality standards, and stronger validation so Phase 2B+
/// content can scale professionally without UI rewrites.
class AppRepository {
  static const ContentManifest manifest = ContentManifest.phase2A;
  static const String contentQualityVersion = ContentQualityStandards.version;

  // Theory
  static final List<TheoryCategory> theoryCategories =
      ContentEnrichment.enrichTheoryCategories(TheoryContent.theoryCategories);
  static final List<TheoryArticle> theoryArticles =
      ContentEnrichment.enrichTheoryArticles(TheoryContent.theoryArticles);

  // Calculators
  static final List<CalculatorCategory> calculatorCategories =
      ContentEnrichment.enrichCalculatorCategories(CalculatorContent.calculatorCategories);
  static final List<CalculatorModel> calculators =
      ContentEnrichment.enrichCalculators(CalculatorContent.calculators);

  // Quiz
  static final List<QuizCategory> quizCategories =
      ContentEnrichment.enrichQuizCategories(QuizContent.quizCategories);
  static final List<QuizQuestion> quizQuestions =
      ContentEnrichment.enrichQuizQuestions(QuizContent.quizQuestions);

  // Wiring diagrams
  static final List<WiringCategory> wiringCategories =
      ContentEnrichment.enrichWiringCategories(WiringContent.wiringCategories);
  static final List<WiringDiagram> wiringDiagrams =
      ContentEnrichment.enrichWiringDiagrams(WiringContent.wiringDiagrams);

  // Standards & Codes / local and international references
  static const List<PakistanStandardCategory> pakistanStandardCategories = PakistanStandardsContent.categories;
  static const List<PakistanStandard> pakistanStandards = PakistanStandardsContent.standards;

  // Video tutorials / placeholders
  static const List<VideoCategory> videoCategories = VideoContent.videoCategories;
  static const List<TutorialVideo> tutorialVideos = VideoContent.tutorialVideos;

  // Certification tracks
  static const List<CertificationTrack> certificationTracks = CertificationContent.tracks;

  /// Lightweight searchable catalog for the global search UI.
  static List<SearchIndexEntry> get searchIndex => SearchIndexBuilder.build(
        theoryArticles: theoryArticles,
        calculators: calculators,
        wiringDiagrams: wiringDiagrams,
        quizQuestions: quizQuestions,
        pakistanStandards: pakistanStandards,
        tutorialVideos: tutorialVideos,
      );

  /// Production QA helper. This is intentionally side-effect free so tests,
  /// CI, and debug screens can call it before beta builds.
  static ContentValidationReport validateContent() {
    return ContentValidator.validate(
      theoryCategories: theoryCategories,
      theoryArticles: theoryArticles,
      calculatorCategories: calculatorCategories,
      calculators: calculators,
      quizCategories: quizCategories,
      quizQuestions: quizQuestions,
      wiringCategories: wiringCategories,
      wiringDiagrams: wiringDiagrams,
      pakistanStandardCategories: pakistanStandardCategories,
      pakistanStandards: pakistanStandards,
      videoCategories: videoCategories,
      tutorialVideos: tutorialVideos,
    );
  }
}
