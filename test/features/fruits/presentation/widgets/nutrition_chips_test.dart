import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/presentation/widgets/nutrition_chips.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/data/models/fruit_model.dart';

void main() {
  testWidgets('NutritionChips displays nutrition values',
      (WidgetTester tester) async {
    const nutrition = Nutrition(
      calories: 100,
      fat: 1.0,
      sugar: 20.0,
      carbohydrates: 25.0,
      protein: 2.0,
    );
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NutritionChips(nutrition: nutrition),
        ),
      ),
    );
    expect(find.textContaining('100'), findsOneWidget);
    expect(find.textContaining('1.0'), findsOneWidget);
    expect(find.textContaining('20.0'), findsOneWidget);
    expect(find.textContaining('25.0'), findsOneWidget);
    expect(find.textContaining('2.0'), findsOneWidget);
  });
}
