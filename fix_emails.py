import os
import re

files_to_check = [
    'lib/presentation/screens/settings/feedback_screen.dart',
    'lib/presentation/screens/settings/settings_screen.dart',
    'lib/core/localization/app_localizations.dart'
]

for filepath in files_to_check:
    if os.path.exists(filepath):
        with open(filepath, 'r') as f:
            content = f.read()
        
        # Replace the email address
        new_content = content.replace('voltmasterpro.app@gmail.com', 'koreappstek@gmail.com')
        
        if new_content != content:
            with open(filepath, 'w') as f:
                f.write(new_content)
            print(f"Updated emails in {filepath}")

