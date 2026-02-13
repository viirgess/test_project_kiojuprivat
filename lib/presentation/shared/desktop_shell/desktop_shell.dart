import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:test_project_kiojuprivat/app/extensions/l10n_extension.dart';
import 'package:test_project_kiojuprivat/app/routing/app_routes.dart';
import 'package:test_project_kiojuprivat/app/theme/app_fonts.dart';

class DesktopShell extends StatelessWidget {
  const DesktopShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final location = GoRouterState.of(context).uri.toString();

    final selectedIndex = _indexFromLocation(location);

    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: colors.outlineVariant.withValues(alpha: 0.3),
                ),
              ),
            ),
            child: NavigationRail(
              selectedIndex: selectedIndex,
              extended: MediaQuery.sizeOf(context).width >= 900,
              minExtendedWidth: 200,
              backgroundColor: colors.surface,
              indicatorColor: colors.primaryContainer,
              onDestinationSelected: (index) =>
                  _onDestinationSelected(context, index),
              leading: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 24),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colors.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.currency_exchange_rounded,
                        color: colors.onPrimaryContainer,
                        size: 20,
                      ),
                    ),
                    if (MediaQuery.sizeOf(context).width >= 900) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Test App',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontFamily: AppFonts.eUkraineHead,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home_rounded),
                  label: Text(context.l10n.homeTitle),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.currency_exchange_outlined),
                  selectedIcon: const Icon(Icons.currency_exchange_rounded),
                  label: Text(context.l10n.ratesTitle),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings_rounded),
                  label: Text(context.l10n.settingsTitle),
                ),
              ],
            ),
          ),

          Expanded(child: child),
        ],
      ),
    );
  }

  int _indexFromLocation(String location) {
    if (location.startsWith(AppRoutes.rates)) return 1;
    if (location.startsWith(AppRoutes.settings)) return 2;
    return 0;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    final route = switch (index) {
      1 => AppRoutes.rates,
      2 => AppRoutes.settings,
      _ => AppRoutes.home,
    };
    context.go(route);
  }
}
