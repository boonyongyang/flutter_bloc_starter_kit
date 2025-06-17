import '../data/models/fruit_model.dart';

class FruitAnalysisData {
  final double avgSugar;
  final double avgCarbs;
  final double avgProtein;
  final double avgFat;
  final double avgCalories;
  final Fruit highestCaloriesFruit;
  final Fruit highestProteinFruit;
  final Fruit highestSugarFruit;
  final Fruit lowestCaloriesFruit;
  final int fruitCount;

  FruitAnalysisData({
    required this.avgSugar,
    required this.avgCarbs,
    required this.avgProtein,
    required this.avgFat,
    required this.avgCalories,
    required this.highestCaloriesFruit,
    required this.highestProteinFruit,
    required this.highestSugarFruit,
    required this.lowestCaloriesFruit,
    required this.fruitCount,
  });
}

// Function to calculate nutritional averages and find extremes
FruitAnalysisData calculateFruitAnalysisData(List<Fruit> sortedFruits) {
  if (sortedFruits.isEmpty) {
    throw ArgumentError('Fruit list cannot be empty for analysis.');
  }

  double totalSugar = 0,
      totalCarbs = 0,
      totalProtein = 0,
      totalFat = 0,
      totalCalories = 0;

  Fruit highestCaloriesFruit = sortedFruits.first;
  Fruit highestProteinFruit = sortedFruits.first;
  Fruit highestSugarFruit = sortedFruits.first;
  Fruit lowestCaloriesFruit = sortedFruits.first;

  for (final fruit in sortedFruits) {
    totalSugar += fruit.nutritions.sugar;
    totalCarbs += fruit.nutritions.carbohydrates;
    totalProtein += fruit.nutritions.protein;
    totalFat += fruit.nutritions.fat;
    totalCalories += fruit.nutritions.calories;

    if (fruit.nutritions.calories > highestCaloriesFruit.nutritions.calories) {
      highestCaloriesFruit = fruit;
    }
    if (fruit.nutritions.protein > highestProteinFruit.nutritions.protein) {
      highestProteinFruit = fruit;
    }
    if (fruit.nutritions.sugar > highestSugarFruit.nutritions.sugar) {
      highestSugarFruit = fruit;
    }
    if (fruit.nutritions.calories < lowestCaloriesFruit.nutritions.calories) {
      lowestCaloriesFruit = fruit;
    }
  }

  final fruitCount = sortedFruits.length;
  final avgSugar = fruitCount > 0 ? totalSugar / fruitCount : 0.0;
  final avgCarbs = fruitCount > 0 ? totalCarbs / fruitCount : 0.0;
  final avgProtein = fruitCount > 0 ? totalProtein / fruitCount : 0.0;
  final avgFat = fruitCount > 0 ? totalFat / fruitCount : 0.0;
  final avgCalories = fruitCount > 0 ? totalCalories / fruitCount : 0.0;

  return FruitAnalysisData(
    avgSugar: avgSugar,
    avgCarbs: avgCarbs,
    avgProtein: avgProtein,
    avgFat: avgFat,
    avgCalories: avgCalories,
    highestCaloriesFruit: highestCaloriesFruit,
    highestProteinFruit: highestProteinFruit,
    highestSugarFruit: highestSugarFruit,
    lowestCaloriesFruit: lowestCaloriesFruit,
    fruitCount: fruitCount,
  );
}
