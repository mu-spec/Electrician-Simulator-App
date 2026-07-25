import os
import re
import gzip
import json

# Fix Android Namespace and App ID
with open('android/app/build.gradle.kts', 'r') as f:
    content = f.read()
content = content.replace('namespace = "com.voltmaster.pro"', 'namespace = "com.muspec.electriciansimulator"')
content = content.replace('applicationId = "com.voltmaster.pro"', 'applicationId = "com.muspec.electriciansimulator"')
with open('android/app/build.gradle.kts', 'w') as f:
    f.write(content)

# Fix Android Proguard
with open('android/app/proguard-rules.pro', 'r') as f:
    content = f.read()
content = content.replace('VoltMaster Pro', 'Electrician Simulator App')
content = content.replace('com.voltmaster.pro', 'com.muspec.electriciansimulator')
with open('android/app/proguard-rules.pro', 'w') as f:
    f.write(content)

# Fix MainActivity.kt
with open('android/app/src/main/kotlin/com/voltmaster/pro/MainActivity.kt', 'r') as f:
    content = f.read()
content = content.replace('package com.voltmaster.pro', 'package com.muspec.electriciansimulator')
with open('android/app/src/main/kotlin/com/voltmaster/pro/MainActivity.kt', 'w') as f:
    f.write(content)

# Move MainActivity.kt to the correct folder path for the new package name
os.makedirs('android/app/src/main/kotlin/com/muspec/electriciansimulator', exist_ok=True)
os.rename('android/app/src/main/kotlin/com/voltmaster/pro/MainActivity.kt', 'android/app/src/main/kotlin/com/muspec/electriciansimulator/MainActivity.kt')

# Fix iOS Bundle IDs
with open('ios/Runner.xcodeproj/project.pbxproj', 'r') as f:
    content = f.read()
content = content.replace('com.example.voltmasterPro', 'com.muspec.electriciansimulator')
with open('ios/Runner.xcodeproj/project.pbxproj', 'w') as f:
    f.write(content)

# Fix English default translation edge case
with open('lib/core/localization/app_localizations.dart', 'r') as f:
    content = f.read()
content = content.replace('Voltmasterpro.app@gmail.com', 'koreappstek@gmail.com')
with open('lib/core/localization/app_localizations.dart', 'w') as f:
    f.write(content)

# Fix Dart imports in onboarding
with open('lib/presentation/screens/onboarding_screen.dart', 'r') as f:
    content = f.read()
content = content.replace('package:voltmaster_pro/', 'package:electrician_simulator_app/')
with open('lib/presentation/screens/onboarding_screen.dart', 'w') as f:
    f.write(content)

# Rename pubspec.yaml name
with open('pubspec.yaml', 'r') as f:
    content = f.read()
content = content.replace('name: voltmaster_pro', 'name: electrician_simulator_app')
with open('pubspec.yaml', 'w') as f:
    f.write(content)

print("Fixed all remaining VoltMaster references!")
