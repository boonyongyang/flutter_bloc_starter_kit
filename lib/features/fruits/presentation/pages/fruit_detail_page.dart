import 'package:flutter/material.dart';

import '../../../taxonomy/presentation/widgets/taxonomy_fact_card.dart';
import '../../models/fruit_model.dart';
import '../widgets/fruit_info_card.dart';
import '../widgets/nutrition_chips.dart';
import '../widgets/radar_chart_widget.dart';

class FruitDetailPage extends StatelessWidget {
  final Fruit fruit;

  const FruitDetailPage({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    final nutrition = fruit.nutritions;
    final macroLabels = ['Carbs', 'Protein', 'Fat'];
    final macroValues = [
      nutrition.carbohydrates,
      nutrition.protein,
      nutrition.fat
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsible app bar
          SliverAppBar(
            expandedHeight: 65,
            floating: true,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(fruit.name),
              // background: Icon(Icons.local_florist, size: 80),
            ),
          ),

          // Content area
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Fruit info card
                  FruitInfoCard(fruit: fruit),

                  const SizedBox(height: 28),
                  const SizedBox(height: 28),

                  // Radar chart for main macros
                  MacroNutrientRadarChart(
                    macroValues: macroValues,
                    macroLabels: macroLabels,
                  ),

                  const SizedBox(height: 28),

                  // Nutrition breakdown chips
                  NutritionChips(nutrition: nutrition),

                  const SizedBox(height: 28),

                  // Taxonomy facts card
                  TaxonomyFactCard(fruit: fruit),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
