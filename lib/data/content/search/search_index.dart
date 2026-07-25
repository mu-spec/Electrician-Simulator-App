import '../../../models/calculator_model.dart';
import '../../../models/pakistan_standard.dart';
import '../../../models/quiz_model.dart';
import '../../../models/theory_article.dart';
import '../../../models/tutorial_video.dart';
import '../../../models/wiring_diagram.dart';

enum SearchContentType { theory, calculator, wiring, quiz, standards, video }

class SearchIndexEntry {
  final String id;
  final SearchContentType type;
  final String title;
  final String subtitle;
  final String category;
  final List<String> tags;
  final String searchableText;

  const SearchIndexEntry({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.tags,
    required this.searchableText,
  });

  bool matches(String query) => searchableText.contains(query.trim().toLowerCase());
}

class SearchIndexBuilder {
  static List<SearchIndexEntry> build({
    required List<TheoryArticle> theoryArticles,
    required List<CalculatorModel> calculators,
    required List<WiringDiagram> wiringDiagrams,
    required List<QuizQuestion> quizQuestions,
    List<PakistanStandard> pakistanStandards = const [],
    List<TutorialVideo> tutorialVideos = const [],
  }) {
    return [
      ...theoryArticles.map(
        (article) => SearchIndexEntry(
          id: article.id,
          type: SearchContentType.theory,
          title: article.title,
          subtitle: article.summary.isNotEmpty ? article.summary : '${article.readTimeMinutes} min read',
          category: article.category,
          tags: [...article.tags, ...article.keywords],
          searchableText: article.searchableText,
        ),
      ),
      ...calculators.map(
        (calculator) => SearchIndexEntry(
          id: calculator.id,
          type: SearchContentType.calculator,
          title: calculator.name,
          subtitle: calculator.description,
          category: calculator.category,
          tags: [...calculator.tags, ...calculator.keywords],
          searchableText: calculator.searchableText,
        ),
      ),
      ...wiringDiagrams.map(
        (diagram) => SearchIndexEntry(
          id: diagram.id,
          type: SearchContentType.wiring,
          title: diagram.title,
          subtitle: diagram.description,
          category: diagram.category,
          tags: [...diagram.tags, ...diagram.keywords],
          searchableText: diagram.searchableText,
        ),
      ),
      ...quizQuestions.map(
        (question) => SearchIndexEntry(
          id: question.id,
          type: SearchContentType.quiz,
          title: question.question,
          subtitle: question.explanation,
          category: question.category,
          tags: [...question.tags, ...question.keywords],
          searchableText: question.searchableText,
        ),
      ),
      ...pakistanStandards.map(
        (standard) => SearchIndexEntry(
          id: standard.id,
          type: SearchContentType.standards,
          title: standard.title,
          subtitle: standard.summary,
          category: standard.category,
          tags: [...standard.tags, ...standard.keywords, standard.authority],
          searchableText: standard.searchableText,
        ),
      ),
      ...tutorialVideos.map(
        (video) => SearchIndexEntry(
          id: video.id,
          type: SearchContentType.video,
          title: video.title,
          subtitle: video.description,
          category: video.category,
          tags: [...video.tags, ...video.keywords],
          searchableText: video.searchableText,
        ),
      ),
    ];
  }

  static List<SearchIndexEntry> search(List<SearchIndexEntry> entries, String query) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return const [];
    final results = entries.where((entry) => entry.matches(normalizedQuery)).toList();
    results.sort((a, b) {
      final aTitle = a.title.toLowerCase().contains(normalizedQuery) ? 0 : 1;
      final bTitle = b.title.toLowerCase().contains(normalizedQuery) ? 0 : 1;
      return aTitle.compareTo(bTitle);
    });
    return results;
  }
}
