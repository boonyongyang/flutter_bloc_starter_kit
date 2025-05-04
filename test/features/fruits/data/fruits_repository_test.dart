import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/data/fruits_repository.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/models/fruit_model.dart';

class MockFruitsRepository extends Mock implements FruitsRepository {}

void main() {
  group('FruitsRepository', () {
    late MockFruitsRepository repo;

    setUp(() {
      repo = MockFruitsRepository();
    });

    test('fetchAllFruits returns a list of fruits', () async {
      when(() => repo.fetchAllFruits()).thenAnswer((_) async => [
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
      final fruits = await repo.fetchAllFruits();
      expect(fruits, isA<List<Fruit>>());
      expect(fruits.first.name, 'Apple');
    });
  });
}
