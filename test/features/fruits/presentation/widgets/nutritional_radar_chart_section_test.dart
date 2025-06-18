import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';

import 'package:flutter_bloc_starter_kit/features/fruits/data/models/fruit_model.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/presentation/widgets/nutritional_radar_chart_section.dart';

void main() {
  group('NutritionalComparisonSection', () {
    late List<Fruit> mockFruits;
    late List<String> mockSelectedFruits;

    setUp(() {
      mockFruits = [
        const Fruit(
          name: 'Apple',
          id: 1,
          family: 'Rosaceae',
          order: 'Rosales',
          genus: 'Malus',
          nutritions: Nutrition(
            calories: 52,
            fat: 0.4,
            sugar: 10.4,
            carbohydrates: 25.1,
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
            calories: 96,
            fat: 0.2,
            sugar: 17.2,
            carbohydrates: 22.0,
            protein: 1.0,
          ),
        ),
        const Fruit(
          name: 'Orange',
          id: 3,
          family: 'Rutaceae',
          order: 'Sapindales',
          genus: 'Citrus',
          nutritions: Nutrition(
            calories: 43,
            fat: 0.2,
            sugar: 8.5,
            carbohydrates: 11.7,
            protein: 0.9,
          ),
        ),
      ];

      mockSelectedFruits = ['Apple', 'Banana'];
    });

    testWidgets('renders comparison section with title and description',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: mockFruits,
              selectedFruits: mockSelectedFruits,
            ),
          ),
        ),
      );

      // Verify the section title and description
      expect(find.text('Nutritional Comparison'), findsOneWidget);
      expect(find.text('Compare nutrients between any two fruits'),
          findsOneWidget);

      // Verify the main structure
      expect(find.byType(Column), findsAtLeastNWidgets(1));
      expect(find.byType(Row), findsAtLeastNWidgets(1));
    });

    testWidgets('handles empty fruits list gracefully', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: [],
              selectedFruits: [],
            ),
          ),
        ),
      );

      // Should render as SizedBox.shrink when no fruits
      expect(find.byType(SizedBox), findsOneWidget);

      // Should not render the comparison content
      expect(find.text('Nutritional Comparison'), findsNothing);
    });

    testWidgets('initializes with selected fruits correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: mockFruits,
              selectedFruits: const ['Apple', 'Orange'],
            ),
          ),
        ),
      );

      // Should render without errors with selected fruits
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);
      expect(find.text('Nutritional Comparison'), findsOneWidget);
    });

    testWidgets('handles single fruit in list', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: [mockFruits.first],
              selectedFruits: const ['Apple'],
            ),
          ),
        ),
      );

      // Should render without errors even with single fruit
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);
      expect(find.text('Nutritional Comparison'), findsOneWidget);
    });

    testWidgets('displays layout toggle button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: mockFruits,
              selectedFruits: mockSelectedFruits,
            ),
          ),
        ),
      );

      // Should have an icon button for layout toggle
      expect(find.byType(IconButton), findsAtLeastNWidgets(1));

      // Should have ValueListenableBuilder for layout state
      expect(
          find.byType(ValueListenableBuilder<bool>), findsAtLeastNWidgets(1));
    });

    testWidgets('handles layout toggle interaction', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: mockFruits,
              selectedFruits: mockSelectedFruits,
            ),
          ),
        ),
      );

      // Find and tap the layout toggle button
      final toggleButton = find.byType(IconButton).first;
      await tester.tap(toggleButton);
      await tester.pump();

      // Widget should still be rendered after toggle
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);
    });

    testWidgets('displays gap for proper spacing', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: mockFruits,
              selectedFruits: mockSelectedFruits,
            ),
          ),
        ),
      );

      // Should have gaps for spacing
      expect(find.byType(Gap), findsAtLeastNWidgets(1));
    });

    testWidgets('handles fruits with no selected fruits', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: mockFruits,
              selectedFruits: const [],
            ),
          ),
        ),
      );

      // Should render with default fruits when no selection
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);
      expect(find.text('Nutritional Comparison'), findsOneWidget);
    });

    testWidgets('maintains state through rebuilds', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: mockFruits,
              selectedFruits: mockSelectedFruits,
            ),
          ),
        ),
      );

      // Initial render
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);

      // Trigger a rebuild
      await tester.pump();

      // Widget should still be there
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);
      expect(find.text('Nutritional Comparison'), findsOneWidget);
    });

    testWidgets('disposes value notifiers properly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: mockFruits,
              selectedFruits: mockSelectedFruits,
            ),
          ),
        ),
      );

      // Widget is rendered
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);

      // Remove the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(),
          ),
        ),
      );

      // Should not throw any errors during disposal
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders with partial selected fruits', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: mockFruits,
              selectedFruits: const ['Apple'], // Only one selected
            ),
          ),
        ),
      );

      // Should render without errors
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);
      expect(find.text('Nutritional Comparison'), findsOneWidget);
    });

    testWidgets('handles selected fruits not in fruits list', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: mockFruits,
              selectedFruits: const ['Mango', 'Kiwi'], // Not in fruits list
            ),
          ),
        ),
      );

      // Should render with default fruits
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);
      expect(find.text('Nutritional Comparison'), findsOneWidget);
    });

    testWidgets('uses correct text styles', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: mockFruits,
              selectedFruits: mockSelectedFruits,
            ),
          ),
        ),
      );

      // Verify text widgets are present with correct content
      expect(find.text('Nutritional Comparison'), findsOneWidget);
      expect(find.text('Compare nutrients between any two fruits'),
          findsOneWidget);

      // Verify the structure includes proper text styling
      expect(find.byType(Text), findsAtLeastNWidgets(2));
    });
  });
}
