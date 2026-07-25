import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/locale_cubit.dart';
import '../../../core/theme/app_theme.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentCode = context.watch<LocaleCubit>().state.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.t('language')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.t('done'),
              style: const TextStyle(
                color: AppTheme.primaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: AppLocalizations.supportedLanguages.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final language = AppLocalizations.supportedLanguages[index];
          final isSelected = language.code == currentCode;
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            title: Text(
              language.nativeName,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Text(language.englishName + (language.isRtl ? ' • RTL' : '')),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: AppTheme.primaryBlue)
                : null,
            onTap: () {
              context.read<LocaleCubit>().setLanguageCode(language.code);
            },
          );
        },
      ),
    );
  }
}
