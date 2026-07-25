import re
with open('lib/core/localization/ui_text.dart', 'r') as f:
    content = f.read()

content = content.replace("'Resistor Scanner':", "'Manual Resistor Band Reader':")

with open('lib/core/localization/ui_text.dart', 'w') as f:
    f.write(content)

print("Updated ui_text.dart")
