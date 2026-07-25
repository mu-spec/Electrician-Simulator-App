import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/ads/ad_service.dart';
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
                          UiText.t(context, 'Version 2.0.0 Closed Beta'),
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
            // Ads (opt-in rewarded)
            Text(
              UiText.t(context, 'Ads'),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<bool>(
              valueListenable: AdService.instance.adsFreeNotifier,
              builder: (context, adsFree, _) {
                return _SettingsCard(
                  children: [
                    _SettingsTile(
                      icon: Icons.workspace_premium_outlined,
                      iconColor: AppTheme.accentOrange,
                      title: adsFree
                          ? UiText.t(context, 'Ads paused (reward active)')
                          : UiText.t(context, 'Watch Ad · Remove Ads 24h'),
                      subtitle: adsFree
                          ? UiText.t(
                              context,
                              'Banner, interstitial and app-open ads are hidden temporarily.',
                            )
                          : UiText.t(
                              context,
                              'Optional. Watch a short ad to hide ads for 24 hours.',
                            ),
                      onTap: adsFree
                          ? null
                          : () async {
                              final messenger = ScaffoldMessenger.of(context);
                              final ok = await AdService.instance
                                  .watchAdToRemoveAdsForOneDay();
                              if (!context.mounted) return;
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    UiText.t(
                                      context,
                                      ok
                                          ? 'Ads removed for 24 hours. Enjoy!'
                                          : 'Rewarded ad is not ready yet. Please try again in a moment.',
                                    ),
                                  ),
                                ),
                              );
                            },
                      trailing: adsFree
                          ? const Icon(
                              Icons.check_circle,
                              color: AppTheme.accentGreen,
                            )
                          : const Icon(
                              Icons.ondemand_video_outlined,
                              color: AppTheme.accentOrange,
                            ),
                    ),
                  ],
                );
              },
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
                  title: l10n.t('clearData'),
                  subtitle: l10n.t('clearDataDesc'),
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
                  icon: Icons.policy_outlined,
                  iconColor: const Color(0xFF94A3B8),
                  title: l10n.t('privacyPolicy'),
                  onTap: () => _openExternalPolicy(
                    context,
                    l10n.t('privacyPolicy'),
                    _privacyPolicyUrl,
                    _privacyPolicyText,
                  ),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.description_outlined,
                  iconColor: const Color(0xFF94A3B8),
                  title: l10n.t('termsOfUse'),
                  onTap: () => _openExternalPolicy(
                    context,
                    l10n.t('termsOfUse'),
                    _termsOfServiceUrl,
                    _termsOfUseText,
                  ),
                ),
                const Divider(height: 1),
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
                  icon: Icons.support_agent,
                  iconColor: const Color(0xFF94A3B8),
                  title: l10n.t('contactSupport'),
                  onTap: () => _contactSupport(context),
                ),
                const Divider(height: 1),
                _SettingsTile(
                  icon: Icons.star_outline,
                  iconColor: AppTheme.accentOrange,
                  title: l10n.t('rateApp'),
                  onTap: () => _rateApp(context),
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
        title: Text(l10n.t('clearDataTitle')),
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

  Future<void> _openExternalPolicy(
    BuildContext context,
    String title,
    String url,
    String fallbackBody,
  ) async {
    final uri = Uri.parse(url);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        _showPolicyDialog(context, title, fallbackBody);
      }
    } catch (_) {
      if (context.mounted) {
        _showPolicyDialog(context, title, fallbackBody);
      }
    }
  }

  void _showPolicyDialog(BuildContext context, String title, String body) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Text(
              UiText.t(context, body),
              style: const TextStyle(fontSize: 13, height: 1.6),
            ),
          ),
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

  Future<void> _contactSupport(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final uri = Uri(
      scheme: 'mailto',
      path: 'koreappstek@gmail.com',
      query: 'subject=VoltMaster Pro Support&body=Hi VoltMaster team,%0A%0A',
    );
    try {
      final launched = await launchUrl(uri);
      if (!launched && context.mounted) {
        _showSupportFallback(context, l10n);
      }
    } catch (_) {
      if (context.mounted) _showSupportFallback(context, l10n);
    }
  }

  void _showSupportFallback(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.t('supportEmailTitle')),
        content: Text(l10n.t('supportEmailBody')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.t('close')),
          ),
        ],
      ),
    );
  }

  Future<void> _rateApp(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    // Play Store listing (will work once the app is published)
    final uri = Uri.parse(
      'https://play.google.com/store/apps/details?id=com.voltmaster.pro',
    );
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.t('couldNotOpenStore'))));
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.t('couldNotOpenStore'))));
      }
    }
  }

  static const String _privacyPolicyUrl =
      'https://dynamic-kashata-01ef6b.netlify.app';
  static const String _termsOfServiceUrl =
      'https://aesthetic-palmier-7cb498.netlify.app';

  static const String _privacyPolicyText = '''
Last updated: July 2026

VoltMaster Pro ("the App") respects your privacy. This policy explains what data the App handles.

1. DATA COLLECTION
The App does not collect, transmit, or share any personal data. All content works fully offline.

2. LOCAL STORAGE
Your bookmarks, saved calculations, quiz results, and reading history are stored only on your device, in the App's private storage. They never leave your device.

3. INTERNET ACCESS
The App uses the internet only to download display fonts on first launch. No personal information is sent.

4. THIRD-PARTY SERVICES
The App does not include advertising networks, analytics trackers, or third-party data collection of any kind.

5. CHILDREN'S PRIVACY
The App does not knowingly collect any information from children.

6. DATA DELETION
You can erase all locally stored data at any time using Settings → Clear Data, or by uninstalling the App.

7. CHANGES
If this policy changes, the updated version will be included in an App update.

8. CONTACT
Questions? Email koreappstek@gmail.com
''';

  static const String _termsOfUseText = '''
Last updated: July 2026

By using VoltMaster Pro ("the App"), you agree to these terms.

1. EDUCATIONAL PURPOSE
The App provides educational reference material for electrical theory, calculations, wiring practices, and exam preparation.

2. SAFETY DISCLAIMER
Electrical work is dangerous and may be fatal if performed incorrectly. The App's content is for reference and learning only. It is NOT a substitute for professional training, local electrical codes, or a licensed electrician. Always comply with your local regulations, and never perform electrical work unless you are qualified and authorized to do so.

3. NO WARRANTY
The App and its content are provided "as is" without warranty of any kind. While we strive for accuracy, we do not guarantee that calculations, diagrams, or articles are error-free or applicable to your specific situation.

4. LIMITATION OF LIABILITY
To the maximum extent permitted by law, the developers of the App shall not be liable for any damages, injuries, or losses arising from the use of, or reliance on, the App's content.

5. INTELLECTUAL PROPERTY
All content in the App is the property of its developers and may not be reproduced or redistributed without permission.

6. CHANGES
These terms may be updated in future App versions. Continued use constitutes acceptance.

7. CONTACT
Questions? Email koreappstek@gmail.com
''';
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
