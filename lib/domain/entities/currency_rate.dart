class CurrencyRate {
  const CurrencyRate({
    required this.code,
    required this.name,
    required this.nameEn,
    required this.rate,
    required this.exchangedAt,
  });

  final String code;
  final String name;
  final String nameEn;
  final double rate;
  final DateTime exchangedAt;
}