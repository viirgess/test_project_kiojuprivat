part of 'rate_history_bloc.dart';

extension RateHistoryStateX on RateHistoryState {
  bool get isLoading => this is RateHistoryLoading;

  bool get isReady => this is RateHistoryReady;

  bool get isError => this is RateHistoryError;

  RateHistoryReady get asReady => this as RateHistoryReady;

  RateHistoryError get asError => this as RateHistoryError;
}

abstract class RateHistoryState extends Equatable {
  const RateHistoryState();

  @override
  List<Object?> get props => <Object?>[];
}

class RateHistoryLoading extends RateHistoryState {
  const RateHistoryLoading();
}

class RateHistoryReady extends RateHistoryState {
  const RateHistoryReady({required this.entries, required this.days});

  final List<HistoryRate> entries;
  final int days;

  @override
  List<Object?> get props => <Object?>[entries, days];
}

class RateHistoryError extends RateHistoryState {
  const RateHistoryError({this.message});

  final String? message;

  @override
  List<Object?> get props => <Object?>[message];
}
