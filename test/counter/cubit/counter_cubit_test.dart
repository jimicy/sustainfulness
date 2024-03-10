import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:global_citizen_game/counter/counter.dart';

import '../../helpers/hydrated_bloc.dart';

void main() {
  initHydratedStorage();

  group('CounterCubit', () {
    test('initial state is 0', () {
      expect(CounterCubit().state, equals(0));
    });

    blocTest<CounterCubit, int>(
      'emits [1] when increment is called',
      build: CounterCubit.new,
      act: (cubit) => cubit.increment(),
      expect: () => [equals(1)],
    );

    blocTest<CounterCubit, int>(
      'emits [-1] when decrement is called',
      build: CounterCubit.new,
      act: (cubit) => cubit.decrement(),
      expect: () => [equals(-1)],
    );
  });
}
