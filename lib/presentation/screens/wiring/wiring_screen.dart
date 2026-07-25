import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/localized_content.dart';
import '../../../core/localization/ui_text.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../models/wiring_diagram.dart';
import 'diagram_detail_screen.dart';

class WiringScreen extends StatefulWidget {
  const WiringScreen({super.key});

  @override
  State<WiringScreen> createState() => _WiringScreenState();
}

class _WiringScreenState extends State<WiringScreen> {
  String _selectedCategory = 'all';
  String _searchQuery = '';

  List<WiringDiagram> get filteredDiagrams {
    var diagrams = AppRepository.wiringDiagrams;
    if (_selectedCategory != 'all') {
      diagrams = diagrams.where((d) => d.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase().trim();
      diagrams = diagrams.where((d) =>
        d.title.toLowerCase().contains(query) ||
        d.description.toLowerCase().contains(query) ||
        d.category.toLowerCase().contains(query) ||
        d.tags.any((tag) => tag.toLowerCase().contains(query)) ||
        d.keywords.any((keyword) => keyword.toLowerCase().contains(query)) ||
        d.components.any((component) => component.toLowerCase().contains(query))
      ).toList();
    }
    return diagrams;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.t('wiringDiagrams')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: l10n.t('searchDiagrams'),
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
                ...AppRepository.wiringCategories.map((cat) {
                  return _CategoryChip(
                    label: LocalizedContent.wiringCategoryName(context, cat.id, cat.name),
                    isSelected: _selectedCategory == cat.id,
                    color: Color(int.parse(cat.colorHex.replaceFirst('#', '0xFF'))),
                    onTap: () => setState(() => _selectedCategory = cat.id),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredDiagrams.length,
              itemBuilder: (context, index) {
                final diagram = filteredDiagrams[index];
                final category = AppRepository.wiringCategories.firstWhere(
                  (c) => c.id == diagram.category,
                );
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DiagramDetailScreen(diagram: diagram)),
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
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Color(int.parse(category.colorHex.replaceFirst('#', '0xFF'))).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            _getIconData(category.iconName),
                            color: Color(int.parse(category.colorHex.replaceFirst('#', '0xFF'))),
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocalizedContent.wiringTitle(context, diagram),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                LocalizedContent.wiringDescription(context, diagram),
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '${diagram.steps.length} ${UiText.t(context, 'steps')}',
                                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '${diagram.components.length} ${UiText.t(context, 'components')}',
                                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF94A3B8)),
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
      case 'toggle_on': return Icons.toggle_on;
      case 'power': return Icons.power;
      case 'settings': return Icons.settings;
      case 'account_tree': return Icons.account_tree;
      case 'home': return Icons.home_outlined;
      case 'wb_sunny': return Icons.wb_sunny;
      case 'router': return Icons.router;
      default: return Icons.electrical_services;
    }
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
