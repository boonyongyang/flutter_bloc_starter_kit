import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_bloc_starter_kit/features/fruits/data/models/fruit_model.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/presentation/widgets/notable_fruits_section.dart';

class MockGoRouter extends Mock implements GoRouter {}

class MockGoRouterDelegate extends Mock implements GoRouterDelegate {}

class MockRouteInformation extends Mock implements RouteInformation {}

class MockGoRouterState extends Mock implements GoRouterState {}

void main() {
  group('NotableFruitsSection', () {
    late Fruit mockFruit1;
    late Fruit mockFruit2;
    late Fruit mockFruit3;
    late Fruit mockFruit4;

    setUp(() {
      mockFruit1 = const Fruit(
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
      );

      mockFruit2 = const Fruit(
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
      );

      mockFruit3 = const Fruit(
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
      );

      mockFruit4 = const Fruit(
        name: 'Grape',
        id: 4,
        family: 'Vitaceae',
        order: 'Vitales',
        genus: 'Vitis',
        nutritions: Nutrition(
          calories: 67,
          fat: 0.4,
          sugar: 16.0,
          carbohydrates: 17.0,
          protein: 0.6,
        ),
      );
    });

    testWidgets('renders all notable fruit cards correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => NotableFruitsSection(
                  highestCaloriesFruit: mockFruit2,
                  highestProteinFruit: mockFruit2,
                  highestSugarFruit: mockFruit2,
                  lowestCaloriesFruit: mockFruit3,
                ),
              ),
              GoRoute(
                path: '/fruits/fruit-detail',
                builder: (context, state) => const Scaffold(
                  body: Text('Fruit Detail Page'),
                ),
              ),
            ],
          ),
        ),
      );

      // Verify the section title
      expect(find.text('Notable Fruits'), findsOneWidget);

      // Verify all four notable fruit cards are present
      expect(find.text('Highest Calories'), findsOneWidget);
      expect(find.text('Highest Protein'), findsOneWidget);
      expect(find.text('Sweetest'), findsOneWidget);
      expect(find.text('Lowest Calories'), findsOneWidget);

      // Verify fruit names are displayed
      expect(find.text('Banana'), findsNWidgets(3)); // appears 3 times
      expect(find.text('Orange'), findsOneWidget);

      // Verify nutrition values are displayed correctly
      expect(find.text('96 kcal'), findsNWidgets(2)); // highest and one other
      expect(find.text('1.0g'), findsOneWidget); // protein
      expect(find.text('17.2g sugar'), findsOneWidget);
      expect(find.text('43 kcal'), findsOneWidget); // lowest calories
    });

    testWidgets('displays correct icons and colors for each card', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => NotableFruitsSection(
                  highestCaloriesFruit: mockFruit2,
                  highestProteinFruit: mockFruit2,
                  highestSugarFruit: mockFruit2,
                  lowestCaloriesFruit: mockFruit3,
                ),
              ),
              GoRoute(
                path: '/fruits/fruit-detail',
                builder: (context, state) => const Scaffold(
                  body: Text('Fruit Detail Page'),
                ),
              ),
            ],
          ),
        ),
      );

      // Verify icons are present
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);
      expect(find.byIcon(Icons.fitness_center), findsOneWidget);
      expect(find.byIcon(Icons.cake), findsOneWidget);
      expect(find.byIcon(Icons.local_fire_department_outlined), findsOneWidget);

      // Verify cards are tappable
      expect(find.byType(InkWell), findsNWidgets(4));
    });

    testWidgets('navigates to fruit detail page when card is tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => NotableFruitsSection(
                  highestCaloriesFruit: mockFruit2,
                  highestProteinFruit: mockFruit2,
                  highestSugarFruit: mockFruit2,
                  lowestCaloriesFruit: mockFruit3,
                ),
              ),
              GoRoute(
                path: '/fruits/fruit-detail',
                builder: (context, state) => const Scaffold(
                  body: Text('Fruit Detail Page'),
                ),
              ),
            ],
          ),
        ),
      );

      // Tap on the first card (highest calories)
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.text('Fruit Detail Page'), findsOneWidget);
    });

    testWidgets('handles layout correctly with proper spacing', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => NotableFruitsSection(
                  highestCaloriesFruit: mockFruit1,
                  highestProteinFruit: mockFruit2,
                  highestSugarFruit: mockFruit3,
                  lowestCaloriesFruit: mockFruit4,
                ),
              ),
              GoRoute(
                path: '/fruits/fruit-detail',
                builder: (context, state) => const Scaffold(
                  body: Text('Fruit Detail Page'),
                ),
              ),
            ],
          ),
        ),
      );

      // Verify layout structure
      expect(find.byType(Column), findsNWidgets(5)); // main column + 4 card columns
      expect(find.byType(Row), findsNWidgets(6)); // 2 card rows + 4 icon rows
      expect(find.byType(Gap), findsNWidgets(10)); // various gaps for spacing
    });
  });

  group('NotableFruitCard', () {
    late Fruit mockFruit;

    setUp(() {
      mockFruit = const Fruit(
        name: 'Test Fruit',
        id: 1,
        family: 'Test Family',
        order: 'Test Order',
        genus: 'Test Genus',
        nutritions: Nutrition(
          calories: 50,
          fat: 0.3,
          sugar: 12.0,
          carbohydrates: 20.0,
          protein: 1.5,
        ),
      );
    });

    testWidgets('renders card with all required information', (tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => NotableFruitCard(
                  fruit: mockFruit,
                  title: 'Test Title',
                  icon: Icons.star,
                  color: Colors.blue,
                  value: '50 kcal',
                ),
              ),
              GoRoute(
                path: '/fruits/fruit-detail',
                builder: (context, state) => const Scaffold(
                  body: Text('Fruit Detail Page'),
                ),
              ),
            ],
          ),
        ),
      );

      // Verify all text elements are present
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Fruit'), findsOneWidget);
      expect(find.text('50 kcal'), findsOneWidget);

      // Verify icon is present
      expect(find.byIcon(Icons.star), findsOneWidget);

      // Verify card structure
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('handles long fruit names with ellipsis', (tester) async {
      const longNameFruit = Fruit(
        name: 'Very Long Fruit Name That Should Be Truncated',
        id: 1,
        family: 'Test Family',
        order: 'Test Order',
        genus: 'Test Genus',
        nutritions: Nutrition(
          calories: 50,
          fat: 0.3,
          sugar: 12.0,
          carbohydrates: 20.0,
          protein: 1.5,
        ),
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const SizedBox(
                  width: 150, // Constrain width to force ellipsis
                  child: NotableFruitCard(
                    fruit: longNameFruit,
                    title: 'Test Title',
                    icon: Icons.star,
                    color: Colors.blue,
                    value: '50 kcal',
                  ),
                ),
              ),
              GoRoute(
                path: '/fruits/fruit-detail',
                builder: (context, state) => const Scaffold(
                  body: Text('Fruit Detail Page'),
                ),
              ),
            ],
          ),
        ),
      );

      // Verify the text widget has ellipsis overflow
      final textWidget = tester.widget<Text>(
        find.text('Very Long Fruit Name That Should Be Truncated'),
      );
      expect(textWidget.overflow, TextOverflow.ellipsis);
      expect(textWidget.maxLines, 1);
    });
  });
}
