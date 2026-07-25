import re

with open('lib/models/calculator_model.dart', 'r') as f:
    content = f.read()

# Replace the short accuracy note with the massive, legally safe preliminary estimate warning
old_note = "'Approximate result. Verify against latest local code and manufacturer data before installation.'"

new_note = "'PRELIMINARY ESTIMATE ONLY: This tool uses simplified mathematical models and does not account for complex real-world variables (e.g., thermal insulation, conductor material, grouping factors, specific local codes). Results are conceptual estimates and MUST NOT be used for final installation, purchasing, or safety certification. Always verify with full standard tables (NEC/IEC/PEC) and a licensed professional.'"

content = content.replace(old_note, new_note)

with open('lib/models/calculator_model.dart', 'w') as f:
    f.write(content)

print("Updated accuracyNote in CalculatorModel")
