import re

with open('lib/presentation/screens/settings/settings_screen.dart', 'r') as f:
    content = f.read()

# Remove the _contactSupport method
content = re.sub(r'  Future<void> _contactSupport\(BuildContext context\) async \{[\s\S]*?\}\n\n', '', content)
# Remove _showSupportFallback method
content = re.sub(r'  void _showSupportFallback\(BuildContext context, AppLocalizations l10n\) \{[\s\S]*?\}\n\n', '', content)
# Remove _openExternalPolicy method
content = re.sub(r'  void _openExternalPolicy\([\s\S]*?\}\n\n', '', content)
# Remove _privacyPolicyText
content = re.sub(r"  static const String _privacyPolicyText = '''[\s\S]*?''';\n\n", '', content)
# Remove _termsOfUseText
content = re.sub(r"  static const String _termsOfUseText = '''[\s\S]*?''';\n", '', content)
# Remove the URLs
content = re.sub(r"  static const String _privacyPolicyUrl =[^;]*;\n", '', content)
content = re.sub(r"  static const String _termsOfServiceUrl =[^;]*;\n\n", '', content)


with open('lib/presentation/screens/settings/settings_screen.dart', 'w') as f:
    f.write(content)

print("Dead code removed")
