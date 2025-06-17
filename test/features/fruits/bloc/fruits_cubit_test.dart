import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/presentation/bloc/fruits_cubit.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/presentation/bloc/fruits_state.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/data/models/fruit_model.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/data/i_fruits_repository.dart';

class MockFruitsRepository extends Mock implements IFruitsRepository {}

void main() {
  group('FruitsCubit', () {
    late FruitsCubit cubit;
    late MockFruitsRepository mockRepo;

    setUp(() {
      mockRepo = MockFruitsRepository();
      cubit = FruitsCubit(mockRepo);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is FruitsInitial', () {
      expect(cubit.state, isA<FruitsInitial>());
    });

    blocTest<FruitsCubit, FruitsState>(
      'emits [FruitsLoading, FruitsLoaded] when fetchFruits succeeds',
      build: () {
        when(() => mockRepo.fetchAllFruits()).thenAnswer((_) async => [
              const Fruit(
                name: 'Apple',
                id: 1,
                family: 'Rosaceae',
                order: 'Rosales',
                genus: 'Malus',
                nutritions: Nutrition(
                  calories: 52,
                  fat: 0.2,
                  sugar: 10.0,
                  carbohydrates: 14.0,
                  protein: 0.3,
                ),
              ),
            ]);
        return cubit;
      },
      act: (cubit) => cubit.fetchFruits(),
      expect: () => [
        isA<FruitsLoading>(),
        isA<FruitsLoaded>(),
      ],
    );

    blocTest<FruitsCubit, FruitsState>(
      'emits [FruitsLoading, FruitsError] when fetchFruits throws',
      build: () {
        when(() => mockRepo.fetchAllFruits()).thenThrow(Exception('error'));
        return cubit;
      },
      act: (cubit) => cubit.fetchFruits(),
      expect: () => [
        isA<FruitsLoading>(),
        isA<FruitsError>(),
      ],
    );
  });
}
