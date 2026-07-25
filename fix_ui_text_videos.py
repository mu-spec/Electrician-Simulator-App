import re

with open('lib/core/localization/ui_text.dart', 'r') as f:
    content = f.read()

# Add the missing keys so the app doesn't crash on audit
new_keys = """    'Electrician Simulator App': 'appTitle',
    'Find Videos on YouTube': 'videoTutorialLinks',
    'Search YouTube': 'youtubeLinks',"""

content = content.replace("'VoltMaster Pro': 'appTitle',", new_keys)

with open('lib/core/localization/ui_text.dart', 'w') as f:
    f.write(content)

print("Updated ui_text.dart")
