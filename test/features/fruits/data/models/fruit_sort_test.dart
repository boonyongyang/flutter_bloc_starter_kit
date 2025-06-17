import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/data/models/fruit_sort.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/data/models/fruit_model.dart';

void main() {
  group('FruitSort', () {
    late List<Fruit> testFruits;

    setUp(() {
      testFruits = [
        const Fruit(
          id: 1,
          name: 'Zebra Fruit',
          family: 'Family1',
          order: 'Order1',
          genus: 'Genus1',
          nutritions: Nutrition(
            calories: 50,
            fat: 1.0,
            sugar: 5.0,
            carbohydrates: 10.0,
            protein: 2.0,
          ),
        ),
        const Fruit(
          id: 2,
          name: 'Apple',
          family: 'Family2',
          order: 'Order2',
          genus: 'Genus2',
          nutritions: Nutrition(
            calories: 100,
            fat: 2.0,
            sugar: 15.0,
            carbohydrates: 20.0,
            protein: 1.0,
          ),
        ),
        const Fruit(
          id: 3,
          name: 'Banana',
          family: 'Family3',
          order: 'Order3',
          genus: 'Genus3',
          nutritions: Nutrition(
            calories: 75,
            fat: 0.5,
            sugar: 10.0,
            carbohydrates: 15.0,
            protein: 3.0,
          ),
        ),
      ];
    });

    test('has correct labels', () {
      expect(FruitSort.name.label, equals('Name (A-Z)'));
      expect(FruitSort.sugar.label, equals('Sugar (High to Low)'));
      expect(FruitSort.sugarLow.label, equals('Sugar (Low to High)'));
      expect(FruitSort.protein.label, equals('Protein (High to Low)'));
      expect(FruitSort.fat.label, equals('Fat (High to Low)'));
      expect(FruitSort.calories.label, equals('Calories (High to Low)'));
    });

    test('sorts by name alphabetically', () {
      final sorted = List<Fruit>.from(testFruits)..sort(FruitSort.name.compare);

      expect(sorted[0].name, equals('Apple'));
      expect(sorted[1].name, equals('Banana'));
      expect(sorted[2].name, equals('Zebra Fruit'));
    });

    test('sorts by sugar high to low', () {
      final sorted = List<Fruit>.from(testFruits)
        ..sort(FruitSort.sugar.compare);

      expect(sorted[0].nutritions.sugar, equals(15.0)); // Apple
      expect(sorted[1].nutritions.sugar, equals(10.0)); // Banana
      expect(sorted[2].nutritions.sugar, equals(5.0)); // Zebra Fruit
    });

    test('sorts by sugar low to high', () {
      final sorted = List<Fruit>.from(testFruits)
        ..sort(FruitSort.sugarLow.compare);

      expect(sorted[0].nutritions.sugar, equals(5.0)); // Zebra Fruit
      expect(sorted[1].nutritions.sugar, equals(10.0)); // Banana
      expect(sorted[2].nutritions.sugar, equals(15.0)); // Apple
    });

    test('sorts by protein high to low', () {
      final sorted = List<Fruit>.from(testFruits)
        ..sort(FruitSort.protein.compare);

      expect(sorted[0].nutritions.protein, equals(3.0)); // Banana
      expect(sorted[1].nutritions.protein, equals(2.0)); // Zebra Fruit
      expect(sorted[2].nutritions.protein, equals(1.0)); // Apple
    });

    test('sorts by fat high to low', () {
      final sorted = List<Fruit>.from(testFruits)..sort(FruitSort.fat.compare);

      expect(sorted[0].nutritions.fat, equals(2.0)); // Apple
      expect(sorted[1].nutritions.fat, equals(1.0)); // Zebra Fruit
      expect(sorted[2].nutritions.fat, equals(0.5)); // Banana
    });

    test('sorts by calories high to low', () {
      final sorted = List<Fruit>.from(testFruits)
        ..sort(FruitSort.calories.compare);

      expect(sorted[0].nutritions.calories, equals(100)); // Apple
      expect(sorted[1].nutritions.calories, equals(75)); // Banana
      expect(sorted[2].nutritions.calories, equals(50)); // Zebra Fruit
    });

    test('handles case insensitive name sorting', () {
      final mixedCaseFruits = [
        const Fruit(
          id: 1,
          name: 'ZEBRA FRUIT',
          family: 'Family1',
          order: 'Order1',
          genus: 'Genus1',
          nutritions: Nutrition(
            calories: 50,
            fat: 1.0,
            sugar: 5.0,
            carbohydrates: 10.0,
            protein: 2.0,
          ),
        ),
        const Fruit(
          id: 2,
          name: 'apple',
          family: 'Family2',
          order: 'Order2',
          genus: 'Genus2',
          nutritions: Nutrition(
            calories: 100,
            fat: 2.0,
            sugar: 15.0,
            carbohydrates: 20.0,
            protein: 1.0,
          ),
        ),
      ];

      final sorted = List<Fruit>.from(mixedCaseFruits)
        ..sort(FruitSort.name.compare);

      expect(sorted[0].name, equals('apple'));
      expect(sorted[1].name, equals('ZEBRA FRUIT'));
    });
  });
}
