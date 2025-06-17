import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_bloc_starter_kit/features/fruits/presentation/pages/fruit_detail_page.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/data/models/fruit_model.dart';

void main() {
  group('FruitDetailPage', () {
    late Fruit testFruit;

    setUp(() {
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

    testWidgets('displays fruit details correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FruitDetailPage(fruit: testFruit),
        ),
      );

      await tester.pump();

      // Should display fruit name
      expect(find.text('Apple'), findsWidgets);
      
      // Should display nutritional information
      expect(find.text('95'), findsOneWidget); // calories
      expect(find.text('0.5g'), findsOneWidget); // protein
    });

    testWidgets('has scrollable content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FruitDetailPage(fruit: testFruit),
        ),
      );

      await tester.pump();

      // Should have scrollable content
      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('displays nutrition chips', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FruitDetailPage(fruit: testFruit),
        ),
      );

      await tester.pump();

      // Should have nutrition information displayed
      expect(find.textContaining('Calories'), findsWidgets);
    });

    testWidgets('has app bar', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FruitDetailPage(fruit: testFruit),
        ),
      );

      await tester.pump();

      // Should have app bar
      expect(find.byType(SliverAppBar), findsOneWidget);
    });
  });
}
