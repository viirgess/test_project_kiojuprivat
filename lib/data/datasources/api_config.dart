import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConfig {
  static const String _proxyBaseUrl = 'http://localhost:3000/api';
  static const String _nbuExchangeSiteUrl =
      'https://bank.gov.ua/NBU_Exchange/exchange_site';

  static String get exchangeUrl =>
      kIsWeb ? '$_proxyBaseUrl/exchange' : _nbuExchangeSiteUrl;

  static bool get isWeb => kIsWeb;
}
