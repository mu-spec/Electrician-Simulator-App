import re

with open('lib/presentation/screens/projects/invoice_generator_screen.dart', 'r') as f:
    content = f.read()

old_block = """          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            color: PdfColors.amber50,
            child: pw.Text(UiText.t(context, 'Safety note: Electrical work must follow latest official code, utility requirements, manufacturer instructions, and qualified professional judgment.'), style: const pw.TextStyle(fontSize: 10)),
          ),"""

new_block = """          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            color: PdfColors.amber50,
            child: pw.Text(UiText.t(context, 'Safety note: Electrical work must follow latest official code, utility requirements, manufacturer instructions, and qualified professional judgment.'), style: const pw.TextStyle(fontSize: 10)),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            UiText.t(context, 'User is solely responsible for legal and tax compliance of this invoice.'),
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
          ),"""

content = content.replace(old_block, new_block)

with open('lib/presentation/screens/projects/invoice_generator_screen.dart', 'w') as f:
    f.write(content)
print("Added disclaimer to PDF")
