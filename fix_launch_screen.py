import os

files = [
    'android/app/src/main/res/drawable/launch_background.xml',
    'android/app/src/main/res/drawable-v21/launch_background.xml'
]

new_content = """<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item>
        <shape android:shape="rectangle">
            <gradient
                android:startColor="#0F172A"
                android:centerColor="#1D4ED8"
                android:endColor="#06B6D4"
                android:angle="135" />
        </shape>
    </item>
</layer-list>
"""

for path in files:
    if os.path.exists(path):
        with open(path, 'w') as f:
            f.write(new_content)
        print(f"Updated {path}")

