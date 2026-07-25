import re

# 1. Update the Rate App URL in settings_screen.dart
with open('lib/presentation/screens/settings/settings_screen.dart', 'r') as f:
    content = f.read()

content = content.replace(
    "'https://play.google.com/store/apps/details?id=com.voltmaster.pro'",
    "'https://play.google.com/store/apps/details?id=com.koreappstek.electriciansimulatorapp'"
)

with open('lib/presentation/screens/settings/settings_screen.dart', 'w') as f:
    f.write(content)

# 2. Update the feedback email template to remove "Closed Beta"
with open('lib/presentation/screens/settings/feedback_screen.dart', 'r') as f:
    feedback_content = f.read()

feedback_content = feedback_content.replace(
    "'subject': 'VoltMaster Pro Closed Beta Feedback - $_category',",
    "'subject': 'Electrician Simulator App Feedback - $_category',"
)
feedback_content = feedback_content.replace(
    "UiText.t(context, 'Your beta feedback helps make Electrician Simulator App safer, more accurate, and ready for Play Store release.')",
    "UiText.t(context, 'Your feedback helps us improve the Electrician Simulator App.')"
)

with open('lib/presentation/screens/settings/feedback_screen.dart', 'w') as f:
    f.write(feedback_content)

# 3. Force Release Signing build to fail if Keystore isn't found (instead of falling back to debug signing)
with open('android/app/build.gradle.kts', 'r') as f:
    gradle_content = f.read()

old_release_signing = """        release {
            if (keystorePropertiesFile.exists()) {
                signingConfig = signingConfigs.getByName("release")
            } else {
                signingConfig = signingConfigs.getByName("debug")
            }"""

new_release_signing = """        release {
            if (keystorePropertiesFile.exists()) {
                signingConfig = signingConfigs.getByName("release")
            } else {
                throw GradleException("Release Keystore is required for production builds, but key.properties was not found.")
            }"""

gradle_content = gradle_content.replace(old_release_signing, new_release_signing)

with open('android/app/build.gradle.kts', 'w') as f:
    f.write(gradle_content)

# 4. Change version to 1.0.0+1
with open('pubspec.yaml', 'r') as f:
    pubspec = f.read()
    
pubspec = pubspec.replace("version: 2.0.0+20", "version: 1.0.0+1")

with open('pubspec.yaml', 'w') as f:
    f.write(pubspec)

print("Phase 1 fixes applied")
