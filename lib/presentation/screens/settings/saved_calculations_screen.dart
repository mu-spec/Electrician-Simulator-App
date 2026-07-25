import '../../../core/localization/ui_text.dart';
import '../../../core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/database_service.dart';

class SavedCalculationsScreen extends StatefulWidget {
  const SavedCalculationsScreen({super.key});

  @override
  State<SavedCalculationsScreen> createState() =>
      _SavedCalculationsScreenState();
}

class _SavedCalculationsScreenState extends State<SavedCalculationsScreen> {
  List<Map<String, dynamic>> _calculations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCalculations();
  }

  Future<void> _loadCalculations() async {
    final calcs = await DatabaseService.getSavedCalculations();
    if (mounted) {
      setState(() {
        _calculations = calcs;
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteCalculation(int id) async {
    await DatabaseService.deleteSavedCalculation(id);
    await _loadCalculations();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(UiText.t(context, 'Calculation deleted'))),
      );
    }
  }

  String _formatDate(BuildContext context, int millis) {
    final date = DateTime.fromMillisecondsSinceEpoch(millis);
    final locale = AppLocalizations.of(context).code;
    return DateFormat.yMMMd(locale).add_jm().format(date);
  }

  String _prettyMap(String raw) {
    // Stored as "{key: value, key2: value2}" – strip braces for display
    return raw.replaceAll(RegExp(r'^\{|\}$'), '').trim();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text(UiText.t(context, 'Saved Calculations'))),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _calculations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calculate_outlined,
                    size: 64,
                    color: isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFFCBD5E1),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    UiText.t(context, 'No saved calculations yet'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    UiText.t(
                      context,
                      'Use any calculator and tap the save icon\nto keep your results here.',
                    ),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: _calculations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final calc = _calculations[index];
                return Dismissible(
                  key: ValueKey(calc['id']),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: AppTheme.accentRed,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _deleteCalculation(calc['id'] as int),
                  child: Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.calculate_rounded,
                                color: AppTheme.primaryBlue,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                UiText.t(
                                  context,
                                  calc['calculator_name'] as String? ??
                                      'Calculation',
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _InfoRow(
                          label: UiText.t(context, 'Inputs'),
                          value: _prettyMap(calc['inputs'] as String? ?? ''),
                        ),
                        const SizedBox(height: 6),
                        _InfoRow(
                          label: UiText.t(context, 'Results'),
                          value: _prettyMap(calc['outputs'] as String? ?? ''),
                          highlight: true,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _formatDate(context, calc['created_at'] as int? ?? 0),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _InfoRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(label, style: Theme.of(context).textTheme.bodySmall),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: highlight ? FontWeight.w600 : FontWeight.normal,
              color: highlight ? AppTheme.accentGreen : null,
            ),
          ),
        ),
      ],
    );
  }
}
