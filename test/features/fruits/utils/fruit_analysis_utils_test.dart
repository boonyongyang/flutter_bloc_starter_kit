import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/utils/fruit_analysis_utils.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/data/models/fruit_model.dart';

void main() {
  group('FruitAnalysisUtils', () {
    late List<Fruit> sampleFruits;

    setUp(() {
      sampleFruits = [
        Fruit(
          id: 1,
          name: 'Apple',
          family: 'Rosaceae',
          order: 'Rosales',
          genus: 'Malus',
          nutritions: const Nutrition(
            calories: 95,
            fat: 0.3,
            sugar: 19.0,
            carbohydrates: 25.0,
            protein: 0.5,
          ),
        ),
        Fruit(
          id: 2,
          name: 'Banana',
          family: 'Musaceae',
          order: 'Zingiberales',
          genus: 'Musa',
          nutritions: const Nutrition(
            calories: 105,
            fat: 0.4,
            sugar: 14.0,
            carbohydrates: 27.0,
            protein: 1.3,
          ),
        ),
        Fruit(
          id: 3,
          name: 'Orange',
          family: 'Rutaceae',
          order: 'Sapindales',
          genus: 'Citrus',
          nutritions: const Nutrition(
            calories: 62,
            fat: 0.2,
            sugar: 12.0,
            carbohydrates: 15.0,
            protein: 1.2,
          ),
        ),
      ];
    });

    test('calculateFruitAnalysisData returns correct analysis', () {
      final result = calculateFruitAnalysisData(sampleFruits);

      expect(result.fruitCount, equals(3));
      expect(result.avgCalories, equals((95 + 105 + 62) / 3));
      expect(result.avgProtein, equals((0.5 + 1.3 + 1.2) / 3));
      expect(result.avgSugar, equals((19.0 + 14.0 + 12.0) / 3));
      expect(result.avgCarbs, equals((25.0 + 27.0 + 15.0) / 3));
      expect(result.avgFat, equals((0.3 + 0.4 + 0.2) / 3));
    });

    test('calculateFruitAnalysisData finds correct highest calories fruit', () {
      final result = calculateFruitAnalysisData(sampleFruits);

      expect(result.highestCaloriesFruit.name, equals('Banana'));
      expect(result.highestCaloriesFruit.nutritions.calories, equals(105));
    });

    test('calculateFruitAnalysisData finds correct lowest calories fruit', () {
      final result = calculateFruitAnalysisData(sampleFruits);

      expect(result.lowestCaloriesFruit.name, equals('Orange'));
      expect(result.lowestCaloriesFruit.nutritions.calories, equals(62));
    });

    test('calculateFruitAnalysisData finds correct highest protein fruit', () {
      final result = calculateFruitAnalysisData(sampleFruits);

      expect(result.highestProteinFruit.name, equals('Banana'));
      expect(result.highestProteinFruit.nutritions.protein, equals(1.3));
    });

    test('calculateFruitAnalysisData finds correct highest sugar fruit', () {
      final result = calculateFruitAnalysisData(sampleFruits);

      expect(result.highestSugarFruit.name, equals('Apple'));
      expect(result.highestSugarFruit.nutritions.sugar, equals(19.0));
    });

    test('calculateFruitAnalysisData handles empty list', () {
      expect(() => calculateFruitAnalysisData([]), throwsA(isA<StateError>()));
    });

    test('calculateFruitAnalysisData handles single fruit', () {
      final singleFruit = [sampleFruits.first];
      final result = calculateFruitAnalysisData(singleFruit);

      expect(result.fruitCount, equals(1));
      expect(result.avgCalories, equals(95));
      expect(result.highestCaloriesFruit, equals(sampleFruits.first));
      expect(result.lowestCaloriesFruit, equals(sampleFruits.first));
      expect(result.highestProteinFruit, equals(sampleFruits.first));
      expect(result.highestSugarFruit, equals(sampleFruits.first));
    });
  });
}
