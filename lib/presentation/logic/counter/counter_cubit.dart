import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'counter_cubit.freezed.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState.loaded(value: 0));

  void increment(int value) {
    emit(const CounterState.loading());
    Future.delayed(const Duration(seconds: 2), () {
      emit(CounterState.loaded(value: value + 1));
    });
  }

  void decrement(int value) {
    emit(const CounterState.loading());
    Future.delayed(const Duration(seconds: 2), () {
      emit(CounterState.loaded(value: value - 1));
    });
  }
}
