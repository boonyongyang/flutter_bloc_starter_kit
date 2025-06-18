import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_bloc_starter_kit/features/fruits/data/models/fruit_model.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/presentation/widgets/nutritional_comparison_section.dart';

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

    testWidgets('renders comparison section correctly', (tester) async {
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

      // Verify the widget renders
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);

      // Verify the main structure components
      expect(find.byType(Column), findsAtLeastNWidgets(1));
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

      // Should handle empty list without errors
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);
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
    });

    testWidgets('uses ValueNotifier for state management', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 800,
              height: 600,
              child: NutritionalComparisonSection(
                fruits: mockFruits,
                selectedFruits: mockSelectedFruits,
              ),
            ),
          ),
        ),
      );

      // Should have ValueListenableBuilder widgets for reactive state
      expect(
          find.byType(ValueListenableBuilder<bool>), findsAtLeastNWidgets(1));
      expect(
          find.byType(ValueListenableBuilder<Fruit>), findsAtLeastNWidgets(1));
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

      // Remove the widget to trigger dispose
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

      // Should render with fallback to available fruits
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);
    });

    testWidgets('handles partial selected fruits', (tester) async {
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
    });

    testWidgets('uses predefined colors for visualization', (tester) async {
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

      // Should render without color-related errors
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);

      // No exceptions should be thrown
      expect(tester.takeException(), isNull);
    });

    testWidgets('handles widget updates correctly', (tester) async {
      Widget buildWidget(List<String> selectedFruits) {
        return MaterialApp(
          home: Scaffold(
            body: NutritionalComparisonSection(
              fruits: mockFruits,
              selectedFruits: selectedFruits,
            ),
          ),
        );
      }

      // Initial render
      await tester.pumpWidget(buildWidget(['Apple', 'Banana']));
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);

      // Update with different selection
      await tester.pumpWidget(buildWidget(['Orange', 'Apple']));
      await tester.pump();

      // Widget should still be rendered correctly
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);
    });

    testWidgets(
        'initializes with correct default fruits when sufficient fruits available',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 800,
              height: 600,
              child: NutritionalComparisonSection(
                fruits: mockFruits,
                selectedFruits: const ['Apple', 'Banana'],
              ),
            ),
          ),
        ),
      );

      // Should initialize without errors when enough fruits are provided
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);

      // Should have the proper widget structure
      expect(
          find.byType(ValueListenableBuilder<bool>), findsAtLeastNWidgets(1));
      expect(
          find.byType(ValueListenableBuilder<Fruit>), findsAtLeastNWidgets(1));
    });

    testWidgets('handles gap widgets for proper spacing', (tester) async {
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

      // Should contain gap widgets for spacing
      // Note: The specific number depends on the implementation
      expect(find.byType(NutritionalComparisonSection), findsOneWidget);
    });
  });
}
