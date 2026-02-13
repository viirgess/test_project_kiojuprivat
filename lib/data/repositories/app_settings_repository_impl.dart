import 'package:flutter/material.dart';
import 'package:test_project_kiojuprivat/data/storage/key_value_store.dart';
import 'package:test_project_kiojuprivat/domain/entities/app_settings.dart';
import 'package:test_project_kiojuprivat/domain/repositories/app_settings_repository.dart';

class AppSettingsRepositoryImpl implements AppSettingsRepository {
  AppSettingsRepositoryImpl(this._store);

  final KeyValueStore _store;

  static const _kThemeMode = 'settings.themeMode';
  static const _kLocale = 'settings.locale';

  @override
  Future<AppSettings> load() async {
    final themeValue = _store.getString(_kThemeMode);
    final localeValue = _store.getString(_kLocale);

    final themeMode = switch (themeValue) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.light,
    };

    final locale = switch (localeValue) {
      'uk' => const Locale('uk'),
      'en' => const Locale('en'),
      _ => const Locale('uk'),
    };

    return AppSettings(themeMode: themeMode, locale: locale);
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await _store.setString(_kThemeMode, value);
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    await _store.setString(_kLocale, locale.languageCode);
  }
}
