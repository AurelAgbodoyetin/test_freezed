part of 'counter_cubit.dart';

@freezed
class CounterState with _$CounterState {
  const factory CounterState.loading() = Loading;
  const factory CounterState.loaded({required int value}) = Loaded;
}
