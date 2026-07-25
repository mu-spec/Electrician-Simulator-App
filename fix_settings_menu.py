import re

with open('lib/presentation/screens/settings/settings_screen.dart', 'r') as f:
    content = f.read()

# Remove Privacy Policy Tile
content = re.sub(
    r"""_SettingsTile\(\s*icon: Icons.policy_outlined,\s*iconColor: const Color\(0xFF94A3B8\),\s*title: l10n.t\('privacyPolicy'\),\s*onTap: \(\) => _openExternalPolicy\([\s\S]*?\),\s*\),\s*const Divider\(height: 1\),\s*""",
    "",
    content
)

# Remove Terms of Use Tile
content = re.sub(
    r"""_SettingsTile\(\s*icon: Icons.description_outlined,\s*iconColor: const Color\(0xFF94A3B8\),\s*title: l10n.t\('termsOfUse'\),\s*onTap: \(\) => _openExternalPolicy\([\s\S]*?\),\s*\),\s*const Divider\(height: 1\),\s*""",
    "",
    content
)

# Remove Contact Support Tile
content = re.sub(
    r"""_SettingsTile\(\s*icon: Icons.support_agent,\s*iconColor: const Color\(0xFF94A3B8\),\s*title: l10n.t\('contactSupport'\),\s*onTap: \(\) => _contactSupport\(context\),\s*\),\s*const Divider\(height: 1\),\s*""",
    "",
    content
)

with open('lib/presentation/screens/settings/settings_screen.dart', 'w') as f:
    f.write(content)
print("Removed items from menu")
