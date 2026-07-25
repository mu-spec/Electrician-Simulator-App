import re

with open('lib/presentation/screens/settings/settings_screen.dart', 'r') as f:
    content = f.read()

# Replace l10n.t('clearData') with UiText.t(context, 'Clear All Local Data')
content = content.replace("title: l10n.t('clearData'),", "title: UiText.t(context, 'Clear All Local Data'),")
content = content.replace("subtitle: l10n.t('clearDataDesc'),", "subtitle: UiText.t(context, 'Permanently delete saved calculations, bookmarks, and quiz history.'),")
content = content.replace("title: Text(l10n.t('clearDataTitle')),", "title: Text(UiText.t(context, 'Clear All Local Data?')),")
content = content.replace("content: Text(l10n.t('clearDataBody')),", "content: Text(UiText.t(context, 'This will permanently delete all your saved calculations, bookmarks, and quiz history. This action cannot be undone.')),")

with open('lib/presentation/screens/settings/settings_screen.dart', 'w') as f:
    f.write(content)

print("Updated clear data wording")
