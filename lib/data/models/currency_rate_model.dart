class CurrencyRateModel {
  const CurrencyRateModel({
    required this.code,
    required this.name,
    required this.nameEn,
    required this.rate,
    required this.exchangedAt,
  });

  factory CurrencyRateModel.fromJson(Map<String, dynamic> json) {
    final code = (json['cc'] as String?)?.trim();
    final name = (json['txt'] as String?)?.trim();
    final nameEn = (json['enname'] as String?)?.trim() ?? '';
    final dateStr = json['exchangedate'] as String?;

    if (code == null || name == null || dateStr == null) {
      throw FormatException('Missing required fields in JSON: $json');
    }

    final ratePerUnit = json['rate_per_unit'] ?? json['rate'];
    final rate = switch (ratePerUnit) {
      num n => n.toDouble(),
      String s => double.tryParse(s),
      _ => null,
    };
    if (rate == null) {
      throw FormatException('Invalid rate value: $ratePerUnit');
    }

    final parts = dateStr.split('.');
    final exchangedAt = (parts.length == 3)
        ? DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          )
        : DateTime.now();

    return CurrencyRateModel(
      code: code,
      name: name,
      nameEn: nameEn,
      rate: rate,
      exchangedAt: exchangedAt,
    );
  }

  final String code;
  final String name;
  final String nameEn;
  final double rate;
  final DateTime exchangedAt;

  Map<String, dynamic> toJson() {
    final d = exchangedAt.day.toString().padLeft(2, '0');
    final m = exchangedAt.month.toString().padLeft(2, '0');
    final y = exchangedAt.year.toString();
    return {
      'cc': code,
      'txt': name,
      'enname': nameEn,
      'rate': rate,
      'exchangedate': '$d.$m.$y',
    };
  }
}