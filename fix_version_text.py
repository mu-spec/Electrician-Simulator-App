with open('lib/presentation/screens/settings/settings_screen.dart', 'r') as f:
    content = f.read()

content = content.replace("UiText.t(context, 'Version 2.0.0 Closed Beta')", "UiText.t(context, 'Version 2.0.0')")

with open('lib/presentation/screens/settings/settings_screen.dart', 'w') as f:
    f.write(content)

print("Removed Closed Beta")
