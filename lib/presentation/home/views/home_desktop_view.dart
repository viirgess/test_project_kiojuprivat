import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project_kiojuprivat/app/extensions/l10n_extension.dart';
import 'package:test_project_kiojuprivat/app/routing/app_routes.dart';
import 'package:test_project_kiojuprivat/presentation/home/widgets/home_greeting_card.dart';
import 'package:test_project_kiojuprivat/presentation/home/widgets/home_nav_card.dart';
import 'package:test_project_kiojuprivat/app/theme/app_fonts.dart';

class HomeDesktopView extends StatelessWidget {
  const HomeDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  context.l10n.homeTitle,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontFamily: AppFonts.eUkraineHead,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 24),
                    const HomeGreetingCard(),
                    const SizedBox(height: 32),
                    HomeNavCard(
                      icon: Icons.currency_exchange_rounded,
                      label: context.l10n.openRates,
                      subtitle: context.l10n.openRatesSubtitle,
                      color: colors.tertiary,
                      containerColor: colors.tertiaryContainer,
                      onTap: () => context.push(AppRoutes.rates),
                    ),
                    const SizedBox(height: 12),
                    HomeNavCard(
                      icon: Icons.tune_rounded,
                      label: context.l10n.openSettings,
                      subtitle: context.l10n.openSettingsSubtitle,
                      color: colors.secondary,
                      containerColor: colors.secondaryContainer,
                      onTap: () => context.push(AppRoutes.settings),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
