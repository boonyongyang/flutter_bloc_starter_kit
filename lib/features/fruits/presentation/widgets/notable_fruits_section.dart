import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/nutrition_constants.dart';
import '../../models/fruit_model.dart';

/// Widget for displaying notable fruits section
class NotableFruitsSection extends StatelessWidget {
  final Fruit highestCaloriesFruit;
  final Fruit highestProteinFruit;
  final Fruit highestSugarFruit;
  final Fruit lowestCaloriesFruit;

  const NotableFruitsSection({
    super.key,
    required this.highestCaloriesFruit,
    required this.highestProteinFruit,
    required this.highestSugarFruit,
    required this.lowestCaloriesFruit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notable Fruits',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: NotableFruitCard(
                fruit: highestCaloriesFruit,
                title: 'Highest Calories',
                icon: NutritionInfo.nutrients['calories']!.icon,
                color: NutritionInfo.nutrients['calories']!.color,
                value: '${highestCaloriesFruit.nutritions.calories} kcal',
              ),
            ),
            const Gap(12),
            Expanded(
              child: NotableFruitCard(
                fruit: highestProteinFruit,
                title: 'Highest Protein',
                icon: NutritionInfo.nutrients['protein']!.icon,
                color: NutritionInfo.nutrients['protein']!.color,
                value:
                    '${highestProteinFruit.nutritions.protein.toStringAsFixed(1)}g',
              ),
            ),
          ],
        ),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: NotableFruitCard(
                fruit: highestSugarFruit,
                title: 'Sweetest',
                icon: NutritionInfo.nutrients['sugar']!.icon,
                color: NutritionInfo.nutrients['sugar']!.color,
                value:
                    '${highestSugarFruit.nutritions.sugar.toStringAsFixed(1)}g sugar',
              ),
            ),
            const Gap(12),
            Expanded(
              child: NotableFruitCard(
                fruit: lowestCaloriesFruit,
                title: 'Lowest Calories',
                icon: Icons.local_fire_department_outlined,
                color: Colors.green,
                value: '${lowestCaloriesFruit.nutritions.calories} kcal',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Card displaying a notable fruit with its impressive stats
class NotableFruitCard extends StatelessWidget {
  final Fruit fruit;
  final String title;
  final IconData icon;
  final Color color;
  final String value;

  const NotableFruitCard({
    super.key,
    required this.fruit,
    required this.title,
    required this.icon,
    required this.color,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to fruit detail page using go_router
          context.push('/fruits/fruit-detail', extra: fruit);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 16),
                  const Gap(6),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const Gap(8),
              Text(
                fruit.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
