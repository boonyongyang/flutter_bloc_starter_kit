import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/presentation/widgets/fruit_list_tile.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/models/fruit_model.dart';

void main() {
  testWidgets('FruitListTile displays fruit name and family',
      (WidgetTester tester) async {
    const fruit = Fruit(
      name: 'Orange',
      id: 3,
      family: 'Rutaceae',
      order: 'Sapindales',
      genus: 'Citrus',
      nutritions: Nutrition(
        calories: 47,
        fat: 0.1,
        sugar: 9.4,
        carbohydrates: 11.8,
        protein: 0.9,
      ),
    );
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FruitListTile(fruit: fruit),
        ),
      ),
    );
    expect(find.text('Orange'), findsOneWidget);
    expect(find.textContaining('Rutaceae'), findsOneWidget);
  });
}
