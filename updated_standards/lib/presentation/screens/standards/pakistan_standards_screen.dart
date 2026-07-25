import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/localized_content.dart';
import '../../../core/localization/ui_text.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../models/pakistan_standard.dart';
import '../calculators/calculator_detail_screen.dart';
import '../quiz/quiz_play_screen.dart';
import '../theory/article_detail_screen.dart';
import '../wiring/diagram_detail_screen.dart';

class PakistanStandardsScreen extends StatefulWidget {
  const PakistanStandardsScreen({super.key});

  @override
  State<PakistanStandardsScreen> createState() =>
      _PakistanStandardsScreenState();
}

class _PakistanStandardsScreenState extends State<PakistanStandardsScreen> {
  String _selectedCategory = 'all';
  String _searchQuery = '';

  List<PakistanStandard> get filteredStandards {
    var standards = AppRepository.pakistanStandards;
    if (_selectedCategory != 'all') {
      standards = standards
          .where((standard) => standard.category == _selectedCategory)
          .toList();
    }
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase().trim();
      standards = standards
          .where((standard) => standard.searchableText.contains(query))
          .toList();
    }
    return standards;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('pakistanStandards'))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: l10n.t('searchStandards'),
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
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _CategoryChip(
                  label: l10n.t('all'),
                  isSelected: _selectedCategory == 'all',
                  onTap: () => setState(() => _selectedCategory = 'all'),
                ),
                ...AppRepository.pakistanStandardCategories.map((category) {
                  return _CategoryChip(
                    label: LocalizedContent.standardCategoryName(
                      context,
                      category.id,
                      category.name,
                    ),
                    isSelected: _selectedCategory == category.id,
                    color: Color(
                      int.parse(category.colorHex.replaceFirst('#', '0xFF')),
                    ),
                    onTap: () =>
                        setState(() => _selectedCategory = category.id),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredStandards.length,
              itemBuilder: (context, index) {
                final standard = filteredStandards[index];
                final category = AppRepository.pakistanStandardCategories
                    .firstWhere((c) => c.id == standard.category);
                final color = Color(
                  int.parse(category.colorHex.replaceFirst('#', '0xFF')),
                );
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PakistanStandardDetailScreen(standard: standard),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF334155)
                            : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            _getIconData(category.iconName),
                            color: color,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocalizedContent.standardTitle(
                                  context,
                                  standard,
                                ),
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.copyWith(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                LocalizedContent.text(
                                  context,
                                  standard.authority,
                                ),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                LocalizedContent.standardSummary(
                                  context,
                                  standard,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: standard.tags
                                    .take(3)
                                    .map(
                                      (tag) => Chip(
                                        label: Text(
                                          LocalizedContent.text(context, tag),
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: color,
                                          ),
                                        ),
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        backgroundColor: color.withOpacity(0.12),
                                        side: BorderSide.none,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Color(0xFF94A3B8),
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

  IconData _getIconData(String name) {
    switch (name) {
      case 'gavel':
        return Icons.gavel;
      case 'security':
        return Icons.security;
      case 'power':
        return Icons.power;
      case 'wb_sunny':
        return Icons.wb_sunny;
      case 'health_and_safety':
        return Icons.health_and_safety;
      default:
        return Icons.policy_outlined;
    }
  }
}

class PakistanStandardDetailScreen extends StatelessWidget {
  final PakistanStandard standard;
  const PakistanStandardDetailScreen({super.key, required this.standard});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final category = AppRepository.pakistanStandardCategories.firstWhere(
      (c) => c.id == standard.category,
    );
    final color = Color(int.parse(category.colorHex.replaceFirst('#', '0xFF')));

    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizedContent.standardTitle(context, standard)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderCard(standard: standard, category: category, color: color),
            const SizedBox(height: 16),
            _InfoListCard(
              title: AppLocalizations.of(context).t('keyPoints'),
              icon: Icons.check_circle_outline,
              color: color,
              items: LocalizedContent.standardKeyPoints(context, standard),
            ),
            const SizedBox(height: 12),
            _InfoListCard(
              title: AppLocalizations.of(context).t('fieldChecklist'),
              icon: Icons.fact_check_outlined,
              color: AppTheme.accentGreen,
              items: LocalizedContent.standardFieldChecklist(context, standard),
            ),
            const SizedBox(height: 12),
            _InfoListCard(
              title: AppLocalizations.of(context).t('warnings'),
              icon: Icons.warning_amber,
              color: AppTheme.accentRed,
              items: LocalizedContent.standardWarnings(context, standard),
            ),
            const SizedBox(height: 20),
            _RelatedContentSection(standard: standard),
            const SizedBox(height: 24),
            Text(
              '${UiText.t(context, 'Last reviewed:')} ${standard.lastReviewed} • '
              '${UiText.t(context, 'Version:')} ${standard.contentVersion}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final PakistanStandard standard;
  final PakistanStandardCategory category;
  final Color color;

  const _HeaderCard({
    required this.standard,
    required this.category,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.72)]),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalizedContent.standardCategoryName(
              context,
              category.id,
              category.name,
            ),
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            LocalizedContent.standardTitle(context, standard),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            LocalizedContent.text(context, standard.authority),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            LocalizedContent.standardSummary(context, standard),
            style: const TextStyle(color: Colors.white, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _DisclaimerBanner extends StatelessWidget {
  final bool isDark;
  const _DisclaimerBanner({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF422006) : const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF92400E) : const Color(0xFFFDE68A),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: AppTheme.accentOrange,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              LocalizedContent.text(context, PakistanStandardsDisclaimer.text),
              style: const TextStyle(fontSize: 12, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoListCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> items;

  const _InfoListCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(color: color, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '• $item',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(height: 1.45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedContentSection extends StatelessWidget {
  final PakistanStandard standard;
  const _RelatedContentSection({required this.standard});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).t('relatedAppContent'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        ...standard.relatedArticleIds.map((id) {
          final matches = AppRepository.theoryArticles
              .where((a) => a.id == id)
              .toList();
          if (matches.isEmpty) return const SizedBox.shrink();
          final article = matches.first;
          return _RelatedTile(
            icon: Icons.menu_book,
            title: LocalizedContent.articleTitle(context, article),
            subtitle: UiText.t(context, 'Theory article'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ArticleDetailScreen(article: article),
              ),
            ),
          );
        }),
        ...standard.relatedCalculatorIds.map((id) {
          final matches = AppRepository.calculators
              .where((c) => c.id == id)
              .toList();
          if (matches.isEmpty) return const SizedBox.shrink();
          final calculator = matches.first;
          return _RelatedTile(
            icon: Icons.calculate,
            title: LocalizedContent.calculatorName(context, calculator),
            subtitle: UiText.t(context, 'Calculator'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CalculatorDetailScreen(calculator: calculator),
              ),
            ),
          );
        }),
        ...standard.relatedDiagramIds.map((id) {
          final matches = AppRepository.wiringDiagrams
              .where((d) => d.id == id)
              .toList();
          if (matches.isEmpty) return const SizedBox.shrink();
          final diagram = matches.first;
          return _RelatedTile(
            icon: Icons.account_tree,
            title: LocalizedContent.wiringTitle(context, diagram),
            subtitle: UiText.t(context, 'Wiring diagram'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DiagramDetailScreen(diagram: diagram),
              ),
            ),
          );
        }),
        ...standard.relatedQuizCategoryIds.map((id) {
          final matches = AppRepository.quizCategories
              .where((c) => c.id == id)
              .toList();
          if (matches.isEmpty) return const SizedBox.shrink();
          final category = matches.first;
          final questions = AppRepository.quizQuestions
              .where((q) => q.category == id)
              .toList();
          return _RelatedTile(
            icon: Icons.quiz,
            title: LocalizedContent.quizCategoryName(context, category),
            subtitle:
                '${questions.length} ${AppLocalizations.of(context).t('questions')}',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    QuizPlayScreen(category: category, questions: questions),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _RelatedTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RelatedTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primaryBlue),
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
        onTap: onTap,
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color? color;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    this.color,
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
              color: isSelected ? Colors.white : const Color(0xFF64748B),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
