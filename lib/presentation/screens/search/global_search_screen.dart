import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/ui_text.dart';
import '../../../core/localization/localized_content.dart';
import '../../../data/content/search/search_index.dart';
import '../../../data/repositories/app_repository.dart';
import '../calculators/calculator_detail_screen.dart';
import '../quiz/quiz_play_screen.dart';
import '../standards/pakistan_standards_screen.dart';
import '../theory/article_detail_screen.dart';
import '../videos/videos_screen.dart';
import '../wiring/diagram_detail_screen.dart';

class GlobalSearchScreen extends StatefulWidget {
  const GlobalSearchScreen({super.key});

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';
  SearchContentType? _selectedType;
  List<String> _recentSearches = const [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadRecentSearches() async {
    try {
      final box = await Hive.openBox('settings');
      final saved =
          (box.get('recentSearches', defaultValue: <String>[]) as List)
              .cast<String>();
      if (mounted) setState(() => _recentSearches = saved.take(8).toList());
    } catch (_) {
      // Ignore persistence errors.
    }
  }

  Future<void> _saveRecentSearch(String query) async {
    final clean = query.trim();
    if (clean.length < 2) return;
    final updated = [
      clean,
      ..._recentSearches.where(
        (item) => item.toLowerCase() != clean.toLowerCase(),
      ),
    ].take(8).toList();
    setState(() => _recentSearches = updated);
    try {
      final box = await Hive.openBox('settings');
      await box.put('recentSearches', updated);
    } catch (_) {}
  }

  List<SearchIndexEntry> get _results {
    final entries = AppRepository.searchIndex;
    final searched = SearchIndexBuilder.search(entries, _query);
    if (_selectedType == null) return searched;
    return searched.where((entry) => entry.type == _selectedType).toList();
  }

  List<String> get _suggestions {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) {
      return _recentSearches.isNotEmpty
          ? _recentSearches
          : const [
              'earthing',
              'voltage drop',
              'DOL starter',
              'solar net metering',
              'RCD',
              'K-Electric',
            ];
    }
    final suggestions = AppRepository.searchIndex
        .where((entry) => entry.searchableText.contains(query))
        .expand((entry) => [entry.title, ...entry.tags])
        .where((item) => item.toLowerCase().contains(query))
        .toSet()
        .take(8)
        .toList();
    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final results = _results;
    return Scaffold(
      appBar: AppBar(title: Text(UiText.t(context, 'Global Search'))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
            child: TextField(
              controller: _controller,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onSubmitted: _saveRecentSearch,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: UiText.t(
                  context,
                  'Search articles, tools, diagrams, quiz, standards, videos...',
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
              ),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _FilterChip(
                  label: UiText.t(context, 'All'),
                  selected: _selectedType == null,
                  onTap: () => setState(() => _selectedType = null),
                ),
                ...SearchContentType.values.map(
                  (type) => _FilterChip(
                    label: _typeLabel(type),
                    selected: _selectedType == type,
                    onTap: () => setState(() => _selectedType = type),
                  ),
                ),
              ],
            ),
          ),
          if (_query.isEmpty || results.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _query.isEmpty
                      ? UiText.t(context, 'Suggestions')
                      : UiText.t(context, 'No results. Try one of these:'),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          if (_query.isEmpty || results.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _suggestions
                    .map(
                      (suggestion) => ActionChip(
                        label: Text(LocalizedContent.text(context, suggestion)),
                        onPressed: () {
                          _controller.text = suggestion;
                          setState(() => _query = suggestion);
                          _saveRecentSearch(suggestion);
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          if (_query.isNotEmpty && results.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${results.length} ${UiText.t(context, results.length == 1 ? 'result' : 'results')}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          Expanded(
            child: results.isEmpty
                ? const SizedBox.shrink()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final entry = results[index];
                      final color = _typeColor(entry.type);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardTheme.color,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isDark
                                ? const Color(0xFF334155)
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(_typeIcon(entry.type), color: color),
                          ),
                          title: Text(
                            LocalizedContent.text(context, entry.title),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            LocalizedContent.text(context, entry.subtitle),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          onTap: () {
                            _saveRecentSearch(_query);
                            _openResult(context, entry);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _openResult(BuildContext context, SearchIndexEntry entry) {
    switch (entry.type) {
      case SearchContentType.theory:
        final matches = AppRepository.theoryArticles
            .where((article) => article.id == entry.id)
            .toList();
        if (matches.isNotEmpty)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ArticleDetailScreen(article: matches.first),
            ),
          );
        break;
      case SearchContentType.calculator:
        final matches = AppRepository.calculators
            .where((calculator) => calculator.id == entry.id)
            .toList();
        if (matches.isNotEmpty)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CalculatorDetailScreen(calculator: matches.first),
            ),
          );
        break;
      case SearchContentType.wiring:
        final matches = AppRepository.wiringDiagrams
            .where((diagram) => diagram.id == entry.id)
            .toList();
        if (matches.isNotEmpty)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DiagramDetailScreen(diagram: matches.first),
            ),
          );
        break;
      case SearchContentType.quiz:
        final question = AppRepository.quizQuestions
            .where((q) => q.id == entry.id)
            .toList();
        if (question.isNotEmpty) {
          final category = AppRepository.quizCategories.firstWhere(
            (c) => c.id == question.first.category,
          );
          final questions = AppRepository.quizQuestions
              .where((q) => q.category == category.id)
              .toList();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  QuizPlayScreen(category: category, questions: questions),
            ),
          );
        }
        break;
      case SearchContentType.standards:
        final matches = AppRepository.pakistanStandards
            .where((standard) => standard.id == entry.id)
            .toList();
        if (matches.isNotEmpty)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  PakistanStandardDetailScreen(standard: matches.first),
            ),
          );
        break;
      case SearchContentType.video:
        final matches = AppRepository.tutorialVideos
            .where((video) => video.id == entry.id)
            .toList();
        if (matches.isNotEmpty)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VideoDetailScreen(video: matches.first),
            ),
          );
        break;
    }
  }

  String _typeLabel(SearchContentType type) {
    switch (type) {
      case SearchContentType.theory:
        return UiText.t(context, 'Theory');
      case SearchContentType.calculator:
        return UiText.t(context, 'Tools');
      case SearchContentType.wiring:
        return UiText.t(context, 'Wiring');
      case SearchContentType.quiz:
        return UiText.t(context, 'Quiz');
      case SearchContentType.standards:
        return UiText.t(context, 'Standards');
      case SearchContentType.video:
        return UiText.t(context, 'Videos');
    }
  }

  IconData _typeIcon(SearchContentType type) {
    switch (type) {
      case SearchContentType.theory:
        return Icons.menu_book;
      case SearchContentType.calculator:
        return Icons.calculate;
      case SearchContentType.wiring:
        return Icons.account_tree;
      case SearchContentType.quiz:
        return Icons.quiz;
      case SearchContentType.standards:
        return Icons.gavel;
      case SearchContentType.video:
        return Icons.play_circle_fill;
    }
  }

  Color _typeColor(SearchContentType type) {
    switch (type) {
      case SearchContentType.theory:
        return AppTheme.primaryBlue;
      case SearchContentType.calculator:
        return AppTheme.accentGreen;
      case SearchContentType.wiring:
        return AppTheme.accentOrange;
      case SearchContentType.quiz:
        return AppTheme.accentPurple;
      case SearchContentType.standards:
        return const Color(0xFF0F766E);
      case SearchContentType.video:
        return AppTheme.accentRed;
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? AppTheme.primaryBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? AppTheme.primaryBlue : const Color(0xFFCBD5E1),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xFF64748B),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
