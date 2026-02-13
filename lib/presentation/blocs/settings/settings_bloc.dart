import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project_kiojuprivat/domain/entities/app_settings.dart';
import 'package:test_project_kiojuprivat/domain/repositories/app_settings_repository.dart';

part '_settings_event.dart';
part '_settings_state.dart';

typedef _Emit = Emitter<SettingsState>;

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required AppSettingsRepository repository,
    required AppSettings initialSettings,
  }) : _repository = repository,
       super(SettingsReady(initialSettings)) {
    on<_SettingsThemeModeChanged>(_onThemeModeChanged);
    on<_SettingsLocaleChanged>(_onLocaleChanged);
  }

  final AppSettingsRepository _repository;

  Future<void> _onThemeModeChanged(
    _SettingsThemeModeChanged event,
    _Emit emit,
  ) async {
    final current = state.asReady;
    final updated = current.settings.copyWith(themeMode: event.themeMode);
    emit(SettingsReady(updated));
    await _repository.saveThemeMode(event.themeMode);
  }

  Future<void> _onLocaleChanged(
    _SettingsLocaleChanged event,
    _Emit emit,
  ) async {
    final current = state.asReady;
    final updated = current.settings.copyWith(locale: event.locale);
    emit(SettingsReady(updated));
    await _repository.saveLocale(event.locale);
  }
}
