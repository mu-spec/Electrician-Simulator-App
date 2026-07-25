import re

# 1. Update UI Text
with open('lib/presentation/screens/home/home_screen.dart', 'r') as f:
    home_content = f.read()
home_content = home_content.replace("'Resistor Scanner'", "'Manual Resistor Band Reader'")
with open('lib/presentation/screens/home/home_screen.dart', 'w') as f:
    f.write(home_content)


with open('lib/presentation/screens/tools/resistor_scanner_screen.dart', 'r') as f:
    tool_content = f.read()

# Change app bar title
tool_content = tool_content.replace("'Resistor Scanner'", "'Manual Resistor Band Reader'")

# Add warning text
old_warning = """                  UiText.t(
                    context,
                    'Take or choose a resistor photo, then select bands manually.',
                  ),"""

new_warning = """                  UiText.t(
                    context,
                    'Take or choose a resistor photo, then select bands manually.\n\nThe photo is used only as a visual reference. Color bands must be selected manually.',
                  ),
                  textAlign: TextAlign.center,"""

tool_content = tool_content.replace(old_warning, new_warning)

with open('lib/presentation/screens/tools/resistor_scanner_screen.dart', 'w') as f:
    f.write(tool_content)

print("Updated Resistor tool")
