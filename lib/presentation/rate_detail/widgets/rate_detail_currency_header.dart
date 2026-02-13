import 'package:flutter/material.dart';
import 'package:test_project_kiojuprivat/domain/entities/currency_rate.dart';
import 'package:test_project_kiojuprivat/app/theme/app_fonts.dart';
import 'package:test_project_kiojuprivat/app/helper/currency_search_helper.dart';



class RateDetailCurrencyHeader extends StatelessWidget {
  const RateDetailCurrencyHeader({
    super.key,
    required this.rate,
  });

  final CurrencyRate rate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(
                rate.code,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.eUkraine,
                  color: colors.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    CurrencySearchHelper.getLocalizedName(context, rate),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    rate.rate.toStringAsFixed(4),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontFamily: AppFonts.eUkraine,
                      fontWeight: FontWeight.w700,
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
