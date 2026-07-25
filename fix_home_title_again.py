import re

with open('lib/presentation/screens/home/home_screen.dart', 'r') as f:
    content = f.read()

# Change it to Electrician Simulator App
content = content.replace("'Electrician Simulator'", "'Electrician Simulator App'")

with open('lib/presentation/screens/home/home_screen.dart', 'w') as f:
    f.write(content)
print("Updated home screen title to full name")

