import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/nutrition_constants.dart';
import '../../../../core/style/app_text_styles.dart';

/// Widget for displaying nutritional overview cards in a horizontal list
class NutritionalOverviewSection extends StatelessWidget {
  final num avgCalories;
  final num avgProtein;
  final num avgSugar;
  final num avgCarbs;
  final int fruitCount;

  const NutritionalOverviewSection({
    super.key,
    required this.avgCalories,
    required this.avgProtein,
    required this.avgSugar,
    required this.avgCarbs,
    required this.fruitCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutritional Overview',
          style: AppTextStyles.w700p18,
        ),
        const Gap(12),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _NutritionSummaryCard(
                title: 'Avg. Calories',
                value: avgCalories.toStringAsFixed(0),
                icon: NutritionConstants.nutrients['calories']!.icon,
                color: NutritionConstants.nutrients['calories']!.color,
                subtitle: '$fruitCount fruits',
              ),
              _NutritionSummaryCard(
                title: 'Avg. Protein',
                value: '${avgProtein.toStringAsFixed(1)}g',
                icon: NutritionConstants.nutrients['protein']!.icon,
                color: NutritionConstants.nutrients['protein']!.color,
                subtitle: 'per fruit',
              ),
              _NutritionSummaryCard(
                title: 'Avg. Sugar',
                value: '${avgSugar.toStringAsFixed(1)}g',
                icon: NutritionConstants.nutrients['sugar']!.icon,
                color: NutritionConstants.nutrients['sugar']!.color,
                subtitle: 'per fruit',
              ),
              _NutritionSummaryCard(
                title: 'Avg. Carbs',
                value: '${avgCarbs.toStringAsFixed(1)}g',
                icon: NutritionConstants.nutrients['carbohydrates']!.icon,
                color: NutritionConstants.nutrients['carbohydrates']!.color,
                subtitle: 'per fruit',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Card for displaying a summary of a particular nutritional value
class _NutritionSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String subtitle;

  const _NutritionSummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(right: 12, bottom: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.3), width: 1),
      ),
      child: Container(
        width: 130,
        constraints: const BoxConstraints(minWidth: 100),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 16),
                const Gap(6),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.w600p12,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: AppTextStyles.w700p20.copyWith(
                color: color,
              ),
            ),
            const Gap(2),
            Text(
              subtitle,
              style: AppTextStyles.w400p12.copyWith(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
