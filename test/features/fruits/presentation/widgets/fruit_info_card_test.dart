import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/presentation/widgets/fruit_info_card.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/models/fruit_model.dart';

void main() {
  testWidgets('FruitInfoCard displays fruit info', (WidgetTester tester) async {
    const fruit = Fruit(
      name: 'Banana',
      id: 2,
      family: 'Musaceae',
      order: 'Zingiberales',
      genus: 'Musa',
      nutritions: Nutrition(
        calories: 89,
        fat: 0.3,
        sugar: 12.2,
        carbohydrates: 22.8,
        protein: 1.1,
      ),
    );
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FruitInfoCard(fruit: fruit),
        ),
      ),
    );
    expect(find.text('Banana'), findsOneWidget);
    expect(find.textContaining('Musaceae'), findsOneWidget);
    expect(find.textContaining('Calories'), findsOneWidget);
  });
}
