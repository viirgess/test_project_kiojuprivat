part of 'rate_history_bloc.dart';

extension RateHistoryEventX on RateHistoryBloc {
  void requestHistory({required String currencyCode, int days = 30}) =>
      add(_RateHistoryRequested(currencyCode: currencyCode, days: days));

  void changePeriod(int days) => add(_RateHistoryPeriodChanged(days: days));
}

abstract class RateHistoryEvent extends Equatable {
  const RateHistoryEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class _RateHistoryRequested extends RateHistoryEvent {
  const _RateHistoryRequested({
    required this.currencyCode,
    required this.days,
  });

  final String currencyCode;
  final int days;

  @override
  List<Object?> get props => <Object?>[currencyCode, days];
}

class _RateHistoryPeriodChanged extends RateHistoryEvent {
  const _RateHistoryPeriodChanged({required this.days});

  final int days;

  @override
  List<Object?> get props => <Object?>[days];
}
