import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/locale_cubit.dart';
import '../../../core/theme/app_theme.dart';
import '../main_scaffold.dart';

/// Startup language selection shown on every app launch before Home.
///
/// Uses the SAME source of truth as Settings → Language:
/// - [AppLocalizations.supportedLanguages] for the list
/// - [LocaleCubit] (Hive key `settings/localeCode`) for persistence
///
/// Flow: Splash → [Onboarding if needed] → [StartupLanguageScreen] → [MainScaffold]
/// Preselected language is the currently persisted locale. User may keep it
/// and press Done, or pick another and press Done. Done persists, updates
/// the app Locale, and replaces this route so Back from Home never returns here.
class StartupLanguageScreen extends StatefulWidget {
  const StartupLanguageScreen({super.key});

  @override
  State<StartupLanguageScreen> createState() => _StartupLanguageScreenState();
}

class _StartupLanguageScreenState extends State<StartupLanguageScreen> {
  String? _pendingCode;
  bool _saving = false;

  Future<void> _onDone(BuildContext context, String currentCode) async {
    if (_saving) return;
    setState(() => _saving = true);
    final codeToSave = _pendingCode ?? currentCode;
    // Persist and apply via the shared LocaleCubit
    await context.read<LocaleCubit>().setLanguageCode(codeToSave);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainScaffold()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final currentCode = locale.languageCode;
        final effectiveCode = _pendingCode ?? currentCode;

        return PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(11),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlue.withOpacity(0.10),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppTheme.primaryBlue.withOpacity(0.14),
                                ),
                              ),
                              child: const Icon(
                                Icons.language_rounded,
                                color: AppTheme.primaryBlue,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context).t('chooseYourLanguage'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 22,
                                      height: 1.2,
                                      color: isDark
                                          ? const Color(0xFFF8FAFC)
                                          : const Color(0xFF0F172A),
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context).t('selectLanguageSubtitle'),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: isDark
                                    ? const Color(0xFF94A3B8)
                                    : const Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                  ),
                  // Language list
                  Expanded(
                    child: ListView.separated(
                      itemCount: AppLocalizations.supportedLanguages.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        thickness: 1,
                        color: (isDark
                                ? const Color(0xFF334155)
                                : const Color(0xFFE2E8F0))
                            .withOpacity(0.7),
                      ),
                      itemBuilder: (context, index) {
                        final lang = AppLocalizations.supportedLanguages[index];
                        final isSelected = lang.code == effectiveCode;
                        return Material(
                          color: isSelected
                              ? (isDark
                                  ? AppTheme.primaryBlue.withOpacity(0.14)
                                  : AppTheme.primaryBlue.withOpacity(0.06))
                              : Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _pendingCode = lang.code;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang.nativeName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontWeight:
                                                    isSelected ? FontWeight.w700 : FontWeight.w600,
                                                fontSize: 16,
                                                height: 1.25,
                                                color: isSelected
                                                    ? AppTheme.primaryBlue
                                                    : null,
                                              ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          lang.englishName +
                                              (lang.isRtl ? ' • RTL' : ''),
                                          style:
                                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    fontWeight: isSelected
                                                        ? FontWeight.w600
                                                        : FontWeight.w400,
                                                    color: isSelected
                                                        ? (isDark
                                                            ? const Color(0xFF93C5FD)
                                                            : AppTheme.primaryBlue)
                                                        : (isDark
                                                            ? const Color(0xFF94A3B8)
                                                            : const Color(0xFF64748B)),
                                                  ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? AppTheme.primaryBlue
                                            : (isDark
                                                ? const Color(0xFF475569)
                                                : const Color(0xFFCBD5E1)),
                                        width: isSelected ? 2 : 1.6,
                                      ),
                                      color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
                                    ),
                                    child: isSelected
                                        ? const Icon(Icons.check_rounded,
                                            color: Colors.white, size: 18)
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Bottom Done bar - always visible
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      border: Border(
                        top: BorderSide(
                          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.28 : 0.06),
                          blurRadius: 20,
                          offset: const Offset(0, -6),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      top: false,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saving ? null : () => _onDone(context, currentCode),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                            textStyle: const TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              letterSpacing: 0.2,
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context).t('done'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
