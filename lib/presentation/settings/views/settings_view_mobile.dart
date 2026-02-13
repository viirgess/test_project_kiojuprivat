import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_project_kiojuprivat/app/extensions/l10n_extension.dart';
import 'package:test_project_kiojuprivat/presentation/blocs/settings/settings_bloc.dart';
import 'package:test_project_kiojuprivat/presentation/settings/widgets/settings_language_option.dart';
import 'package:test_project_kiojuprivat/presentation/settings/widgets/settings_section_header.dart';
import 'package:test_project_kiojuprivat/presentation/shared/app_bar/primary_app_bar.dart';

class SettingsViewMobile extends StatelessWidget {
  const SettingsViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: context.l10n.settingsTitle),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (prev, next) => prev != next,
        builder: (context, state) {
          if (!state.isReady) return const SizedBox.shrink();
          final settings = state.asReady.settings;
          final bloc = context.read<SettingsBloc>();

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: <Widget>[
              SettingsSectionHeader(
                title: context.l10n.theme,
                icon: Icons.palette_outlined,
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                value: settings.themeMode == ThemeMode.dark,
                onChanged: (value) =>
                    bloc.setThemeMode(value ? ThemeMode.dark : ThemeMode.light),
                title: Text(context.l10n.darkTheme),
              ),
              const SizedBox(height: 24),
              SettingsSectionHeader(
                title: context.l10n.language,
                icon: Icons.language,
              ),
              const SizedBox(height: 8),
              SettingsLanguageOption(
                flag: '🇺🇦',
                label: context.l10n.ukrainian,
                isSelected: settings.locale.languageCode == 'uk',
                onTap: () => bloc.setLocale(const Locale('uk')),
              ),
              SettingsLanguageOption(
                flag: '🇬🇧',
                label: context.l10n.english,
                isSelected: settings.locale.languageCode == 'en',
                onTap: () => bloc.setLocale(const Locale('en')),
              ),
            ],
          );
        },
      ),
    );
  }
}
