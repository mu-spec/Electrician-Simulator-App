import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/localized_content.dart';
import '../../../core/localization/ui_text.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../models/theory_article.dart';
import 'article_detail_screen.dart';
import '../settings/bookmarks_screen.dart';

/// Theory Academy list — clean cards, Arial type, clear hierarchy.
class TheoryScreen extends StatefulWidget {
  const TheoryScreen({super.key});

  @override
  State<TheoryScreen> createState() => _TheoryScreenState();
}

class _TheoryScreenState extends State<TheoryScreen> {
  String _selectedCategory = 'all';
  String _searchQuery = '';

  static const String _font = AppTheme.fontFamily;

  List<TheoryArticle> get filteredArticles {
    var articles = AppRepository.theoryArticles;
    if (_selectedCategory != 'all') {
      articles = articles.where((a) => a.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase().trim();
      articles = articles.where((a) {
        return a.title.toLowerCase().contains(query) ||
            a.summary.toLowerCase().contains(query) ||
            a.category.toLowerCase().contains(query) ||
            a.tags.any((t) => t.toLowerCase().contains(query)) ||
            a.keywords.any((k) => k.toLowerCase().contains(query)) ||
            a.content.toLowerCase().contains(query);
      }).toList();
    }
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final titleColor = isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A);
    final muted = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.t('theoryAcademy'),
          style: TextStyle(
            fontFamily: _font,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            tooltip: UiText.t(context, 'Bookmarks'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BookmarksScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              style: const TextStyle(fontFamily: _font, fontSize: 15),
              decoration: InputDecoration(
                hintText: l10n.t('searchArticles'),
                hintStyle: TextStyle(fontFamily: _font, color: muted),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _CategoryChip(
                  label: l10n.t('all'),
                  isSelected: _selectedCategory == 'all',
                  fontFamily: _font,
                  onTap: () => setState(() => _selectedCategory = 'all'),
                ),
                ...AppRepository.theoryCategories.map((cat) {
                  return _CategoryChip(
                    label: LocalizedContent.theoryCategoryName(context, cat.id, cat.name),
                    isSelected: _selectedCategory == cat.id,
                    color: Color(int.parse(cat.colorHex.replaceFirst('#', '0xFF'))),
                    fontFamily: _font,
                    onTap: () => setState(() => _selectedCategory = cat.id),
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${filteredArticles.length} ${UiText.t(context, 'articles')}',
                style: TextStyle(
                  fontFamily: _font,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: muted,
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredArticles.isEmpty
                ? Center(
                    child: Text(
                      UiText.t(context, 'No articles found'),
                      style: TextStyle(fontFamily: _font, color: muted, fontSize: 15),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    itemCount: filteredArticles.length,
                    itemBuilder: (context, index) {
                      final article = filteredArticles[index];
                      final category = AppRepository.theoryCategories.firstWhere(
                        (c) => c.id == article.category,
                        orElse: () => AppRepository.theoryCategories.first,
                      );
                      final catColor = Color(int.parse(category.colorHex.replaceFirst('#', '0xFF')));
                      final difficultyColor = _difficultyColor(article.difficulty);
                      final summary = LocalizedContent.articleSummary(context, article);
                      final difficultyLabel =
                          LocalizedContent.quizDifficulty(context, article.difficulty);

                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article)),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: catColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  _categoryIcon(category.iconName),
                                  color: catColor,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            LocalizedContent.theoryCategoryName(
                                              context,
                                              category.id,
                                              category.name,
                                            ),
                                            style: TextStyle(
                                              fontFamily: _font,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: catColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: difficultyColor.withOpacity(0.12),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            difficultyLabel,
                                            style: TextStyle(
                                              fontFamily: _font,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: difficultyColor,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      LocalizedContent.articleTitle(context, article),
                                      style: TextStyle(
                                        fontFamily: _font,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        height: 1.3,
                                        color: titleColor,
                                      ),
                                    ),
                                    if (summary.isNotEmpty) ...[
                                      const SizedBox(height: 6),
                                      Text(
                                        summary,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: _font,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          height: 1.4,
                                          color: muted,
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 8),
                                    Text(
                                      '${article.readTimeMinutes} ${UiText.t(context, 'min read')}',
                                      style: TextStyle(
                                        fontFamily: _font,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: muted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Padding(
                                padding: EdgeInsets.only(top: 14),
                                child: Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF94A3B8)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Color _difficultyColor(String difficulty) {
    switch (difficulty) {
      case 'beginner':
        return AppTheme.accentGreen;
      case 'journeyman':
        return AppTheme.accentOrange;
      case 'master':
        return AppTheme.accentRed;
      default:
        return AppTheme.primaryBlue;
    }
  }

  IconData _categoryIcon(String name) {
    switch (name) {
      case 'bolt':
        return Icons.bolt;
      case 'electrical_services':
        return Icons.electrical_services;
      case 'power':
        return Icons.power;
      case 'settings':
        return Icons.settings;
      case 'shield':
        return Icons.shield;
      case 'wb_sunny':
        return Icons.wb_sunny;
      case 'memory':
        return Icons.memory;
      case 'home':
        return Icons.home_outlined;
      case 'ev_station':
        return Icons.ev_station;
      default:
        return Icons.menu_book_outlined;
    }
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color? color;
  final String fontFamily;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    this.color,
    required this.fontFamily,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = color ?? AppTheme.primaryBlue;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? selectedColor : const Color(0xFFCBD5E1),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: fontFamily,
              color: isSelected ? Colors.white : const Color(0xFF64748B),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
