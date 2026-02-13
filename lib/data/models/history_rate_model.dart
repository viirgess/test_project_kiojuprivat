class HistoryRateModel {
  const HistoryRateModel({required this.date, required this.rate});

  factory HistoryRateModel.fromJson(Map<String, dynamic> json) {
    final rateNum = json['rate'];
    final dateStr = json['exchangedate'] as String?;

    if (dateStr == null) {
      throw FormatException('Missing exchangedate in JSON: $json');
    }

    final rate = switch (rateNum) {
      num n => n.toDouble(),
      String s => double.tryParse(s),
      _ => null,
    };
    if (rate == null) {
      throw FormatException('Invalid rate value: $rateNum');
    }

    final parts = dateStr.split('.');
    final date = (parts.length == 3)
        ? DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          )
        : DateTime.now();

    return HistoryRateModel(date: date, rate: rate);
  }

  final DateTime date;
  final double rate;

  Map<String, dynamic> toJson() {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    final y = date.year.toString();
    return {'rate': rate, 'exchangedate': '$d.$m.$y'};
  }
}
