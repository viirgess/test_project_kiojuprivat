import 'package:flutter/material.dart';

import 'package:test_project_kiojuprivat/app/extensions/l10n_extension.dart';

class RatesUpdatedAtHeader extends StatelessWidget {
  const RatesUpdatedAtHeader({
    super.key,
    required this.updatedAt,
  });

  final DateTime updatedAt;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.schedule_rounded,
            size: 14,
            color: colors.onSurfaceVariant,
          ),
          const SizedBox(width: 6),
          Text(
            '${context.l10n.updatedAt}: '
            '${updatedAt.day.toString().padLeft(2, '0')}.'
            '${updatedAt.month.toString().padLeft(2, '0')}.'
            '${updatedAt.year}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
