import 'package:test_project_kiojuprivat/domain/entities/currency_rate.dart';
import 'package:test_project_kiojuprivat/domain/entities/history_rate.dart';

abstract interface class RatesRepository {
  Future<List<CurrencyRate>> getRates();

  Future<List<HistoryRate>> getRateHistory({
    required String currencyCode,
    int days = 30,
  });
}
