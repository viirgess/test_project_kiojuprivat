import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project_kiojuprivat/domain/entities/currency_rate.dart';
import 'package:test_project_kiojuprivat/domain/repositories/rates_repository.dart';


part '_rates_event.dart';
part '_rates_state.dart';

typedef Emit = Emitter<RatesState>;

class RatesBloc extends Bloc<RatesEvent, RatesState> {
  RatesBloc({
    required RatesRepository repository,
  })  : _repository = repository,
        super(const RatesLoading()) {
    on<_RatesRequested>(_onRequested);
    on<_RatesRefreshed>(_onRefreshed);
  }

  final RatesRepository _repository;

  Future<void> _onRequested(
    _RatesRequested event,
    Emit emit,
  ) async {
    await _load(emit);
  }

  Future<void> _onRefreshed(
    _RatesRefreshed event,
    Emit emit,
  ) async {
    await _load(emit);
  }

  Future<void> _load(Emit emit) async {
    try {
      emit(const RatesLoading());
      final rates = await _repository.getRates();
      emit(RatesReady(rates));
    } catch (error) {
      emit(RatesError(message: error.toString()));
    }
  }
}

