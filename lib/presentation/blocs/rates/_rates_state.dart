part of 'rates_bloc.dart';

extension RatesStateX on RatesState {
  bool get isLoading => this is RatesLoading;

  bool get isReady => this is RatesReady;

  bool get isError => this is RatesError;

  RatesReady get asReady => this as RatesReady;

  RatesError get asError => this as RatesError;
}

abstract class RatesState extends Equatable {
  const RatesState();

  @override
  List<Object?> get props => <Object?>[];
}

class RatesLoading extends RatesState {
  const RatesLoading();
}

class RatesReady extends RatesState {
  const RatesReady(this.rates);

  final List<CurrencyRate> rates;

  @override
  List<Object?> get props => <Object?>[rates];
}

class RatesError extends RatesState {
  const RatesError({this.message});

  final String? message;

  @override
  List<Object?> get props => <Object?>[message];
}
