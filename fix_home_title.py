import re

with open('lib/presentation/screens/home/home_screen.dart', 'r') as f:
    content = f.read()

# Instead of fetching appTitle from translation maps, hardcode it to the new name in English
# because translations are static. Or just use a direct string.
old_title_code = """              Text(
                l10n.t('appTitle'),
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.6,
                  fontSize: 32,
                ),
              ),"""

new_title_code = """              Text(
                'Electrician Simulator',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.6,
                  fontSize: 28, // slightly smaller to fit the longer word
                ),
              ),"""

content = content.replace(old_title_code, new_title_code)

with open('lib/presentation/screens/home/home_screen.dart', 'w') as f:
    f.write(content)
print("Updated home screen title")

