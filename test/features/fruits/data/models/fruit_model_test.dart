import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/data/models/fruit_model.dart';

void main() {
  test('Fruit model can be instantiated', () {
    const fruit = Fruit(
      id: 1,
      name: 'Apple',
      family: 'Rosaceae',
      genus: 'Malus',
      order: 'Rosales',
      nutritions: Nutrition(
        sugar: 10.0,
        carbohydrates: 14.0,
        protein: 0.3,
        fat: 0.2,
        calories: 52,
      ),
    );
    expect(fruit.name, 'Apple');
    expect(fruit.nutritions.sugar, 10.0);
  });
}
