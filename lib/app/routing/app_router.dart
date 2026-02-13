import 'package:go_router/go_router.dart';
import 'package:test_project_kiojuprivat/domain/entities/currency_rate.dart';
import 'package:test_project_kiojuprivat/presentation/shared/adaptive/adaptive_builder.dart';
import 'package:test_project_kiojuprivat/presentation/shared/desktop_shell/desktop_shell.dart';
import 'package:test_project_kiojuprivat/presentation/home/home_screen.dart';
import 'package:test_project_kiojuprivat/presentation/rates/rates_screen.dart';
import 'package:test_project_kiojuprivat/presentation/rate_detail/rate_detail_screen.dart';
import 'package:test_project_kiojuprivat/presentation/settings/settings_screen.dart';

import 'app_routes.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, child) {
          if (AdaptiveBuilder.useDesktopLayout(context)) {
            return DesktopShell(child: child);
          }
          return child;
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.rates,
            builder: (context, state) => const RatesScreen(),
          ),
          GoRoute(
            path: AppRoutes.rateDetail,
            builder: (context, state) {
              final rate = state.extra! as CurrencyRate;
              return RateDetailScreen(rate: rate);
            },
          ),
          GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}
