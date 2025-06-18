import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/presentation/widgets/taxonomy_distribution_section.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/data/models/fruit_model.dart';

void main() {
  testWidgets('TaxonomyDistributionSection displays taxonomy info',
      (WidgetTester tester) async {
    final fruits = [
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
      const Fruit(
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
      ),
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaxonomyDistributionSection(fruits: fruits),
        ),
      ),
    );
    // Test for what's actually displayed in the UI
    expect(find.textContaining('Taxonomy Distribution'), findsOneWidget);
    expect(find.textContaining('families'),
        findsWidgets); // "Most common fruit families"
    expect(
        find.textContaining('Rosaceae'), findsWidgets); // Family name in chip
  });
}
