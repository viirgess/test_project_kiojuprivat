import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_project_kiojuprivat/app/extensions/l10n_extension.dart';
import 'package:test_project_kiojuprivat/presentation/blocs/rate_history/rate_history_bloc.dart';

class RateDetailPeriodSelector extends StatelessWidget {
  const RateDetailPeriodSelector({
    super.key,
    required this.state,
  });

  final RateHistoryState state;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final selectedDays = state.isReady ? state.asReady.days : 30;

    final periods = <RateDetailPeriod>[
      RateDetailPeriod(label: context.l10n.days7, days: 7),
      RateDetailPeriod(label: context.l10n.days30, days: 30),
      RateDetailPeriod(label: context.l10n.days90, days: 90),
      RateDetailPeriod(label: context.l10n.days180, days: 180),
      RateDetailPeriod(label: context.l10n.days365, days: 365),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: periods.map((p) {
          final isSelected = p.days == selectedDays;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(p.label),
              onSelected: (_) =>
                  context.read<RateHistoryBloc>().changePeriod(p.days),
              selectedColor: colors.primaryContainer,
              checkmarkColor: colors.onPrimaryContainer,
              labelStyle: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
                color: isSelected
                    ? colors.onPrimaryContainer
                    : colors.onSurfaceVariant,
              ),
              side: BorderSide(
                color: isSelected
                    ? colors.primary.withValues(alpha: 0.3)
                    : colors.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class RateDetailPeriod {
  const RateDetailPeriod({required this.label, required this.days});
  final String label;
  final int days;
}
