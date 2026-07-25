import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/ui_text.dart';
import '../../../data/database_service.dart';

class InvoiceGeneratorScreen extends StatefulWidget {
  final Map<String, dynamic> project;
  const InvoiceGeneratorScreen({super.key, required this.project});

  @override
  State<InvoiceGeneratorScreen> createState() => _InvoiceGeneratorScreenState();
}

class _InvoiceGeneratorScreenState extends State<InvoiceGeneratorScreen> {
  final TextEditingController _invoiceNo = TextEditingController();
  final TextEditingController _businessName = TextEditingController(text: 'Electrician Simulator App Electrical Services');
  final TextEditingController _businessPhone = TextEditingController();
  final TextEditingController _businessAddress = TextEditingController();
  final TextEditingController _taxPercent = TextEditingController(text: '0');
  final TextEditingController _discount = TextEditingController(text: '0');
  final TextEditingController _terms = TextEditingController(text: 'Payment due upon completion. This invoice is generated from Electrician Simulator App.');
  late Future<List<Map<String, dynamic>>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _invoiceNo.text = 'VMP-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';
    _itemsFuture = DatabaseService.getProjectItems(widget.project['id'] as int);
  }

  @override
  void dispose() {
    _invoiceNo.dispose();
    _businessName.dispose();
    _businessPhone.dispose();
    _businessAddress.dispose();
    _taxPercent.dispose();
    _discount.dispose();
    _terms.dispose();
    super.dispose();
  }

  double _num(String value) => double.tryParse(value.trim()) ?? 0;

  Future<Uint8List> _buildPdf(List<Map<String, dynamic>> items) async {
    final pdf = pw.Document();
    final materialTotal = _itemsTotal(items, 'material');
    final laborTotal = _itemsTotal(items, 'labor');
    final subtotal = materialTotal + laborTotal;
    final discount = _num(_discount.text);
    final tax = (subtotal - discount).clamp(0, double.infinity) * _num(_taxPercent.text) / 100;
    final grandTotal = subtotal - discount + tax;

    pdf.addPage(
      pw.MultiPage(
        pageTheme: const pw.PageTheme(margin: pw.EdgeInsets.all(32)),
        build: (pwContext) => [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(_businessName.text.trim().isEmpty ? 'Electrician Simulator App Electrical Services' : _businessName.text.trim(), style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, color: PdfColors.blue800)),
                  if (_businessPhone.text.trim().isNotEmpty) pw.Text('${UiText.t(context, 'Phone:')} ${_businessPhone.text.trim()}'),
                  if (_businessAddress.text.trim().isNotEmpty) pw.Text(_businessAddress.text.trim()),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(UiText.t(context, 'INVOICE'), style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold)),
                  pw.Text('${UiText.t(context, 'No:')} ${_invoiceNo.text.trim()}'),
                  pw.Text('${UiText.t(context, 'Date:')} ${DateTime.now().toString().split(' ').first}'),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 24),
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey300), borderRadius: pw.BorderRadius.circular(8)),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(child: _pdfInfoBlock(UiText.t(context, 'Bill To'), [
                  widget.project['client'] as String? ?? UiText.t(context, 'Client'),
                  widget.project['phone'] as String? ?? '',
                  widget.project['site'] as String? ?? '',
                ])),
                pw.Expanded(child: _pdfInfoBlock(UiText.t(context, 'Project'), [
                  widget.project['name'] as String? ?? UiText.t(context, 'Project'),
                  'Type: ${widget.project['job_type'] ?? 'General Electrical'}',
                  'Status: ${widget.project['status'] ?? 'Open'}',
                ])),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(UiText.t(context, 'Items'), style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.Table.fromTextArray(
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.blue800),
            cellAlignment: pw.Alignment.centerLeft,
            headers: [UiText.t(context, 'Type'), UiText.t(context, 'Description'), UiText.t(context, 'Qty'), UiText.t(context, 'Unit'), UiText.t(context, 'Unit Price'), 'Total'],
            data: items.map((item) {
              final qty = (item['quantity'] as num?)?.toDouble() ?? 0;
              final price = (item['unit_price'] as num?)?.toDouble() ?? 0;
              return [
                item['type'] == 'labor' ? UiText.t(context, 'Labor') : 'Material',
                item['name'] ?? '',
                qty.toStringAsFixed(qty.truncateToDouble() == qty ? 0 : 2),
                item['unit'] ?? '',
                _money(price),
                _money(qty * price),
              ];
            }).toList(),
          ),
          pw.SizedBox(height: 16),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Container(
              width: 250,
              child: pw.Column(
                children: [
                  _pdfTotalRow(UiText.t(context, 'Materials'), materialTotal),
                  _pdfTotalRow(UiText.t(context, 'Labor'), laborTotal),
                  _pdfTotalRow(UiText.t(context, 'Subtotal'), subtotal),
                  _pdfTotalRow(UiText.t(context, 'Discount'), -discount),
                  _pdfTotalRow('Tax (${_num(_taxPercent.text).toStringAsFixed(2)}%)', tax),
                  pw.Divider(),
                  _pdfTotalRow(UiText.t(context, 'Grand Total'), grandTotal, bold: true),
                ],
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(UiText.t(context, 'Terms / Notes'), style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text(_terms.text.trim()),
          pw.SizedBox(height: 18),
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            color: PdfColors.amber50,
            child: pw.Text(UiText.t(context, 'Safety note: Electrical work must follow latest official code, utility requirements, manufacturer instructions, and qualified professional judgment.'), style: const pw.TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
    return pdf.save();
  }

  pw.Widget _pdfInfoBlock(String title, List<String> lines) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ...lines.where((line) => line.trim().isNotEmpty).map((line) => pw.Text(line)),
      ],
    );
  }

  pw.Widget _pdfTotalRow(String label, double value, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: bold ? pw.TextStyle(fontWeight: pw.FontWeight.bold) : null),
          pw.Text(_money(value), style: bold ? pw.TextStyle(fontWeight: pw.FontWeight.bold) : null),
        ],
      ),
    );
  }

  double _itemsTotal(List<Map<String, dynamic>> items, String type) {
    return items.where((item) => item['type'] == type).fold<double>(0, (sum, item) {
      final qty = (item['quantity'] as num?)?.toDouble() ?? 0;
      final price = (item['unit_price'] as num?)?.toDouble() ?? 0;
      return sum + qty * price;
    });
  }

  String _money(double value) => 'Rs. ${value.toStringAsFixed(0)}';

  Future<void> _shareInvoice(List<Map<String, dynamic>> items) async {
    final bytes = await _buildPdf(items);
    await Printing.sharePdf(bytes: bytes, filename: '${_invoiceNo.text.trim().isEmpty ? 'invoice' : _invoiceNo.text.trim()}.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(UiText.t(context, 'Invoice Generator'))),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          final items = snapshot.data ?? const <Map<String, dynamic>>[];
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(UiText.t(context, 'Business Details')),
                TextField(controller: _businessName, decoration: InputDecoration(labelText: UiText.t(context, 'Business / Company Name'))),
                const SizedBox(height: 10),
                TextField(controller: _businessPhone, decoration: InputDecoration(labelText: UiText.t(context, 'Business Phone'))),
                const SizedBox(height: 10),
                TextField(controller: _businessAddress, decoration: InputDecoration(labelText: UiText.t(context, 'Business Address'))),
                const SizedBox(height: 18),
                _SectionTitle(UiText.t(context, 'Invoice Settings')),
                TextField(controller: _invoiceNo, decoration: InputDecoration(labelText: UiText.t(context, 'Invoice Number'))),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: TextField(controller: _discount, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: UiText.t(context, 'Discount (Rs.)')))),
                    const SizedBox(width: 10),
                    Expanded(child: TextField(controller: _taxPercent, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: UiText.t(context, 'Tax %')))),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(controller: _terms, minLines: 3, maxLines: 5, decoration: InputDecoration(labelText: UiText.t(context, 'Terms / Notes'))),
                const SizedBox(height: 18),
                _SectionTitle(UiText.t(context, 'Invoice Summary')),
                _SummaryCard(items: items, discount: _num(_discount.text), taxPercent: _num(_taxPercent.text)),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: items.isEmpty ? null : () => _shareInvoice(items),
                    icon: const Icon(Icons.picture_as_pdf),
                    label: Text(UiText.t(context, 'Generate & Share PDF Invoice')),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue, foregroundColor: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                Text(UiText.t(context, 'Tip: Add materials and labor items in the project detail screen before generating the invoice.'), style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final double discount;
  final double taxPercent;
  const _SummaryCard({required this.items, required this.discount, required this.taxPercent});

  double _total(String type) => items.where((item) => item['type'] == type).fold<double>(0, (sum, item) {
        final qty = (item['quantity'] as num?)?.toDouble() ?? 0;
        final price = (item['unit_price'] as num?)?.toDouble() ?? 0;
        return sum + qty * price;
      });

  @override
  Widget build(BuildContext context) {
    final material = _total('material');
    final labor = _total('labor');
    final subtotal = material + labor;
    final tax = (subtotal - discount).clamp(0, double.infinity) * taxPercent / 100;
    final total = subtotal - discount + tax;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerTheme.color ?? Colors.transparent),
      ),
      child: Column(
        children: [
          _row(UiText.t(context, 'Materials'), material),
          _row(UiText.t(context, 'Labor'), labor),
          _row(UiText.t(context, 'Subtotal'), subtotal),
          _row(UiText.t(context, 'Discount'), -discount),
          _row(UiText.t(context, 'Tax'), tax),
          const Divider(),
          _row('Total', total, bold: true),
        ],
      ),
    );
  }

  Widget _row(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
          Text('Rs. ${value.toStringAsFixed(0)}', style: TextStyle(fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
