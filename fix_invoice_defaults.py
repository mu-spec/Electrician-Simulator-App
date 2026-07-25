import re

with open('lib/presentation/screens/projects/invoice_generator_screen.dart', 'r') as f:
    content = f.read()

# 1. Remove the default business name (so it's empty, forcing the user to type their own)
content = content.replace(
    "final TextEditingController _businessName = TextEditingController(text: 'Electrician Simulator App Electrical Services');",
    "final TextEditingController _businessName = TextEditingController();"
)

# 2. Fix the default terms
content = content.replace(
    "final TextEditingController _terms = TextEditingController(text: 'Payment due upon completion. This invoice is generated from Electrician Simulator App.');",
    "final TextEditingController _terms = TextEditingController(text: 'Payment due upon completion. Thank you for your business.');"
)

# 3. Add a legal disclaimer to the bottom of the PDF generation logic
# Let's find the PDF footer logic.
old_footer = """            pw.Text(
              _terms.text,
              style: pw.TextStyle(font: font, fontSize: 10, color: PdfColors.grey700),
            ),
          ],
        );
      },
    ));"""

new_footer = """            pw.Text(
              _terms.text,
              style: pw.TextStyle(font: font, fontSize: 10, color: PdfColors.grey700),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'User is solely responsible for legal and tax compliance of this invoice.',
              style: pw.TextStyle(font: font, fontSize: 8, color: PdfColors.grey500),
            ),
          ],
        );
      },
    ));"""

if old_footer in content:
    content = content.replace(old_footer, new_footer)
else:
    print("WARNING: Could not find footer block to add disclaimer. Trying regex...")
    content = re.sub(
        r'pw\.Text\(\s*_terms\.text,\s*style: pw\.TextStyle\(font: font, fontSize: 10, color: PdfColors\.grey700\),\s*\),\s*],\s*\);\s*},\s*\)\);',
        new_footer,
        content
    )

with open('lib/presentation/screens/projects/invoice_generator_screen.dart', 'w') as f:
    f.write(content)
print("Updated invoice generator")
