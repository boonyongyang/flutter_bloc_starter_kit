import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_bloc_starter_kit/features/fruits/presentation/widgets/nutritional_overview_section.dart';

void main() {
  group('NutritionalOverviewSection', () {
    testWidgets('displays nutritional overview correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalOverviewSection(
              avgCalories: 85.5,
              avgProtein: 1.2,
              avgSugar: 12.5,
              avgCarbs: 18.7,
              fruitCount: 25,
            ),
          ),
        ),
      );

      await tester.pump();

      // Should display title
      expect(find.text('Nutritional Overview'), findsOneWidget);

      // Should display average values
      expect(find.text('86'), findsOneWidget); // avgCalories rounded
      expect(find.text('1.2g'), findsOneWidget); // avgProtein
      expect(find.text('12.5g'), findsOneWidget); // avgSugar  
      expect(find.text('18.7g'), findsOneWidget); // avgCarbs

      // Should display fruit count
      expect(find.text('25 fruits'), findsOneWidget);
    });

    testWidgets('displays correct card titles', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalOverviewSection(
              avgCalories: 85.5,
              avgProtein: 1.2,
              avgSugar: 12.5,
              avgCarbs: 18.7,
              fruitCount: 25,
            ),
          ),
        ),
      );

      await tester.pump();

      // Should display card titles
      expect(find.text('Avg. Calories'), findsOneWidget);
      expect(find.text('Avg. Protein'), findsOneWidget);
      expect(find.text('Avg. Sugar'), findsOneWidget);
      expect(find.text('Avg. Carbs'), findsOneWidget);
    });

    testWidgets('has horizontal scrollable list', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalOverviewSection(
              avgCalories: 85.5,
              avgProtein: 1.2,
              avgSugar: 12.5,
              avgCarbs: 18.7,
              fruitCount: 25,
            ),
          ),
        ),
      );

      await tester.pump();

      // Should have horizontal ListView
      final listView = find.byType(ListView);
      expect(listView, findsOneWidget);
      
      final listViewWidget = tester.widget<ListView>(listView);
      expect(listViewWidget.scrollDirection, equals(Axis.horizontal));
    });

    testWidgets('displays nutrition icons', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalOverviewSection(
              avgCalories: 85.5,
              avgProtein: 1.2,
              avgSugar: 12.5,
              avgCarbs: 18.7,
              fruitCount: 25,
            ),
          ),
        ),
      );

      await tester.pump();

      // Should have icons for each nutrition type
      expect(find.byType(Icon), findsNWidgets(4));
    });

    testWidgets('handles zero values correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalOverviewSection(
              avgCalories: 0,
              avgProtein: 0,
              avgSugar: 0,
              avgCarbs: 0,
              fruitCount: 0,
            ),
          ),
        ),
      );

      await tester.pump();

      // Should display zero values
      expect(find.text('0'), findsOneWidget); // avgCalories
      expect(find.text('0.0g'), findsNWidgets(3)); // protein, sugar, carbs
      expect(find.text('0 fruits'), findsOneWidget);
    });
  });
}
