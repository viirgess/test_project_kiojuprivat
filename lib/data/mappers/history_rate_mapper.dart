import 'package:test_project_kiojuprivat/data/models/history_rate_model.dart';
import 'package:test_project_kiojuprivat/domain/entities/history_rate.dart';

class HistoryRateMapper {
  static HistoryRate toEntity(HistoryRateModel model) {
    return HistoryRate(date: model.date, rate: model.rate);
  }

  static HistoryRateModel toModel(HistoryRate entity) {
    return HistoryRateModel(date: entity.date, rate: entity.rate);
  }
}
