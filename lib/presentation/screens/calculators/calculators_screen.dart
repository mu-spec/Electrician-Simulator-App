import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/localized_content.dart';
import '../../../core/localization/ui_text.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/repositories/app_repository.dart';
import '../../../models/calculator_model.dart';
import '../settings/saved_calculations_screen.dart';
import 'calculator_detail_screen.dart';

class CalculatorsScreen extends StatefulWidget {
  const CalculatorsScreen({super.key});

  @override
  State<CalculatorsScreen> createState() => _CalculatorsScreenState();
}

class _CalculatorsScreenState extends State<CalculatorsScreen> {
  String _selectedCategory = 'all';
  String _searchQuery = '';

  List<CalculatorModel> get filteredCalculators {
    var calcs = AppRepository.calculators;
    if (_selectedCategory != 'all') {
      calcs = calcs.where((c) => c.category == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase().trim();
      calcs = calcs
          .where(
            (c) =>
                c.name.toLowerCase().contains(query) ||
                c.description.toLowerCase().contains(query) ||
                c.category.toLowerCase().contains(query) ||
                c.formula.toLowerCase().contains(query) ||
                c.tags.any((tag) => tag.toLowerCase().contains(query)) ||
                c.keywords.any(
                  (keyword) => keyword.toLowerCase().contains(query),
                ),
          )
          .toList();
    }
    return calcs;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final items = filteredCalculators;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.t('calculators')),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: UiText.t(context, 'Saved calculations'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SavedCalculationsScreen(),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: l10n.t('searchCalculators'),
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
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _CategoryChip(
                  label: l10n.t('all'),
                  isSelected: _selectedCategory == 'all',
                  onTap: () => setState(() => _selectedCategory = 'all'),
                ),
                ...AppRepository.calculatorCategories.map(
                  (cat) => _CategoryChip(
                    label: LocalizedContent.calculatorCategoryName(
                      context,
                      cat.id,
                      cat.name,
                    ),
                    isSelected: _selectedCategory == cat.id,
                    color: Color(
                      int.parse(cat.colorHex.replaceFirst('#', '0xFF')),
                    ),
                    onTap: () => setState(() => _selectedCategory = cat.id),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const _NoCalculatorsFound()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    itemCount: items.length,
                    itemBuilder: (context, index) => _CalculatorListCard(
                      calculator: items[index],
                      isDark: isDark,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _CalculatorListCard extends StatelessWidget {
  final CalculatorModel calculator;
  final bool isDark;
  const _CalculatorListCard({required this.calculator, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final color = Color(
      int.parse(calculator.colorHex.replaceFirst('#', '0xFF')),
    );
    final category = AppRepository.calculatorCategories
        .where((c) => c.id == calculator.category)
        .toList();
    final categoryName = category.isEmpty
        ? calculator.category
        : LocalizedContent.calculatorCategoryName(
            context,
            category.first.id,
            category.first.name,
          );

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.grey.withOpacity(0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CalculatorDetailScreen(calculator: calculator),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(_getIcon(calculator.iconName), color: color),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              categoryName,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            LocalizedContent.calculatorOutputLabel(
                              context,
                              calculator.outputs.isNotEmpty ? calculator.outputs.first.label : '',
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white54 : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        LocalizedContent.calculatorName(context, calculator),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        LocalizedContent.calculatorDescription(
                          context,
                          calculator,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.white60 : Colors.grey[600],
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  color: isDark ? Colors.white38 : Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIcon(String name) {
    switch (name) {
      case 'bolt':
        return Icons.bolt;
      case 'power':
        return Icons.power;
      case 'trending_down':
        return Icons.trending_down;
      case 'straighten':
        return Icons.straighten;
      case 'settings_input_component':
        return Icons.settings_input_component;
      case 'transform':
        return Icons.transform;
      case 'solar_power':
        return Icons.solar_power;
      case 'shield':
        return Icons.shield;
      case 'electrical_services':
        return Icons.electrical_services;
      case 'precision_manufacturing':
        return Icons.precision_manufacturing;
      case 'battery_charging_full':
        return Icons.battery_charging_full;
      case 'build':
        return Icons.build;
      case 'cable':
        return Icons.cable;
      case 'settings_power':
        return Icons.settings_power;
      case 'speed':
        return Icons.speed;
      case 'biotech':
        return Icons.biotech;
      case 'waves':
        return Icons.waves;
      case 'tune':
        return Icons.tune;
      case 'router':
        return Icons.router;
      case 'flash_on':
        return Icons.flash_on;
      case 'schema':
        return Icons.schema;
      case 'lightbulb':
        return Icons.lightbulb;
      case 'memory':
        return Icons.memory;
      case 'engineering':
        return Icons.engineering;
      case 'factory':
        return Icons.factory;
      case 'hub':
        return Icons.router;
      case 'solar_power_outlined':
        return Icons.solar_power_outlined;
      case 'local_fire_department':
        return Icons.local_fire_department;
      case 'developer_board':
        return Icons.developer_board;
      case 'security':
        return Icons.security;
      case 'highlight':
        return Icons.highlight;
      case 'ev_station':
        return Icons.ev_station;
      case 'calculate':
        return Icons.calculate;
      default:
        return Icons.calculate;
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
    final activeColor = color ?? AppTheme.primaryBlue;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        backgroundColor: Theme.of(context).cardTheme.color,
        selectedColor: activeColor.withOpacity(0.15),
        checkmarkColor: activeColor,
        labelStyle: TextStyle(
          color: isSelected
              ? activeColor
              : (Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.grey[700]),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          fontSize: 13,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isSelected
                ? activeColor
                : (Theme.of(context).brightness == Brightness.dark
                    ? Colors.white12
                    : Colors.grey.withOpacity(0.2)),
          ),
        ),
      ),
    );
  }
}

class _NoCalculatorsFound extends StatelessWidget {
  const _NoCalculatorsFound();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            UiText.t(context, 'No calculators found'),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            UiText.t(context, 'Try a different keyword or category.'),
            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}