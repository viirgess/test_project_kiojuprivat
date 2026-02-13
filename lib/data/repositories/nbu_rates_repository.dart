import 'package:test_project_kiojuprivat/data/datasources/nbu_rates_api.dart';
import 'package:test_project_kiojuprivat/data/mappers/currency_rate_mapper.dart';
import 'package:test_project_kiojuprivat/data/mappers/history_rate_mapper.dart';
import 'package:test_project_kiojuprivat/data/models/currency_rate_model.dart';
import 'package:test_project_kiojuprivat/data/models/history_rate_model.dart';
import 'package:test_project_kiojuprivat/domain/entities/currency_rate.dart';
import 'package:test_project_kiojuprivat/domain/entities/history_rate.dart';
import 'package:test_project_kiojuprivat/domain/repositories/rates_repository.dart';
import 'package:test_project_kiojuprivat/app/helper/date_formatter.dart';


class NbuRatesRepository implements RatesRepository {
  NbuRatesRepository(this._api);

  final NbuRatesApi _api;

  final _historyCache = <String, _CacheEntry>{};

  @override
  Future<List<CurrencyRate>> getRates() async {
    final raw = await _api.fetchRatesRaw();
    final result = <CurrencyRate>[];

    for (final item in raw) {
      try {
        final model = CurrencyRateModel.fromJson(item);
        result.add(CurrencyRateMapper.toEntity(model));
      } on FormatException {
        continue;
      }
    }

    result.sort((a, b) => a.code.compareTo(b.code));
    return result;
  }

  @override
  Future<List<HistoryRate>> getRateHistory({
    required String currencyCode,
    int days = 30,
  }) async {
    final cacheKey = '${currencyCode}_$days';

    final cached = _historyCache[cacheKey];
    if (cached != null && cached.isFresh) {
      return cached.entries;
    }

    final now = DateTime.now();
    final start = now.subtract(Duration(days: days));

    final raw = await _api.fetchRatesForRange(
      valcode: currencyCode,
      start: DateFormatter.formatDate(start),
      end: DateFormatter.formatDate(now),
    );

    final entries = _parseHistoryEntries(raw);

    _historyCache[cacheKey] = _CacheEntry(
      entries: entries,
      fetchedAt: DateTime.now(),
    );

    return entries;
  }

  List<HistoryRate> _parseHistoryEntries(List<Map<String, dynamic>> raw) {
    final entries = <HistoryRate>[];

    for (final item in raw) {
      try {
        final model = HistoryRateModel.fromJson(item);
        entries.add(HistoryRateMapper.toEntity(model));
      } on FormatException {
        continue;
      }
    }

    entries.sort((a, b) => a.date.compareTo(b.date));
    return entries;
  }
}

class _CacheEntry {
  _CacheEntry({required this.entries, required this.fetchedAt});

  final List<HistoryRate> entries;
  final DateTime fetchedAt;

  /// cache is valid for 10 minutes
  bool get isFresh => DateTime.now().difference(fetchedAt).inMinutes < 10;
}
