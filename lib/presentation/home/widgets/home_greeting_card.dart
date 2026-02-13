import 'package:flutter/material.dart';
import 'package:test_project_kiojuprivat/app/extensions/l10n_extension.dart';

class HomeGreetingCard extends StatelessWidget {
  const HomeGreetingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[colors.primaryContainer, colors.secondaryContainer],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.waving_hand_rounded,
            size: 36,
            color: colors.onPrimaryContainer,
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.greeting,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.onPrimaryContainer,
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
