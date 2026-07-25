import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app_localizations.dart';

class LocaleCubit extends Cubit<Locale> {
  static const String _boxName = 'settings';
  static const String _localeKey = 'localeCode';

  LocaleCubit() : super(const Locale('en')) {
    _loadSavedLocale();
  }

  bool _isSupported(String code) => AppLocalizations.supportedLanguages.any((language) => language.code == code);

  Future<void> _loadSavedLocale() async {
    try {
      final box = await Hive.openBox(_boxName);
      final code = box.get(_localeKey, defaultValue: 'en') as String;
      emit(Locale(_isSupported(code) ? code : 'en'));
    } catch (_) {
      emit(const Locale('en'));
    }
  }

  Future<void> setLocale(Locale locale) async {
    final code = _isSupported(locale.languageCode) ? locale.languageCode : 'en';
    final normalized = Locale(code);
    emit(normalized);
    try {
      final box = await Hive.openBox(_boxName);
      await box.put(_localeKey, code);
    } catch (_) {
      // Keep app functional even if persistence fails.
    }
  }

  Future<void> setLanguageCode(String code) => setLocale(Locale(code));
  Future<void> setEnglish() => setLocale(const Locale('en'));
  Future<void> setUrdu() => setLocale(const Locale('ur'));
}
