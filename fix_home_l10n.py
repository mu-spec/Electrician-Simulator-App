import re

with open('lib/presentation/screens/home/home_screen.dart', 'r') as f:
    content = f.read()

# Replace the hardcoded string with the translation wrapper
old_title_code = """              Text(
                'Electrician Simulator App',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.6,
                  fontSize: 28, // slightly smaller to fit the longer word
                ),
              ),"""

new_title_code = """              Text(
                UiText.t(context, 'Electrician Simulator App'),
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.6,
                  fontSize: 28, // slightly smaller to fit the longer word
                ),
              ),"""

content = content.replace(old_title_code, new_title_code)

with open('lib/presentation/screens/home/home_screen.dart', 'w') as f:
    f.write(content)
print("Fixed localization in home screen")

