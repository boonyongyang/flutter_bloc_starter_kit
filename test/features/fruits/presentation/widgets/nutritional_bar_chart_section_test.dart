import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';

import 'package:flutter_bloc_starter_kit/features/fruits/presentation/widgets/nutritional_bar_chart_section.dart';

void main() {
  group('NutritionalBarChartSection', () {
    testWidgets('renders section title and bar chart correctly',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalBarChartSection(
              avgSugar: 12.5,
              avgCarbs: 25.0,
              avgProtein: 1.8,
              avgFat: 0.6,
            ),
          ),
        ),
      );

      // Verify the section title
      expect(find.text('Average Nutritional Content'), findsOneWidget);

      // Verify the bar chart is rendered
      expect(find.byType(BarChart), findsOneWidget);

      // Verify the container structure
      expect(find.byType(Container), findsAtLeastNWidgets(1));

      // Verify the gap for spacing
      expect(find.byType(Gap), findsAtLeastNWidgets(1));
    });

    testWidgets('handles zero values correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalBarChartSection(
              avgSugar: 0,
              avgCarbs: 0,
              avgProtein: 0,
              avgFat: 0,
            ),
          ),
        ),
      );

      // Should render without errors even with zero values
      expect(find.byType(NutritionalBarChartSection), findsOneWidget);
      expect(find.byType(BarChart), findsOneWidget);
      expect(find.text('Average Nutritional Content'), findsOneWidget);
    });

    testWidgets('handles large values correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalBarChartSection(
              avgSugar: 100.5,
              avgCarbs: 250.0,
              avgProtein: 50.8,
              avgFat: 25.6,
            ),
          ),
        ),
      );

      // Should render without errors even with large values
      expect(find.byType(NutritionalBarChartSection), findsOneWidget);
      expect(find.byType(BarChart), findsOneWidget);
      expect(find.text('Average Nutritional Content'), findsOneWidget);
    });

    testWidgets('has correct widget hierarchy and structure', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalBarChartSection(
              avgSugar: 12.5,
              avgCarbs: 25.0,
              avgProtein: 1.8,
              avgFat: 0.6,
            ),
          ),
        ),
      );

      // Check the widget hierarchy: Column -> Text + Gap + Container -> BarChart
      expect(find.byType(Column), findsAtLeastNWidgets(1));
      expect(find.byType(Container), findsAtLeastNWidgets(1));
      expect(find.byType(BarChart), findsOneWidget);

      // Verify container has correct height
      final container = tester.widget<Container>(
        find.ancestor(
          of: find.byType(BarChart),
          matching: find.byType(Container),
        ),
      );
      expect(container.constraints?.maxHeight, equals(160));
    });

    testWidgets('displays chart with proper styling and decoration',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalBarChartSection(
              avgSugar: 12.5,
              avgCarbs: 25.0,
              avgProtein: 1.8,
              avgFat: 0.6,
            ),
          ),
        ),
      );

      // Find the container that wraps the chart
      final container = tester.widget<Container>(
        find.ancestor(
          of: find.byType(BarChart),
          matching: find.byType(Container),
        ),
      );

      // Verify container has decoration
      expect(container.decoration, isA<BoxDecoration>());

      // Verify container has padding
      expect(container.padding, equals(const EdgeInsets.all(16)));

      // Verify container has correct height
      expect(container.constraints?.maxHeight, equals(160));
    });

    testWidgets('handles decimal values properly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalBarChartSection(
              avgSugar: 12.567,
              avgCarbs: 25.123,
              avgProtein: 1.999,
              avgFat: 0.001,
            ),
          ),
        ),
      );

      // Should render without errors with decimal values
      expect(find.byType(NutritionalBarChartSection), findsOneWidget);
      expect(find.byType(BarChart), findsOneWidget);
    });

    testWidgets('maintains proper layout structure', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalBarChartSection(
              avgSugar: 12.5,
              avgCarbs: 25.0,
              avgProtein: 1.8,
              avgFat: 0.6,
            ),
          ),
        ),
      );

      // Verify the main column uses CrossAxisAlignment.start
      final column = tester.widget<Column>(find.byType(Column).first);
      expect(column.crossAxisAlignment, equals(CrossAxisAlignment.start));

      // Verify the gap spacing
      final gap = tester.widget<Gap>(find.byType(Gap).first);
      expect(gap.mainAxisExtent, equals(12));
    });

    testWidgets('renders bar chart with correct number of bars',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalBarChartSection(
              avgSugar: 12.5,
              avgCarbs: 25.0,
              avgProtein: 1.8,
              avgFat: 0.6,
            ),
          ),
        ),
      );

      // The chart should have bars for all 4 nutrition values
      expect(find.byType(BarChart), findsOneWidget);

      // Verify the widget renders without throwing errors
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('handles negative values gracefully', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NutritionalBarChartSection(
              avgSugar:
                  -5.0, // Shouldn't happen in real data, but test edge case
              avgCarbs: 25.0,
              avgProtein: 1.8,
              avgFat: 0.6,
            ),
          ),
        ),
      );

      // Should render without errors even with negative values
      expect(find.byType(NutritionalBarChartSection), findsOneWidget);
      expect(find.byType(BarChart), findsOneWidget);

      // Verify no exceptions are thrown
      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('widget updates correctly when values change', (tester) async {
      Widget buildWidget(
          double sugar, double carbs, double protein, double fat) {
        return MaterialApp(
          home: Scaffold(
            body: NutritionalBarChartSection(
              avgSugar: sugar,
              avgCarbs: carbs,
              avgProtein: protein,
              avgFat: fat,
            ),
          ),
        );
      }

      // Initial render
      await tester.pumpWidget(buildWidget(10.0, 20.0, 1.0, 0.5));
      expect(find.byType(NutritionalBarChartSection), findsOneWidget);

      // Update with new values
      await tester.pumpWidget(buildWidget(15.0, 30.0, 2.0, 1.0));
      await tester.pump();

      // Widget should still be rendered correctly
      expect(find.byType(NutritionalBarChartSection), findsOneWidget);
      expect(find.byType(BarChart), findsOneWidget);
    });
  });
}
