import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../taxonomy/presentation/widgets/taxonomy_fact_card.dart';
import '../../data/models/fruit_model.dart';
import '../widgets/fruit_info_card.dart';
import '../widgets/nutrition_chips.dart';

class FruitDetailPage extends StatelessWidget {
  final Fruit fruit;

  const FruitDetailPage({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    final nutrition = fruit.nutritions;

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

                  const Gap(28),

                  // Nutrition breakdown chips
                  NutritionChips(nutrition: nutrition),

                  const Gap(28),

                  // Taxonomy facts card
                  TaxonomyFactCard(fruit: fruit),

                  const Gap(72),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
