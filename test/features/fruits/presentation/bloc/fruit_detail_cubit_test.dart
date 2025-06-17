import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_bloc_starter_kit/features/fruits/presentation/bloc/fruit_detail_cubit.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/presentation/bloc/fruit_detail_state.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/data/i_fruits_repository.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/data/models/fruit_model.dart';

class MockIFruitsRepository extends Mock implements IFruitsRepository {}

void main() {
  group('FruitDetailCubit', () {
    late FruitDetailCubit cubit;
    late MockIFruitsRepository mockRepository;
    late Fruit testFruit;

    setUp(() {
      mockRepository = MockIFruitsRepository();
      cubit = FruitDetailCubit(mockRepository);
      
      testFruit = const Fruit(
        id: 1,
        name: 'Apple',
        family: 'Rosaceae',
        order: 'Rosales',
        genus: 'Malus',
        nutritions: Nutrition(
          calories: 95,
          fat: 0.3,
          sugar: 19.0,
          carbohydrates: 25.0,
          protein: 0.5,
        ),
      );
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is FruitDetailInitial', () {
      expect(cubit.state, equals(const FruitDetailInitial()));
    });

    blocTest<FruitDetailCubit, FruitDetailState>(
      'emits [FruitDetailLoading, FruitDetailLoaded] when fetchFruitDetail succeeds',
      build: () {
        when(() => mockRepository.fetchFruitDetailByName('Apple'))
            .thenAnswer((_) async => testFruit);
        return cubit;
      },
      act: (cubit) => cubit.fetchFruitDetail('Apple'),
      expect: () => [
        const FruitDetailLoading(),
        FruitDetailLoaded(fruit: testFruit),
      ],
      verify: (_) {
        verify(() => mockRepository.fetchFruitDetailByName('Apple')).called(1);
      },
    );

    blocTest<FruitDetailCubit, FruitDetailState>(
      'emits [FruitDetailLoading, FruitDetailError] when fetchFruitDetail fails',
      build: () {
        when(() => mockRepository.fetchFruitDetailByName('InvalidFruit'))
            .thenThrow(Exception('Fruit not found'));
        return cubit;
      },
      act: (cubit) => cubit.fetchFruitDetail('InvalidFruit'),
      expect: () => [
        const FruitDetailLoading(),
        const FruitDetailError('Exception: Fruit not found'),
      ],
      verify: (_) {
        verify(() => mockRepository.fetchFruitDetailByName('InvalidFruit')).called(1);
      },
    );

    blocTest<FruitDetailCubit, FruitDetailState>(
      'handles repository throwing string error',
      build: () {
        when(() => mockRepository.fetchFruitDetailByName('ErrorFruit'))
            .thenThrow('Network error');
        return cubit;
      },
      act: (cubit) => cubit.fetchFruitDetail('ErrorFruit'),
      expect: () => [
        const FruitDetailLoading(),
        const FruitDetailError('Network error'),
      ],
    );

    blocTest<FruitDetailCubit, FruitDetailState>(
      'does not emit new states when cubit is closed',
      build: () {
        when(() => mockRepository.fetchFruitDetailByName('Apple'))
            .thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return testFruit;
        });
        return cubit;
      },
      act: (cubit) async {
        cubit.fetchFruitDetail('Apple');
        await cubit.close();
      },
      expect: () => [const FruitDetailLoading()],
    );
  });
}
