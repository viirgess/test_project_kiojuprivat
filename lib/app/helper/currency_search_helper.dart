import 'package:flutter/widgets.dart';
import 'package:test_project_kiojuprivat/domain/entities/currency_rate.dart';

class CurrencySearchHelper {
  CurrencySearchHelper._();

  static String getLocalizedName(BuildContext context, CurrencyRate rate) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'uk' ? rate.name : rate.nameEn;
  }

  static List<CurrencyRate> filter(
    BuildContext context,
    List<CurrencyRate> rates,
    String query,
  ) {
    if (query.isEmpty) return rates;

    final q = query.toLowerCase().trim();

    return rates.where((rate) {
      final code = rate.code.toLowerCase();
      final localizedName = getLocalizedName(context, rate).toLowerCase();

      return code.contains(q) || localizedName.contains(q);
    }).toList();
  }
}
