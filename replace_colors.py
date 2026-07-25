import re

with open('lib/presentation/screens/splash_screen.dart', 'r') as f:
    content = f.read()

content = content.replace("color: isDark ? Colors.white : Colors.black,", "color: Colors.black,")

with open('lib/presentation/screens/splash_screen.dart', 'w') as f:
    f.write(content)
