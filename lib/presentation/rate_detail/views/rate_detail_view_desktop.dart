import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_project_kiojuprivat/app/extensions/l10n_extension.dart';
import 'package:test_project_kiojuprivat/domain/entities/currency_rate.dart';
import 'package:test_project_kiojuprivat/app/routing/app_routes.dart';
import 'package:test_project_kiojuprivat/presentation/blocs/rate_history/rate_history_bloc.dart';
import 'package:test_project_kiojuprivat/app/theme/app_fonts.dart';
import 'package:test_project_kiojuprivat/presentation/rate_detail/widgets/rate_chart.dart';
import 'package:test_project_kiojuprivat/presentation/rate_detail/widgets/rate_detail_currency_header.dart';
import 'package:test_project_kiojuprivat/presentation/rate_detail/widgets/rate_detail_period_selector.dart';
import 'package:test_project_kiojuprivat/presentation/rate_detail/widgets/rate_stats_row.dart';

class RateDetailViewDesktop extends StatelessWidget {
  const RateDetailViewDesktop({super.key, required this.rate});

  final CurrencyRate rate;

  static const double _chartHeight = 320.0;
  static const EdgeInsets _padding = EdgeInsets.symmetric(horizontal: 24);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => context.go(AppRoutes.rates),
                      icon: const Icon(Icons.arrow_back_rounded, size: 22),
                      tooltip: context.l10n.ratesTitle,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${rate.code} – ${context.l10n.rateHistory}',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontFamily: AppFonts.eUkraineHead,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                BlocBuilder<RateHistoryBloc, RateHistoryState>(
                  builder: (context, state) {
                    return Padding(
                      padding: _padding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          RateDetailCurrencyHeader(
                            rate: rate,
                          ),
                          const SizedBox(height: 20),
                          RateDetailPeriodSelector(
                            state: state,
                          ),
                          const SizedBox(height: 20),
                          _buildChartBlock(context, state),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChartBlock(
    BuildContext context,
    RateHistoryState state,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (state.isLoading) {
      return SizedBox(
        height: _chartHeight,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (state.isError) {
      return SizedBox(
        height: _chartHeight,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.cloud_off_rounded, size: 48, color: colors.error),
              const SizedBox(height: 12),
              Text(
                state.asError.message ?? '',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => context.read<RateHistoryBloc>().requestHistory(
                  currencyCode: rate.code,
                ),
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: Text(context.l10n.retry),
              ),
            ],
          ),
        ),
      );
    }
    if (state.isReady) {
      if (state.asReady.entries.isEmpty) {
        return SizedBox(
          height: _chartHeight,
          child: Center(
            child: Text(
              context.l10n.noHistoryData,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 16, 12),
              child: SizedBox(
                height: _chartHeight,
                child: RateChart(
                  entries: state.asReady.entries,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          RateStatsRow(
            entries: state.asReady.entries,
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
