part of 'rates_bloc.dart';

extension RatesEventX on RatesBloc {
  void requestRates() => add(const _RatesRequested());

  void refreshRates() => add(const _RatesRefreshed());
}

abstract class RatesEvent extends Equatable {
  const RatesEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class _RatesRequested extends RatesEvent {
  const _RatesRequested();
}

class _RatesRefreshed extends RatesEvent {
  const _RatesRefreshed();
}

