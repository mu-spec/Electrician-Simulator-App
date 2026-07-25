import re

with open('lib/presentation/screens/splash_screen.dart', 'r') as f:
    content = f.read()

# Change image path
content = content.replace("'assets/images/app_icon.webp'", "'assets/images/app_icon.png'")

# Change the loading text to 6 seconds
content = re.sub(
    r"'Please wait up to 20 seconds on first launch'",
    r"'Please wait up to 6 seconds on first launch'",
    content
)

with open('lib/presentation/screens/splash_screen.dart', 'w') as f:
    f.write(content)
print("Updated splash_screen.dart")
