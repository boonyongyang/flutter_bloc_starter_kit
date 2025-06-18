import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_bloc_starter_kit/features/fruits/presentation/pages/fruit_detail_page.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/presentation/widgets/nutrition_chips.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/presentation/widgets/fruit_info_card.dart';
import 'package:flutter_bloc_starter_kit/features/fruits/data/models/fruit_model.dart';
import 'package:flutter_bloc_starter_kit/features/taxonomy/data/repositories/i_taxonomy_repository.dart';
import 'package:flutter_bloc_starter_kit/features/taxonomy/data/models/taxonomy_fact_model.dart';

class MockTaxonomyRepository extends Mock implements ITaxonomyRepository {}

void main() {
  group('FruitDetailPage', () {
    late Fruit testFruit;
    late MockTaxonomyRepository mockTaxonomyRepository;
    final locator = GetIt.instance;

    setUp(() {
      // Reset GetIt and register mock dependencies for tests
      if (locator.isRegistered<ITaxonomyRepository>()) {
        locator.unregister<ITaxonomyRepository>();
      }

      mockTaxonomyRepository = MockTaxonomyRepository();
      locator.registerLazySingleton<ITaxonomyRepository>(
          () => mockTaxonomyRepository);

      // Setup mock responses
      when(() => mockTaxonomyRepository.getFamilyFact(any())).thenAnswer(
        (_) async => TaxonomyFact(
          description: 'Apple Family Test Description',
          funFacts: ['Test fun fact 1', 'Test fun fact 2'],
        ),
      );
      when(() => mockTaxonomyRepository.getGenusFact(any())).thenAnswer(
        (_) async => TaxonomyFact(
          description: 'Apple Genus Test Description',
          funFacts: ['Test fun fact 1', 'Test fun fact 2'],
        ),
      );
      when(() => mockTaxonomyRepository.getOrderFact(any())).thenAnswer(
        (_) async => TaxonomyFact(
          description: 'Apple Order Test Description',
          funFacts: ['Test fun fact 1', 'Test fun fact 2'],
        ),
      );
      when(() => mockTaxonomyRepository.hasTaxonomyName(any(), any()))
          .thenAnswer(
        (_) async => true,
      );
      when(() => mockTaxonomyRepository.getAllTaxonomyFacts()).thenAnswer(
        (_) async => null,
      );

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

    tearDown(() {
      // Clean up GetIt after each test
      if (locator.isRegistered<ITaxonomyRepository>()) {
        locator.unregister<ITaxonomyRepository>();
      }
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
      // Debug: Check if the page renders at all
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(CustomScrollView), findsOneWidget);

      // Check if fruit info card is rendered (this comes before NutritionChips)
      expect(find.byType(FruitInfoCard), findsOneWidget);

      // Now check for NutritionChips
      expect(find.byType(NutritionChips), findsOneWidget);
      // Then check for chip widgets
      expect(find.byType(Chip), findsWidgets);
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
