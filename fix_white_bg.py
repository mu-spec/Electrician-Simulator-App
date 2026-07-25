import os

files = [
    'android/app/src/main/res/drawable/launch_background.xml',
    'android/app/src/main/res/drawable-v21/launch_background.xml'
]

new_content = """<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item>
        <shape android:shape="rectangle">
            <solid android:color="#FFFFFF" />
        </shape>
    </item>
</layer-list>
"""

for path in files:
    if os.path.exists(path):
        with open(path, 'w') as f:
            f.write(new_content)
        print(f"Updated {path} to solid white")

