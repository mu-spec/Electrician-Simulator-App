import 'package:flutter/material.dart';
import '../../../core/utils/share_helper.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/localized_content.dart';
import '../../../core/localization/ui_text.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/database_service.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../models/theory_article.dart';

/// Clean, readable theory article view with clear heading hierarchy,
/// solid app-bar color (no scroll color-mix), and professional sections.
class ArticleDetailScreen extends StatefulWidget {
  final TheoryArticle article;
  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  bool _isBookmarked = false;
  double _scrollProgress = 0;
  final ScrollController _scrollController = ScrollController();

  /// Theory section uses Arial for clean, familiar technical reading.
  static const String _font = AppTheme.fontFamily;

  Color get _categoryColor {
    final category = AppRepository.theoryCategories.firstWhere(
      (c) => c.id == widget.article.category,
      orElse: () => AppRepository.theoryCategories.first,
    );
    return Color(int.parse(category.colorHex.replaceFirst('#', '0xFF')));
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadBookmarkState();
    DatabaseService.markArticleRead(widget.article.id);
  }

  Future<void> _loadBookmarkState() async {
    final bookmarked = await DatabaseService.isBookmarked(widget.article.id);
    if (mounted) setState(() => _isBookmarked = bookmarked);
  }

  Future<void> _toggleBookmark() async {
    if (_isBookmarked) {
      await DatabaseService.removeBookmark(widget.article.id);
    } else {
      await DatabaseService.addBookmark(widget.article.id, 'article');
    }
    if (!mounted) return;
    setState(() => _isBookmarked = !_isBookmarked);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBookmarked
              ? UiText.t(context, 'Article bookmarked')
              : UiText.t(context, 'Bookmark removed'),
          style: const TextStyle(fontFamily: _font),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _showNoteDialog() async {
    final existing =
        await DatabaseService.getNote(widget.article.id, 'article') ?? '';
    final controller = TextEditingController(text: existing);
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          UiText.t(context, 'Personal Note'),
          style: const TextStyle(fontFamily: _font),
        ),
        content: TextField(
          controller: controller,
          minLines: 5,
          maxLines: 10,
          style: const TextStyle(fontFamily: _font, fontSize: 15, height: 1.45),
          decoration: InputDecoration(
            hintText: UiText.t(
              context,
              'Write your field note, highlight, or reminder...',
            ),
            hintStyle: const TextStyle(fontFamily: _font),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              UiText.t(context, 'Cancel'),
              style: const TextStyle(fontFamily: _font),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await DatabaseService.saveNote(
                widget.article.id,
                'article',
                controller.text,
              );
              if (dialogContext.mounted) Navigator.pop(dialogContext);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      UiText.t(context, 'Note saved'),
                      style: const TextStyle(fontFamily: _font),
                    ),
                  ),
                );
              }
            },
            child: Text(
              UiText.t(context, 'Save'),
              style: const TextStyle(fontFamily: _font),
            ),
          ),
        ],
      ),
    );
    controller.dispose();
  }

  void _shareArticle() {
    final title = LocalizedContent.articleTitle(context, widget.article);
    final localizedContent = LocalizedContent.articleContent(
      context,
      widget.article,
    );
    final summary = widget.article.summary.isNotEmpty
        ? LocalizedContent.articleSummary(context, widget.article)
        : _excerpt(localizedContent);
    final appTitle = AppLocalizations.of(context).t('appTitle');
    shareText(
      context,
      text: '$title\n\n'
      '${UiText.t(context, 'Read time:')} ${widget.article.readTimeMinutes} '
      '${UiText.t(context, 'min')}\n\n'
      '$summary\n\n'
      '${UiText.t(context, 'Shared from')} $appTitle - '
      '${UiText.t(context, 'Electrical Engineering Companion')}',
      subject: title,
    );
  }

  String _excerpt(String content) {
    final plain = content
        .replaceAll(RegExp(r'[#*_>`|]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    return plain.length > 200 ? '${plain.substring(0, 200)}…' : plain;
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    if (max <= 0) return;
    final next = (_scrollController.offset / max).clamp(0.0, 1.0);
    if ((next - _scrollProgress).abs() > 0.01) {
      setState(() => _scrollProgress = next);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final localizedTitle = LocalizedContent.articleTitle(
      context,
      widget.article,
    );
    final localizedContent = LocalizedContent.articleContent(
      context,
      widget.article,
    );
    final category = AppRepository.theoryCategories.firstWhere(
      (c) => c.id == widget.article.category,
      orElse: () => AppRepository.theoryCategories.first,
    );
    final categoryColor = _categoryColor;
    final bodyColor = isDark
        ? const Color(0xFFE2E8F0)
        : const Color(0xFF1E293B);
    final mutedColor = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF8FAFC),
      // Solid app bar — avoids FlexibleSpaceBar title/background color mixing on scroll.
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: categoryColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          localizedTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: _font,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.25,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
              color: Colors.white,
            ),
            tooltip: UiText.t(context, 'Bookmark'),
            onPressed: _toggleBookmark,
          ),
          IconButton(
            icon: const Icon(Icons.note_alt_outlined, color: Colors.white),
            tooltip: UiText.t(context, 'Personal note'),
            onPressed: _showNoteDialog,
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            tooltip: UiText.t(context, 'Share'),
            onPressed: _shareArticle,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: LinearProgressIndicator(
            value: _scrollProgress.clamp(0, 1),
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 3,
          ),
        ),
      ),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        children: [
          // Meta row
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _MetaChip(
                label: LocalizedContent.theoryCategoryName(
                  context,
                  category.id,
                  category.name,
                ),
                color: categoryColor,
                fontFamily: _font,
              ),
              _MetaChip(
                label: LocalizedContent.quizDifficulty(
                  context,
                  widget.article.difficulty,
                ),
                color: _difficultyColor(widget.article.difficulty),
                fontFamily: _font,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule, size: 15, color: mutedColor),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.article.readTimeMinutes} ${UiText.t(context, 'min read')}',
                    style: TextStyle(
                      fontFamily: _font,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: mutedColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          if (LocalizedContent.articleSummary(
            context,
            widget.article,
          ).isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(isDark ? 0.15 : 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: categoryColor.withOpacity(0.25)),
              ),
              child: Text(
                LocalizedContent.articleSummary(context, widget.article),
                style: TextStyle(
                  fontFamily: _font,
                  fontSize: 14.5,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: bodyColor,
                ),
              ),
            ),
          ],

          const SizedBox(height: 20),
          const SizedBox(height: 20),
          // Body text with duplicate sections removed when info cards cover them.
          _buildContent(
            context,
            _contentWithoutDuplicateSections(localizedContent),
            bodyColor,
            mutedColor,
            isDark,
            categoryColor,
          ),

          // Single structured cards only (never repeated below body).
          ..._buildOnceOnlyInfoCards(isDark),

          const SizedBox(height: 28),
          Text(
            UiText.t(context, 'Related Articles'),
            style: TextStyle(
              fontFamily: _font,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: bodyColor,
            ),
          ),
          const SizedBox(height: 12),
          ..._relatedArticles().map(
            (a) => _RelatedArticleCard(article: a, fontFamily: _font),
          ),
        ],
      ),
    );
  }

  /// Which body headings to strip depends on which info cards we will show.
  Set<String> get _sectionsCoveredByCards {
    final covered = <String>{};

    String normalize(String value) => value
        .trim()
        .replaceAll(RegExp(r'[:：]+$'), '')
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), ' ');

    void addTitles(Iterable<String> titles) {
      for (final title in titles) {
        covered.add(normalize(title));
        covered.add(normalize(UiText.t(context, title)));
      }
    }

    if (widget.article.formulas.isNotEmpty) {
      addTitles(const [
        'Formulas',
        'Formula',
        'Formulas / Technical Notes',
        'Formulas/Technical Notes',
      ]);
    }
    if (widget.article.safetyNotes.isNotEmpty) {
      addTitles(const ['Safety', 'Safety Notes', 'Safety Note']);
    }
    if (widget.article.commonMistakes.isNotEmpty) {
      addTitles(const ['Common Mistakes', 'Common Mistake', 'Mistakes']);
    }
    if (widget.article.professionalTips.isNotEmpty) {
      addTitles(const [
        'Professional Tips',
        'Professional Tip',
        'Tips',
        'Pro Tips',
      ]);
    }
    if (widget.article.pecReferences.isNotEmpty) {
      addTitles(const [
        'Standards Note',
        'Standards',
        'Standard Note',
        'Standards Reference',
        'Standards Reference Note',
      ]);
    }
    return covered;
  }

  /// Remove body sections that are already shown as bottom info cards.
  String _contentWithoutDuplicateSections(String content) {
    final covered = _sectionsCoveredByCards;
    if (covered.isEmpty) return content.trim();

    final lines = content.replaceAll('\r\n', '\n').split('\n');
    final kept = <String>[];
    var skipping = false;

    for (final raw in lines) {
      final line = raw.trimRight();
      final headingMatch = RegExp(
        r'^#{2,3}\s+(.+)$',
      ).firstMatch(line.trimLeft());
      if (headingMatch != null) {
        final title = headingMatch
            .group(1)!
            .trim()
            .replaceAll(RegExp(r'[:：]+$'), '')
            .toLowerCase()
            .replaceAll(RegExp(r'\s+'), ' ');
        if (covered.contains(title)) {
          skipping = true;
          continue;
        }
        skipping = false;
        kept.add(line);
        continue;
      }
      if (!skipping) kept.add(line);
    }

    return kept.join('\n').replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
  }

  List<Widget> _buildOnceOnlyInfoCards(bool isDark) {
    final cards = <Widget>[];

    void addCard({
      required String title,
      required IconData icon,
      required Color color,
      required List<String> items,
    }) {
      if (items.isEmpty) return;
      cards.add(const SizedBox(height: 12));
      cards.add(
        _InfoCard(
          title: title,
          icon: icon,
          color: color,
          items: items,
          isDark: isDark,
          fontFamily: _font,
        ),
      );
    }

    addCard(
      title: UiText.t(context, 'Formulas'),
      icon: Icons.functions,
      color: AppTheme.primaryBlue,
      items: widget.article.formulas.map((e) => UiText.t(context, e)).toList(),
    );
    addCard(
      title: UiText.t(context, 'Safety Notes'),
      icon: Icons.health_and_safety_outlined,
      color: AppTheme.accentRed,
      items: widget.article.safetyNotes
          .map((e) => UiText.t(context, e))
          .toList(),
    );
    addCard(
      title: UiText.t(context, 'Common Mistakes'),
      icon: Icons.warning_amber_rounded,
      color: AppTheme.accentOrange,
      items: widget.article.commonMistakes
          .map((e) => UiText.t(context, e))
          .toList(),
    );
    addCard(
      title: UiText.t(context, 'Professional Tips'),
      icon: Icons.lightbulb_outline,
      color: AppTheme.accentGreen,
      items: widget.article.professionalTips
          .map((e) => UiText.t(context, e))
          .toList(),
    );
    addCard(
      title: UiText.t(context, 'Standards Note'),
      icon: Icons.gavel_outlined,
      color: const Color(0xFF64748B),
      items: widget.article.pecReferences
          .map((e) => UiText.t(context, e))
          .toList(),
    );

    if (cards.isEmpty) return const [];
    // Extra breathing room after article body before first card
    return [const SizedBox(height: 12), ...cards];
  }

  List<TheoryArticle> _relatedArticles() {
    final byId = {for (final a in AppRepository.theoryArticles) a.id: a};
    final related = <TheoryArticle>[];
    for (final id in widget.article.relatedArticleIds) {
      final a = byId[id];
      if (a != null && a.id != widget.article.id) related.add(a);
      if (related.length >= 3) break;
    }
    if (related.length < 2) {
      for (final a in AppRepository.theoryArticles) {
        if (a.category == widget.article.category &&
            a.id != widget.article.id &&
            !related.any((r) => r.id == a.id)) {
          related.add(a);
        }
        if (related.length >= 3) break;
      }
    }
    return related.take(3).toList();
  }

  Widget _buildContent(
    BuildContext context,
    String content,
    Color bodyColor,
    Color mutedColor,
    bool isDark,
    Color accent,
  ) {
    final blocks = _splitBlocks(content);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks.map((block) {
        final trimmed = block.trim();
        if (trimmed.isEmpty) return const SizedBox.shrink();

        if (trimmed.startsWith('## ')) {
          return Padding(
            padding: const EdgeInsets.only(top: 22, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trimmed.substring(3).trim(),
                  style: TextStyle(
                    fontFamily: _font,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: bodyColor,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 3,
                  width: 36,
                  color: accent,
                  margin: const EdgeInsets.only(bottom: 2),
                ),
              ],
            ),
          );
        }

        if (trimmed.startsWith('### ')) {
          return Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 6),
            child: Text(
              trimmed.substring(4).trim(),
              style: TextStyle(
                fontFamily: _font,
                fontSize: 16.5,
                fontWeight: FontWeight.w700,
                height: 1.35,
                color: isDark
                    ? const Color(0xFFF1F5F9)
                    : const Color(0xFF0F172A),
              ),
            ),
          );
        }

        if (trimmed.startsWith('|')) {
          return _buildTable(trimmed, isDark, bodyColor);
        }

        if (trimmed.startsWith('1. ') ||
            trimmed.startsWith('- ') ||
            trimmed.startsWith('• ')) {
          return _buildList(trimmed, bodyColor, accent);
        }

        // Bold-only short lines
        if (trimmed.startsWith('**') &&
            trimmed.endsWith('**') &&
            trimmed.indexOf('**', 2) == trimmed.length - 2) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              trimmed.substring(2, trimmed.length - 2),
              style: TextStyle(
                fontFamily: _font,
                fontSize: 15.5,
                fontWeight: FontWeight.w700,
                height: 1.45,
                color: bodyColor,
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _RichParagraph(
            text: trimmed,
            style: TextStyle(
              fontFamily: _font,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.65,
              color: bodyColor,
            ),
            boldStyle: TextStyle(
              fontFamily: _font,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              height: 1.65,
              color: bodyColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Split on blank lines, but keep list/table blocks together.
  List<String> _splitBlocks(String content) {
    final lines = content.replaceAll('\r\n', '\n').split('\n');
    final blocks = <String>[];
    final buffer = <String>[];

    void flush() {
      if (buffer.isEmpty) return;
      blocks.add(buffer.join('\n'));
      buffer.clear();
    }

    for (final raw in lines) {
      final line = raw.trimRight();
      if (line.trim().isEmpty) {
        flush();
        continue;
      }
      final isList = RegExp(r'^(\d+\.\s+|- |• )').hasMatch(line.trimLeft());
      final isTable = line.trimLeft().startsWith('|');
      final isHeading = line.trimLeft().startsWith('#');

      if (isHeading) {
        flush();
        blocks.add(line.trimLeft());
        continue;
      }

      if (buffer.isEmpty) {
        buffer.add(line);
        continue;
      }

      final prev = buffer.last.trimLeft();
      final prevList = RegExp(r'^(\d+\.\s+|- |• )').hasMatch(prev);
      final prevTable = prev.startsWith('|');

      if ((isList && prevList) || (isTable && prevTable)) {
        buffer.add(line);
      } else if (isList || isTable || prevList || prevTable) {
        flush();
        buffer.add(line);
      } else {
        buffer.add(line);
      }
    }
    flush();
    return blocks;
  }

  Widget _buildTable(String tableText, bool isDark, Color bodyColor) {
    final rows = tableText
        .split('\n')
        .map((r) => r.trim())
        .where((r) => r.isNotEmpty)
        .where((r) {
          // Skip markdown separator rows like |---|---|
          final cells = r.split('|').where((c) => c.trim().isNotEmpty).toList();
          if (cells.isEmpty) return false;
          final isSeparator = cells.every(
            (c) => RegExp(r'^:?-{2,}:?$').hasMatch(c.trim()),
          );
          return !isSeparator;
        })
        .toList();

    if (rows.length < 2) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
        ),
        borderRadius: BorderRadius.circular(10),
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Table(
          border: TableBorder(
            horizontalInside: BorderSide(
              color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
            ),
            verticalInside: BorderSide(
              color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
            ),
          ),
          children: rows.asMap().entries.map((entry) {
            final index = entry.key;
            final row = entry.value;
            final cells = row
                .split('|')
                .where((c) => c.trim().isNotEmpty)
                .toList();
            final isHeader = index == 0;
            return TableRow(
              decoration: BoxDecoration(
                color: isHeader
                    ? (isDark
                          ? const Color(0xFF334155)
                          : const Color(0xFFF1F5F9))
                    : Colors.transparent,
              ),
              children: cells.map((cell) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Text(
                    cell.trim(),
                    style: TextStyle(
                      fontFamily: _font,
                      fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
                      fontSize: isHeader ? 13 : 13,
                      height: 1.35,
                      color: bodyColor,
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildList(String listText, Color bodyColor, Color accent) {
    final items = listText
        .split('\n')
        .where((i) => i.trim().isNotEmpty)
        .toList();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          final raw = item.trimLeft();
          final cleanItem = raw
              .replaceFirst(RegExp(r'^\d+\.\s+'), '')
              .replaceFirst(RegExp(r'^[-•]\s+'), '');
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8, right: 10),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: _RichParagraph(
                    text: cleanItem,
                    style: TextStyle(
                      fontFamily: _font,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.55,
                      color: bodyColor,
                    ),
                    boldStyle: TextStyle(
                      fontFamily: _font,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      height: 1.55,
                      color: bodyColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
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
}

class _MetaChip extends StatelessWidget {
  final String label;
  final Color color;
  final String fontFamily;
  const _MetaChip({
    required this.label,
    required this.color,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
          color: color,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> items;
  final bool isDark;
  final String fontFamily;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
    required this.isDark,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '•  ',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 13.5,
                        height: 1.45,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? const Color(0xFFE2E8F0)
                            : const Color(0xFF334155),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _RichParagraph extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextStyle boldStyle;
  const _RichParagraph({
    required this.text,
    required this.style,
    required this.boldStyle,
  });

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'\*\*(.+?)\*\*');
    var start = 0;
    for (final match in regex.allMatches(text)) {
      if (match.start > start) {
        spans.add(
          TextSpan(text: text.substring(start, match.start), style: style),
        );
      }
      spans.add(TextSpan(text: match.group(1), style: boldStyle));
      start = match.end;
    }
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: style));
    }
    if (spans.isEmpty) {
      return Text(text, style: style);
    }
    return RichText(text: TextSpan(children: spans));
  }
}

class _RelatedArticleCard extends StatelessWidget {
  final TheoryArticle article;
  final String fontFamily;
  const _RelatedArticleCard({required this.article, required this.fontFamily});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ArticleDetailScreen(article: article),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocalizedContent.articleTitle(context, article),
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? const Color(0xFFF8FAFC)
                          : const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${article.readTimeMinutes} ${UiText.t(context, 'min')} · ${LocalizedContent.quizDifficulty(context, article.difficulty)}',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }
}
