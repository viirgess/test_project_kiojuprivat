import 'package:flutter/material.dart';
import 'package:test_project_kiojuprivat/domain/entities/app_settings.dart';

abstract interface class AppSettingsRepository {
  Future<AppSettings> load();
  Future<void> saveThemeMode(ThemeMode mode);
  Future<void> saveLocale(Locale locale);
}
