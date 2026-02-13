import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:test_project_kiojuprivat/domain/entities/history_rate.dart';

import 'package:test_project_kiojuprivat/app/extensions/l10n_extension.dart';

class RateStatsRow extends StatelessWidget {
  const RateStatsRow({
    super.key,
    required this.entries,
  });

  final List<HistoryRate> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final rates = entries.map((e) => e.rate).toList();
    final minRate = rates.reduce(math.min);
    final maxRate = rates.reduce(math.max);
    final avgRate = rates.reduce((a, b) => a + b) / rates.length;
    final change = rates.last - rates.first;
    final changePercent = rates.first != 0 ? (change / rates.first) * 100 : 0.0;

    final isPositive = change >= 0;

    return Row(
      children: <Widget>[
        Expanded(
          child: _StatCard(
            label: context.l10n.min,
            value: minRate.toStringAsFixed(4),
            icon: Icons.arrow_downward_rounded,
            iconColor: colors.error,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _StatCard(
            label: context.l10n.max,
            value: maxRate.toStringAsFixed(4),
            icon: Icons.arrow_upward_rounded,
            iconColor: colors.tertiary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _StatCard(
            label: context.l10n.avg,
            value: avgRate.toStringAsFixed(4),
            icon: Icons.trending_flat_rounded,
            iconColor: colors.secondary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _StatCard(
            label: context.l10n.change,
            value:
                '${isPositive ? '+' : ''}${changePercent.toStringAsFixed(2)}%',
            icon: isPositive
                ? Icons.trending_up_rounded
                : Icons.trending_down_rounded,
            iconColor: isPositive ? colors.tertiary : colors.error,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          children: <Widget>[
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(height: 6),
            Text(
              value,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
