import '../../../core/localization/ui_text.dart';
import '../../../core/localization/localized_content.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/database_service.dart';
import '../../../data/repositories/app_repository.dart';
import '../theory/article_detail_screen.dart';
import '../wiring/diagram_detail_screen.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<String> _articleIds = [];
  List<String> _diagramIds = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final articles = await DatabaseService.getBookmarks('article');
    final diagrams = await DatabaseService.getBookmarks('diagram');
    if (mounted) {
      setState(() {
        _articleIds = articles;
        _diagramIds = diagrams;
        _isLoading = false;
      });
    }
  }

  Future<void> _removeBookmark(String id) async {
    await DatabaseService.removeBookmark(id);
    await _loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final articles = AppRepository.theoryArticles
        .where((a) => _articleIds.contains(a.id))
        .toList();
    final diagrams = AppRepository.wiringDiagrams
        .where((d) => _diagramIds.contains(d.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(UiText.t(context, 'Bookmarks'))),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : (articles.isEmpty && diagrams.isEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_outline,
                    size: 64,
                    color: isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFFCBD5E1),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    UiText.t(context, 'No bookmarks yet'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    UiText.t(
                      context,
                      'Bookmark articles and wiring diagrams\nto find them quickly here.',
                    ),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                if (articles.isNotEmpty) ...[
                  Text(
                    UiText.t(context, 'Theory Articles'),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...articles.map(
                    (article) => _BookmarkTile(
                      icon: Icons.menu_book_rounded,
                      iconColor: AppTheme.primaryBlue,
                      title: LocalizedContent.articleTitle(context, article),
                      subtitle:
                          '${article.readTimeMinutes} ${UiText.t(context, 'min read')}',
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ArticleDetailScreen(article: article),
                          ),
                        );
                        _loadBookmarks();
                      },
                      onRemove: () => _removeBookmark(article.id),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                if (diagrams.isNotEmpty) ...[
                  Text(
                    UiText.t(context, 'Wiring Diagrams'),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...diagrams.map(
                    (diagram) => _BookmarkTile(
                      icon: Icons.account_tree_rounded,
                      iconColor: AppTheme.accentOrange,
                      title: LocalizedContent.wiringTitle(context, diagram),
                      subtitle:
                          '${diagram.steps.length} ${UiText.t(context, 'steps')}',
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DiagramDetailScreen(diagram: diagram),
                          ),
                        );
                        _loadBookmarks();
                      },
                      onRemove: () => _removeBookmark(diagram.id),
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}

class _BookmarkTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _BookmarkTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        trailing: IconButton(
          icon: const Icon(Icons.bookmark_remove_outlined, size: 20),
          tooltip: UiText.t(context, 'Remove bookmark'),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
