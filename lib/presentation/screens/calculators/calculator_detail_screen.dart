import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/ads/ad_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/localized_content.dart';
import '../../../core/localization/ui_text.dart';
import '../../../data/database_service.dart';
import '../../../data/calculators/calculation_engine.dart';
import '../../../models/calculator_model.dart';

class CalculatorDetailScreen extends StatefulWidget {
  final CalculatorModel calculator;
  const CalculatorDetailScreen({super.key, required this.calculator});

  @override
  State<CalculatorDetailScreen> createState() => _CalculatorDetailScreenState();
}

class _CalculatorDetailScreenState extends State<CalculatorDetailScreen> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String> _results = {};
  bool _hasCalculated = false;

  @override
  void initState() {
    super.initState();
    for (final field in widget.calculator.inputFields) {
      _controllers[field.id] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _calculate() {
    final inputs = <String, double>{};
    for (final field in widget.calculator.inputFields) {
      final rawValue = _controllers[field.id]!.text.trim();
      if (rawValue.isEmpty) {
        if (field.isRequired) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                LocalizedContent.calculatorValidationMessage(
                  context,
                  field.label,
                  'required',
                ),
              ),
            ),
          );
          return;
        }
        continue;
      }

      final value = double.tryParse(rawValue);
      if (value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              LocalizedContent.calculatorValidationMessage(
                context,
                field.label,
                'valid',
              ),
            ),
          ),
        );
        return;
      }
      if (field.minValue != null && value < field.minValue!) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              field.validationMessage.isNotEmpty
                  ? LocalizedContent.text(context, field.validationMessage)
                  : LocalizedContent.calculatorRangeMessage(
                      context,
                      field.label,
                      field.minValue!,
                      minimum: true,
                    ),
            ),
          ),
        );
        return;
      }
      if (field.maxValue != null && value > field.maxValue!) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              field.validationMessage.isNotEmpty
                  ? LocalizedContent.text(context, field.validationMessage)
                  : LocalizedContent.calculatorRangeMessage(
                      context,
                      field.label,
                      field.maxValue!,
                      minimum: false,
                    ),
            ),
          ),
        );
        return;
      }
      inputs[field.id] = value;
    }

    try {
      final calculatedResults = CalculationEngine.calculate(
        widget.calculator,
        inputs,
      );
      setState(() {
        _results
          ..clear()
          ..addAll(calculatedResults);
        _hasCalculated = true;
      });

      // Interstitial every 2nd successful calculation (frequency capped).
      AdService.instance.onCalculatorResult();
    } on CalculationException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocalizedContent.text(context, error.message))),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            UiText.t(context, 'Unable to calculate. Please check inputs.'),
          ),
        ),
      );
    }
  }

  void _clearAll() {
    for (final controller in _controllers.values) {
      controller.clear();
    }
    setState(() {
      _results.clear();
      _hasCalculated = false;
    });
  }

  String _localizedFieldLabel(CalculatorField field) {
    final label = LocalizedContent.calculatorFieldLabel(context, field.label);
    final unit = field.unit.isNotEmpty ? ' (${field.unit})' : '';
    final optional = field.isRequired
        ? ''
        : ' - ${UiText.t(context, "optional")}';
    return '$label$unit$optional';
  }

  Future<void> _saveCalculation() async {
    if (!_hasCalculated) return;

    final inputs = _controllers.map((k, v) => MapEntry(k, v.text));
    await DatabaseService.saveCalculation({
      'calculator_id': widget.calculator.id,
      'calculator_name': widget.calculator.name,
      'inputs': inputs.toString(),
      'outputs': _results.toString(),
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(UiText.t(context, 'Calculation saved!'))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final primaryColor = Color(
      int.parse(widget.calculator.colorHex.replaceFirst('#', '0xFF')),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocalizedContent.calculatorName(context, widget.calculator),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _clearAll),
          if (_hasCalculated)
            IconButton(
              icon: const Icon(Icons.save_outlined),
              onPressed: _saveCalculation,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: primaryColor, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      LocalizedContent.calculatorDescription(
                        context,
                        widget.calculator,
                      ),
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? const Color(0xFFCBD5E1)
                            : const Color(0xFF475569),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Input Fields
            Text(
              l10n.t('inputs'),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...widget.calculator.inputFields.map((field) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: TextField(
                  controller: _controllers[field.id],
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  decoration: InputDecoration(
                    labelText: _localizedFieldLabel(field),
                    hintText: LocalizedContent.calculatorFieldHint(
                      context,
                      field.hint,
                    ),
                    suffixText: field.unit.isNotEmpty ? field.unit : null,
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
            // Calculate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _calculate,
                icon: const Icon(Icons.calculate),
                label: Text(l10n.t('calculate')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Results
            if (_hasCalculated) ...[
              Text(
                l10n.t('results'),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              ...widget.calculator.outputs.map((output) {
                final resultValue = _results[output.id] ?? 'N/A';
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF334155)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.accentGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          color: AppTheme.accentGreen,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocalizedContent.calculatorOutputLabel(
                                context,
                                output.label,
                              ),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              resultValue,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.accentGreen,
                              ),
                            ),
                            if (output.description.isNotEmpty)
                              Text(
                                LocalizedContent.calculatorOutputDescription(
                                  context,
                                  output.description,
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),
              // Formula
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.functions,
                      size: 18,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${l10n.t('formula')}: ${widget.calculator.formula}',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF64748B),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _CalculatorNotesCard(calculator: widget.calculator),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _CalculatorNotesCard extends StatelessWidget {
  final CalculatorModel calculator;
  const _CalculatorNotesCard({required this.calculator});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final notes = <String>[
      if (calculator.accuracyNote.isNotEmpty) calculator.accuracyNote,
      ...calculator.safetyNotes,
      ...calculator.professionalNotes,
    ];
    if (notes.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFFDE68A),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 18,
                color: isDark
                    ? const Color(0xFFFBBF24)
                    : const Color(0xFFD97706),
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context).t('professionalNotes'),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...notes
              .take(4)
              .map(
                (note) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    '• ${LocalizedContent.text(context, note)}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(height: 1.45),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
