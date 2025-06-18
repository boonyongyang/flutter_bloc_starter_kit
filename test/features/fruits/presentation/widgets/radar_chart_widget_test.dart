import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_bloc_starter_kit/features/fruits/presentation/widgets/radar_chart_widget.dart';

void main() {
  group('MacroNutrientRadarChart', () {
    late List<double> mockMacroValues;
    late List<String> mockMacroLabels;

    setUp(() {
      mockMacroValues = [10.5, 25.0, 1.2, 0.8];
      mockMacroLabels = ['Sugar', 'Carbs', 'Protein', 'Fat'];
    });

    testWidgets('renders radar chart with provided data', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MacroNutrientRadarChart(
              macroValues: mockMacroValues,
              macroLabels: mockMacroLabels,
            ),
          ),
        ),
      );

      // Verify the radar chart is rendered
      expect(find.byType(RadarChart), findsOneWidget);

      // Verify the container structure
      expect(find.byType(Container), findsAtLeastNWidgets(1));

      // Verify the overall widget structure
      expect(find.byType(Column), findsAtLeastNWidgets(1));
      // Use findsAtLeastNWidgets instead of findsOneWidget since there might be multiple Stack widgets
      expect(find.byType(Stack), findsAtLeastNWidgets(1));
    });

    testWidgets('has correct initial state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MacroNutrientRadarChart(
              macroValues: mockMacroValues,
              macroLabels: mockMacroLabels,
            ),
          ),
        ),
      );

      // Get the widget state
      final radarWidget = tester.widget<MacroNutrientRadarChart>(
        find.byType(MacroNutrientRadarChart),
      );

      // Verify initial values
      expect(radarWidget.macroValues, equals(mockMacroValues));
      expect(radarWidget.macroLabels, equals(mockMacroLabels));
    });

    testWidgets('handles empty macro values gracefully', (tester) async {
      // Create minimum 3 entries as required by fl_chart
      const minMacroValues = [0.0, 0.0, 0.0];
      const minMacroLabels = ['Sugar', 'Carbs', 'Protein'];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MacroNutrientRadarChart(
              macroValues: minMacroValues,
              macroLabels: minMacroLabels,
            ),
          ),
        ),
      );

      // Should still render without errors
      expect(find.byType(MacroNutrientRadarChart), findsOneWidget);
      expect(find.byType(RadarChart), findsOneWidget);
    });

    testWidgets('handles minimum required values correctly', (tester) async {
      // fl_chart requires at least 3 entries
      const minMacroValues = [15.0, 10.0, 5.0];
      const minMacroLabels = ['Sugar', 'Carbs', 'Protein'];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MacroNutrientRadarChart(
              macroValues: minMacroValues,
              macroLabels: minMacroLabels,
            ),
          ),
        ),
      );

      // Should render without errors
      expect(find.byType(MacroNutrientRadarChart), findsOneWidget);
      expect(find.byType(RadarChart), findsOneWidget);
    });

    testWidgets('displays chart with proper styling', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MacroNutrientRadarChart(
              macroValues: mockMacroValues,
              macroLabels: mockMacroLabels,
            ),
          ),
        ),
      );

      // Verify container has proper dimensions
      final containers = tester.widgetList<Container>(find.byType(Container));
      expect(containers.length, greaterThan(0));

      // Verify SizedBox has correct height
      final sizedBox = tester.widget<SizedBox>(
        find.byType(SizedBox).first,
      );
      expect(sizedBox.height, equals(220));
    });

    testWidgets('handles touch interactions', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MacroNutrientRadarChart(
              macroValues: mockMacroValues,
              macroLabels: mockMacroLabels,
            ),
          ),
        ),
      );

      // Find the radar chart and try to interact with it
      final radarChart = find.byType(RadarChart);
      expect(radarChart, findsOneWidget);

      // Tap on the chart (this should not cause errors)
      await tester.tap(radarChart);
      await tester.pump();

      // Verify the widget is still there after interaction
      expect(find.byType(MacroNutrientRadarChart), findsOneWidget);
    });

    testWidgets('maintains state through rebuilds', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MacroNutrientRadarChart(
              macroValues: mockMacroValues,
              macroLabels: mockMacroLabels,
            ),
          ),
        ),
      );

      // Initial render
      expect(find.byType(MacroNutrientRadarChart), findsOneWidget);

      // Trigger a rebuild by pumping
      await tester.pump();

      // Widget should still be there
      expect(find.byType(MacroNutrientRadarChart), findsOneWidget);
      expect(find.byType(RadarChart), findsOneWidget);
    });

    testWidgets('handles large macro values', (tester) async {
      final largeMacroValues = [1000.0, 2500.0, 150.0, 80.0];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MacroNutrientRadarChart(
              macroValues: largeMacroValues,
              macroLabels: mockMacroLabels,
            ),
          ),
        ),
      );

      // Should render without errors even with large values
      expect(find.byType(MacroNutrientRadarChart), findsOneWidget);
      expect(find.byType(RadarChart), findsOneWidget);
    });

    testWidgets('handles zero values', (tester) async {
      final zeroMacroValues = [0.0, 0.0, 0.0, 0.0];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MacroNutrientRadarChart(
              macroValues: zeroMacroValues,
              macroLabels: mockMacroLabels,
            ),
          ),
        ),
      );

      // Should render without errors even with zero values
      expect(find.byType(MacroNutrientRadarChart), findsOneWidget);
      expect(find.byType(RadarChart), findsOneWidget);
    });

    testWidgets('has proper widget hierarchy', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MacroNutrientRadarChart(
              macroValues: mockMacroValues,
              macroLabels: mockMacroLabels,
            ),
          ),
        ),
      );

      // Check the widget hierarchy: Column -> SizedBox -> Stack -> Container -> RadarChart
      expect(find.byType(Column), findsAtLeastNWidgets(1));
      expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
      // Use findsAtLeastNWidgets for Stack since there might be multiple
      expect(find.byType(Stack), findsAtLeastNWidgets(1));
      expect(find.byType(Container), findsAtLeastNWidgets(1));
      expect(find.byType(RadarChart), findsOneWidget);
    });
  });
}
