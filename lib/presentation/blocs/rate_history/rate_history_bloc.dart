import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project_kiojuprivat/domain/entities/history_rate.dart';
import 'package:test_project_kiojuprivat/domain/repositories/rates_repository.dart';



part '_rate_history_event.dart';
part '_rate_history_state.dart';

typedef _Emit = Emitter<RateHistoryState>;

class RateHistoryBloc extends Bloc<RateHistoryEvent, RateHistoryState> {
  RateHistoryBloc({
    required RatesRepository repository,
  })  : _repository = repository,
        super(const RateHistoryLoading()) {
    on<_RateHistoryRequested>(_onRequested);
    on<_RateHistoryPeriodChanged>(_onPeriodChanged);
  }

  final RatesRepository _repository;

  String _currencyCode = '';
  int _days = 30;

  Future<void> _onRequested(
    _RateHistoryRequested event,
    _Emit emit,
  ) async {
    _currencyCode = event.currencyCode;
    _days = event.days;
    await _load(emit);
  }

  Future<void> _onPeriodChanged(
    _RateHistoryPeriodChanged event,
    _Emit emit,
  ) async {
    _days = event.days;
    await _load(emit);
  }

  Future<void> _load(_Emit emit) async {
    try {
      emit(const RateHistoryLoading());
      final history = await _repository.getRateHistory(
        currencyCode: _currencyCode,
        days: _days,
      );
      emit(RateHistoryReady(entries: history, days: _days));
    } catch (error) {
      emit(RateHistoryError(message: error.toString()));
    }
  }
}
