import re

with open('lib/presentation/screens/standards/pakistan_standards_screen.dart', 'r') as f:
    content = f.read()

# Remove the top disclaimer banner
content = re.sub(r'Padding\(\s*padding: const EdgeInsets\.fromLTRB\(20, 8, 20, 10\),\s*child: _DisclaimerBanner\(isDark: isDark\),\s*\),\s*', '', content)

# Remove the detail screen disclaimer banner
content = re.sub(r'_DisclaimerBanner\(isDark: isDark\),\s*const SizedBox\(height: 20\),\s*', '', content)

with open('lib/presentation/screens/standards/pakistan_standards_screen.dart', 'w') as f:
    f.write(content)

