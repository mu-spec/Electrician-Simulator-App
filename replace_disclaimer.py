import re

with open('lib/presentation/screens/standards/pakistan_standards_screen.dart', 'r') as f:
    content = f.read()

# The disclaimer is likely displayed at the top of the list
old_disclaimer_block = r"""          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: const _DisclaimerCard(),
          ),"""

new_disclaimer_block = r"""          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          //   child: const _DisclaimerCard(),
          // ),"""

if 'child: const _DisclaimerCard(),' in content:
    content = re.sub(r'Padding\(\s*padding: const EdgeInsets\.symmetric\(horizontal: 20, vertical: 8\),\s*child: const _DisclaimerCard\(\),\s*\),', '', content)
    with open('lib/presentation/screens/standards/pakistan_standards_screen.dart', 'w') as f:
        f.write(content)
    print("Success removing from list")
else:
    print("Could not find the disclaimer card in the list view.")

