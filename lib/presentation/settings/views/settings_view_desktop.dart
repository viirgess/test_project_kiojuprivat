import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_project_kiojuprivat/app/extensions/l10n_extension.dart';
import 'package:test_project_kiojuprivat/presentation/blocs/settings/settings_bloc.dart';
import 'package:test_project_kiojuprivat/presentation/settings/widgets/settings_language_chip.dart';
import 'package:test_project_kiojuprivat/presentation/settings/widgets/settings_section_header.dart';
import 'package:test_project_kiojuprivat/app/theme/app_fonts.dart';

class SettingsViewDesktop extends StatelessWidget {
  const SettingsViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ListView(
            padding: const EdgeInsets.all(32),
            children: <Widget>[
              Text(
                context.l10n.settingsTitle,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontFamily: AppFonts.eUkraineHead,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              BlocBuilder<SettingsBloc, SettingsState>(
                buildWhen: (prev, next) => prev != next,
                builder: (context, state) {
                  if (!state.isReady) return const SizedBox.shrink();
                  final settings = state.asReady.settings;
                  final bloc = context.read<SettingsBloc>();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SettingsSectionHeader(
                        title: context.l10n.theme,
                        icon: Icons.palette_outlined,
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: settings.themeMode == ThemeMode.dark,
                        onChanged: (value) => bloc.setThemeMode(
                          value ? ThemeMode.dark : ThemeMode.light,
                        ),
                        title: Text(context.l10n.darkTheme),
                      ),
                      const SizedBox(height: 24),
                      SettingsSectionHeader(
                        title: context.l10n.language,
                        icon: Icons.language,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: <Widget>[
                          SettingsLanguageChip(
                            flag: '🇺🇦',
                            label: context.l10n.ukrainian,
                            isSelected: settings.locale.languageCode == 'uk',
                            onTap: () => bloc.setLocale(const Locale('uk')),
                          ),
                          SettingsLanguageChip(
                            flag: '🇬🇧',
                            label: context.l10n.english,
                            isSelected: settings.locale.languageCode == 'en',
                            onTap: () => bloc.setLocale(const Locale('en')),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
