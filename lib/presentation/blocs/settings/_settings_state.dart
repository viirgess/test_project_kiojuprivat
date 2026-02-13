part of 'settings_bloc.dart';

extension SettingsStateX on SettingsState {
  bool get isReady => this is SettingsReady;

  SettingsReady get asReady => this as SettingsReady;
}

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => <Object?>[];
}

class SettingsReady extends SettingsState {
  const SettingsReady(this.settings);

  final AppSettings settings;

  @override
  List<Object?> get props => <Object?>[settings];
}
