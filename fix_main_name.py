import re

with open('lib/main.dart', 'r') as f:
    content = f.read()

content = content.replace('VoltMasterApp', 'ElectricianSimulatorApp')

with open('lib/main.dart', 'w') as f:
    f.write(content)
print("Updated main.dart")

