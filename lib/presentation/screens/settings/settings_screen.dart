import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_cubit.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/locale_cubit.dart';
import '../../../data/database_service.dart';
import 'bookmarks_screen.dart';
import 'saved_calculations_screen.dart';
import 'feedback_screen.dart';
import 'language_selection_screen.dart';
import '../search/global_search_screen.dart';
import '../projects/projects_screen.dart';
import '../../../core/localization/ui_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.t('settings'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Info Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryBlue, AppTheme.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.bolt,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.t('appTitle'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          UiText.t(context, 'Version 1.0.1'),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Appearance
            Text(
              l10n.t('appearance'),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            _SettingsCard(
              children: [
                _SettingsTile(
                  icon: Icons.dark_mode,
                  iconColor: AppTheme.accentPurple,
                  title: l10n.t('darkMode'),
                  subtitle: l10n.t('toggleTheme'),
                  trailing: Switch(
                    value: isDark,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // General
            Text(
              l10n.t('general'),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            _SettingsCard(
              children: [
                _SettingsTile(
                  icon: Icons.bookmark_outline,
                  iconColor: AppTheme.primaryBlue,
                  title: l10n.t('bookmarks'),
                  subtitle: l10n.t('manageBookmarksDesc'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BookmarksScreen()),
                  ),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.history,
                  iconColor: AppTheme.accentOrange,
                  title: l10n.t('savedCalculations'),
                  subtitle: l10n.t('viewCalcHistoryDesc'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SavedCalculationsScreen(),
                    ),
                  ),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.work_outline,
                  iconColor: AppTheme.accentPurple,
                  title: l10n.t('jobManager'),
                  subtitle: l10n.t('jobManagerDesc'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProjectsScreen()),
                  ),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.search,
                  iconColor: AppTheme.primaryBlue,
                  title: l10n.t('globalSearch'),
                  subtitle: l10n.t('globalSearchDesc'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GlobalSearchScreen(),
                    ),
                  ),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.language,
                  iconColor: AppTheme.accentGreen,
                  title: l10n.t('language'),
                  subtitle: AppLocalizations.supportedLanguages
                      .firstWhere(
                        (language) =>
                            language.code ==
                            context.watch<LocaleCubit>().state.languageCode,
                        orElse: () => AppLocalizations.supportedLanguages.first,
                      )
                      .nativeName,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LanguageSelectionScreen(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Data
            Text(
              l10n.t('dataStorage'),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            _SettingsCard(
              children: [
                _SettingsTile(
                  icon: Icons.download_done,
                  iconColor: AppTheme.accentCyan,
                  title: l10n.t('offlineContent'),
                  subtitle: l10n.t('offlineContentDesc'),
                  trailing: const Icon(
                    Icons.check_circle,
                    color: AppTheme.accentGreen,
                  ),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.delete_outline,
                  iconColor: AppTheme.accentRed,
                  title: UiText.t(context, 'Clear All Local Data'),
                  subtitle: UiText.t(context, 'Permanently delete saved calculations, bookmarks, and quiz history.'),
                  onTap: () => _showClearDataDialog(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // About
            Text(
              l10n.t('about'),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            _SettingsCard(
              children: [
                _SettingsTile(
                  icon: Icons.feedback_outlined,
                  iconColor: AppTheme.primaryBlue,
                  title: l10n.t('sendBetaFeedback'),
                  subtitle: l10n.t('betaFeedbackDesc'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FeedbackScreen()),
                  ),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  iconColor: AppTheme.primaryBlue,
                  title: l10n.t('privacyPolicy'),
                  onTap: () => _openPrivacyPolicy(context),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                l10n.t('madeForElectricians'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showClearDataDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(UiText.t(context, 'Clear All Local Data?')),
        content: Text(l10n.t('clearDataWarning')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.t('cancel')),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await DatabaseService.clearAllData();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.t('allDataCleared'))),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentRed,
            ),
            child: Text(l10n.t('clear')),
          ),
        ],
      ),
    );
  }

  /// Google Play's User Data policy requires a privacy policy link inside the
  /// app itself, in addition to the URL supplied in the Play Console listing.
  /// Opens the hosted policy in the user's browser.
  static const String _privacyPolicyUrl =
      'https://docs.google.com/document/d/e/2PACX-1vQHzRFrySn9bxTSNeYCLozobv5Tvn2Lb41eXbYa0QwuISKHeP4URBVSr2n2HFqRAkb3d0TTN2nkS2Js/pub';

  Future<void> _openPrivacyPolicy(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final uri = Uri.parse(_privacyPolicyUrl);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        _showLinkError(context, l10n);
      }
    } catch (_) {
      if (context.mounted) {
        _showLinkError(context, l10n);
      }
    }
  }

  /// Fallback when no browser can handle the link: show the URL so the user
  /// can still reach the policy manually.
  void _showLinkError(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.t('privacyPolicy')),
        content: SelectableText(
          _privacyPolicyUrl,
          style: const TextStyle(fontSize: 13, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.t('close')),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(subtitle!, style: Theme.of(context).textTheme.bodySmall)
          : null,
      trailing:
          trailing ??
          (onTap != null
              ? const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF94A3B8),
                )
              : null),
      onTap: onTap,
    );
  }
}
