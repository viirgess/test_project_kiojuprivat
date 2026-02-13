import 'package:test_project_kiojuprivat/data/models/currency_rate_model.dart';
import 'package:test_project_kiojuprivat/domain/entities/currency_rate.dart';

class CurrencyRateMapper {
  static CurrencyRate toEntity(CurrencyRateModel model) {
    return CurrencyRate(
      code: model.code,
      name: model.name,
      nameEn: model.nameEn,
      rate: model.rate,
      exchangedAt: model.exchangedAt,
    );
  }

  static CurrencyRateModel toModel(CurrencyRate entity) {
    return CurrencyRateModel(
      code: entity.code,
      name: entity.name,
      nameEn: entity.nameEn,
      rate: entity.rate,
      exchangedAt: entity.exchangedAt,
    );
  }
}
