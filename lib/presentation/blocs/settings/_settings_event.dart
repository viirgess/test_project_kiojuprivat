part of 'settings_bloc.dart';

extension SettingsEventX on SettingsBloc {
  void setThemeMode(ThemeMode mode) =>
      add(_SettingsThemeModeChanged(mode));

  void setLocale(Locale locale) =>
      add(_SettingsLocaleChanged(locale));
}

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class _SettingsThemeModeChanged extends SettingsEvent {
  const _SettingsThemeModeChanged(this.themeMode);

  final ThemeMode themeMode;

  @override
  List<Object?> get props => <Object?>[themeMode];
}

class _SettingsLocaleChanged extends SettingsEvent {
  const _SettingsLocaleChanged(this.locale);

  final Locale locale;

  @override
  List<Object?> get props => <Object?>[locale];
}
