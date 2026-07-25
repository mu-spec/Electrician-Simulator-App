import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/ui_text.dart';
import '../../../data/database_service.dart';

class ResistorScannerScreen extends StatefulWidget {
  const ResistorScannerScreen({super.key});

  @override
  State<ResistorScannerScreen> createState() => _ResistorScannerScreenState();
}

class _ResistorScannerScreenState extends State<ResistorScannerScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _photo;
  int _bandMode = 4;
  String _band1 = 'brown';
  String _band2 = 'black';
  String _band3 = 'red';
  String _multiplier = 'red';
  String _tolerance = 'gold';
  bool _saved = false;

  _Band get b1 => _BandData.byKey(_band1);
  _Band get b2 => _BandData.byKey(_band2);
  _Band get b3 => _BandData.byKey(_band3);
  _Band get mult => _BandData.byKey(_multiplier);
  _Band get tol => _BandData.byKey(_tolerance);

  double get resistanceOhms {
    final base = _bandMode == 4
        ? (b1.digit! * 10 + b2.digit!).toDouble()
        : (b1.digit! * 100 + b2.digit! * 10 + b3.digit!).toDouble();
    return base * mult.multiplier!;
  }

  String get resistanceText => _formatResistance(resistanceOhms);
  String get toleranceText => '±${tol.toleranceText}';
  double get minOhms => resistanceOhms * (1 - (tol.tolerance ?? 0) / 100);
  double get maxOhms => resistanceOhms * (1 + (tol.tolerance ?? 0) / 100);

  Future<void> _pickPhoto(ImageSource source) async {
    final image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1600,
    );
    if (image == null) return;
    setState(() => _photo = File(image.path));
  }

  Future<void> _saveResult() async {
    await DatabaseService.saveCalculation({
      'calculator_id': 'resistor_scanner',
      'calculator_name': UiText.t(context, 'Resistor Color Code'),
      'inputs': _bandMode == 4
          ? '4-band: ${b1.name}, ${b2.name}, ${mult.name}, ${tol.name}'
          : '5-band: ${b1.name}, ${b2.name}, ${b3.name}, ${mult.name}, ${tol.name}',
      'outputs':
          'Resistance: $resistanceText, Tolerance: $toleranceText, Range: ${_formatResistance(minOhms)} - ${_formatResistance(maxOhms)}',
    });
    if (!mounted) return;
    setState(() => _saved = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          UiText.t(context, 'Resistor result saved to calculation history'),
        ),
      ),
    );
  }

  Future<void> _shareResult() async {
    final appTitle = AppLocalizations.of(context).t('appTitle');
    final message = StringBuffer()
      ..writeln('$appTitle ${UiText.t(context, 'Resistor Result')}')
      ..writeln()
      ..writeln(
        '${UiText.t(context, 'Mode:')} $_bandMode-${UiText.t(context, 'band')}',
      )
      ..writeln(
        '${UiText.t(context, 'Bands:')} ${_selectedBandNames().join(', ')}',
      )
      ..writeln('${UiText.t(context, 'Resistance:')} $resistanceText')
      ..writeln('${UiText.t(context, 'Tolerance:')} $toleranceText')
      ..writeln(
        '${UiText.t(context, 'Range:')} ${_formatResistance(minOhms)} '
        '${UiText.t(context, 'to')} ${_formatResistance(maxOhms)}',
      )
      ..writeln()
      ..writeln(
        UiText.t(
          context,
          'Educational reference only. Verify component value with a meter where critical.',
        ),
      );
    await Share.share(
      message.toString(),
      subject: UiText.t(context, 'Resistor Color Code Result'),
    );
  }

  List<String> _selectedBandNames() => _bandMode == 4
      ? [
          UiText.t(context, b1.name),
          UiText.t(context, b2.name),
          UiText.t(context, mult.name),
          UiText.t(context, tol.name),
        ]
      : [
          UiText.t(context, b1.name),
          UiText.t(context, b2.name),
          UiText.t(context, b3.name),
          UiText.t(context, mult.name),
          UiText.t(context, tol.name),
        ];

  void _resetDefaults() {
    setState(() {
      _bandMode = 4;
      _band1 = 'brown';
      _band2 = 'black';
      _band3 = 'red';
      _multiplier = 'red';
      _tolerance = 'gold';
      _saved = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(UiText.t(context, 'Manual Resistor Band Reader')),
        actions: [
          IconButton(
            onPressed: _resetDefaults,
            icon: const Icon(Icons.refresh),
            tooltip: UiText.t(context, 'Reset'),
          ),
          IconButton(
            onPressed: _shareResult,
            icon: const Icon(Icons.share_outlined),
            tooltip: UiText.t(context, 'Share'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _HeaderCard(isDark: isDark),
          const SizedBox(height: 16),
          _PhotoCard(
            photo: _photo,
            onCamera: () => _pickPhoto(ImageSource.camera),
            onGallery: () => _pickPhoto(ImageSource.gallery),
          ),
          const SizedBox(height: 16),
          _ModeSelector(
            value: _bandMode,
            onChanged: (value) => setState(() => _bandMode = value),
          ),
          const SizedBox(height: 16),
          _SectionTitle(
            UiText.t(
              context,
              _bandMode == 4 ? 'Select 4 Color Bands' : 'Select 5 Color Bands',
            ),
          ),
          _BandDropdown(
            label: UiText.t(context, 'Band 1 — First digit'),
            value: _band1,
            bands: _BandData.digitBands,
            onChanged: (v) => setState(() => _band1 = v),
          ),
          _BandDropdown(
            label: UiText.t(context, 'Band 2 — Second digit'),
            value: _band2,
            bands: _BandData.digitBands,
            onChanged: (v) => setState(() => _band2 = v),
          ),
          if (_bandMode == 5)
            _BandDropdown(
              label: UiText.t(context, 'Band 3 — Third digit'),
              value: _band3,
              bands: _BandData.digitBands,
              onChanged: (v) => setState(() => _band3 = v),
            ),
          _BandDropdown(
            label: UiText.t(
              context,
              _bandMode == 4 ? 'Band 3 — Multiplier' : 'Band 4 — Multiplier',
            ),
            value: _multiplier,
            bands: _BandData.multiplierBands,
            onChanged: (v) => setState(() => _multiplier = v),
          ),
          _BandDropdown(
            label: UiText.t(
              context,
              _bandMode == 4 ? 'Band 4 — Tolerance' : 'Band 5 — Tolerance',
            ),
            value: _tolerance,
            bands: _BandData.toleranceBands,
            onChanged: (v) => setState(() => _tolerance = v),
          ),
          const SizedBox(height: 18),
          _ResultCard(
            resistance: resistanceText,
            tolerance: toleranceText,
            min: _formatResistance(minOhms),
            max: _formatResistance(maxOhms),
            bandColors: _selectedBandNames(),
            bandValues: _bandMode == 4
                ? [b1.color, b2.color, mult.color, tol.color]
                : [b1.color, b2.color, b3.color, mult.color, tol.color],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _saveResult,
                  icon: Icon(_saved ? Icons.check : Icons.save_outlined),
                  label: Text(
                    UiText.t(context, _saved ? 'Saved' : 'Save Result'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _shareResult,
                  icon: const Icon(Icons.share),
                  label: Text(UiText.t(context, 'Share')),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _GuideCard(isDark: isDark),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final bool isDark;
  const _HeaderCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F766E), Color(0xFF10B981)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.palette, color: Colors.white, size: 42),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  UiText.t(context, 'Resistor Color Code Tool'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  UiText.t(
                    context,
                    'Camera-assisted manual band picker for accurate 4-band and 5-band resistor decoding.',
                  ),
                  style: TextStyle(color: Colors.white70, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  final File? photo;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  const _PhotoCard({
    required this.photo,
    required this.onCamera,
    required this.onGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).dividerTheme.color ?? Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            UiText.t(context, 'Reference Photo'),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          if (photo != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.file(
                photo!,
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  UiText.t(
                    context,
                    'Take or choose a resistor photo, then select bands manually.

The photo is used only as a visual reference. Color bands must be selected manually.',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onCamera,
                  icon: const Icon(Icons.camera_alt),
                  label: Text(UiText.t(context, 'Camera')),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onGallery,
                  icon: const Icon(Icons.photo_library),
                  label: Text(UiText.t(context, 'Gallery')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ModeSelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  const _ModeSelector({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<int>(
      segments: [
        ButtonSegment(
          value: 4,
          label: Text(UiText.t(context, '4-Band')),
          icon: Icon(Icons.looks_4),
        ),
        ButtonSegment(
          value: 5,
          label: Text(UiText.t(context, '5-Band')),
          icon: Icon(Icons.looks_5),
        ),
      ],
      selected: {value},
      onSelectionChanged: (set) => onChanged(set.first),
    );
  }
}

class _BandDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<_Band> bands;
  final ValueChanged<String> onChanged;
  const _BandDropdown({
    required this.label,
    required this.value,
    required this.bands,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(labelText: label),
        items: bands
            .map(
              (band) => DropdownMenuItem(
                value: band.key,
                child: Row(
                  children: [
                    _Swatch(color: band.color),
                    const SizedBox(width: 10),
                    Text(UiText.t(context, band.name)),
                    const Spacer(),
                    Text(
                      band.displayValue,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String resistance;
  final String tolerance;
  final String min;
  final String max;
  final List<String> bandColors;
  final List<Color> bandValues;
  const _ResultCard({
    required this.resistance,
    required this.tolerance,
    required this.min,
    required this.max,
    required this.bandColors,
    required this.bandValues,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.accentGreen.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.accentGreen.withOpacity(0.24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            UiText.t(context, 'Decoded Result'),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          Center(
            child: Container(
              width: 230,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFEAB308),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFF92400E), width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: bandValues
                    .map((c) => Container(width: 14, height: 58, color: c))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _ResultRow(UiText.t(context, 'Resistance'), resistance, bold: true),
          _ResultRow(UiText.t(context, 'Tolerance'), tolerance),
          _ResultRow(UiText.t(context, 'Minimum'), min),
          _ResultRow(UiText.t(context, 'Maximum'), max),
          const SizedBox(height: 8),
          Text(
            '${UiText.t(context, 'Bands:')} ${bandColors.join(', ')}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  final bool isDark;
  const _GuideCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFFDE68A),
        ),
      ),
      child: Text(
        UiText.t(
          context,
          'Professional note: Camera auto-detection is intentionally not used in this beta because resistor bands are small and lighting can cause wrong readings. Use the photo as a reference, select bands manually, and verify critical components with a multimeter.',
        ),
        style: const TextStyle(fontSize: 12, height: 1.45),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  const _ResultRow(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w700 : FontWeight.w700,
              fontSize: bold ? 20 : 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text, style: Theme.of(context).textTheme.titleLarge),
  );
}

class _Swatch extends StatelessWidget {
  final Color color;
  const _Swatch({required this.color});
  @override
  Widget build(BuildContext context) => Container(
    width: 24,
    height: 24,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.black26),
    ),
  );
}

class _Band {
  final String key;
  final String name;
  final Color color;
  final int? digit;
  final double? multiplier;
  final double? tolerance;
  const _Band({
    required this.key,
    required this.name,
    required this.color,
    this.digit,
    this.multiplier,
    this.tolerance,
  });

  String get displayValue {
    if (digit != null && multiplier == null && tolerance == null)
      return '$digit';
    if (multiplier != null && digit == null)
      return '×${_formatMultiplier(multiplier!)}';
    if (tolerance != null) return '±$toleranceText';
    return '';
  }

  String get toleranceText => tolerance == null
      ? ''
      : '${tolerance!.toString().replaceAll(RegExp(r'\.0$'), '')}%';
}

class _BandData {
  static const List<_Band> all = [
    _Band(
      key: 'black',
      name: 'Black',
      color: Colors.black,
      digit: 0,
      multiplier: 1,
    ),
    _Band(
      key: 'brown',
      name: 'Brown',
      color: Color(0xFF7C2D12),
      digit: 1,
      multiplier: 10,
      tolerance: 1,
    ),
    _Band(
      key: 'red',
      name: 'Red',
      color: Color(0xFFDC2626),
      digit: 2,
      multiplier: 100,
      tolerance: 2,
    ),
    _Band(
      key: 'orange',
      name: 'Orange',
      color: Color(0xFFF97316),
      digit: 3,
      multiplier: 1000,
    ),
    _Band(
      key: 'yellow',
      name: 'Yellow',
      color: Color(0xFFEAB308),
      digit: 4,
      multiplier: 10000,
    ),
    _Band(
      key: 'green',
      name: 'Green',
      color: Color(0xFF16A34A),
      digit: 5,
      multiplier: 100000,
      tolerance: 0.5,
    ),
    _Band(
      key: 'blue',
      name: 'Blue',
      color: Color(0xFF2563EB),
      digit: 6,
      multiplier: 1000000,
      tolerance: 0.25,
    ),
    _Band(
      key: 'violet',
      name: 'Violet',
      color: Color(0xFF7C3AED),
      digit: 7,
      multiplier: 10000000,
      tolerance: 0.1,
    ),
    _Band(
      key: 'grey',
      name: 'Grey',
      color: Color(0xFF6B7280),
      digit: 8,
      multiplier: 100000000,
      tolerance: 0.05,
    ),
    _Band(
      key: 'white',
      name: 'White',
      color: Colors.white,
      digit: 9,
      multiplier: 1000000000,
    ),
    _Band(
      key: 'gold',
      name: 'Gold',
      color: Color(0xFFD4AF37),
      multiplier: 0.1,
      tolerance: 5,
    ),
    _Band(
      key: 'silver',
      name: 'Silver',
      color: Color(0xFFC0C0C0),
      multiplier: 0.01,
      tolerance: 10,
    ),
  ];

  static List<_Band> get digitBands =>
      all.where((b) => b.digit != null).toList();
  static List<_Band> get multiplierBands =>
      all.where((b) => b.multiplier != null).toList();
  static List<_Band> get toleranceBands =>
      all.where((b) => b.tolerance != null).toList();
  static _Band byKey(String key) => all.firstWhere((b) => b.key == key);
}

String _formatResistance(double ohms) {
  if (!ohms.isFinite) return 'N/A';
  if (ohms >= 1000000) return '${_trim(ohms / 1000000)} MΩ';
  if (ohms >= 1000) return '${_trim(ohms / 1000)} kΩ';
  return '${_trim(ohms)} Ω';
}

String _trim(double value) {
  var fixed = value.toStringAsFixed(
    value >= 100
        ? 0
        : value >= 10
        ? 1
        : 2,
  );
  if (fixed.contains('.')) {
    while (fixed.endsWith('0')) {
      fixed = fixed.substring(0, fixed.length - 1);
    }
    if (fixed.endsWith('.')) fixed = fixed.substring(0, fixed.length - 1);
  }
  return fixed;
}

String _formatMultiplier(double value) {
  if (value >= 1000000) return '${_trim(value / 1000000)}M';
  if (value >= 1000) return '${_trim(value / 1000)}k';
  return _trim(value);
}
