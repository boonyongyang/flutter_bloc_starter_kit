import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/nutrition_constants.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../data/models/fruit_model.dart';

class FruitListTile extends StatelessWidget {
  final Fruit fruit;
  const FruitListTile({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    final nutrition = fruit.nutritions;
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          context.push('/fruits/fruit-detail', extra: fruit);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leading icon for fruit
              CircleAvatar(
                radius: 24,
                backgroundColor: theme.colorScheme.tertiary.withOpacity(0.12),
                child: Text(
                  fruit.name.isNotEmpty ? fruit.name[0].toUpperCase() : '',
                  style: AppTextStyles.w700p20.copyWith(
                    color: theme.colorScheme.tertiary,
                  ),
                ),
              ),
              const Gap(14),
              // Main info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row 1: Fruit name and trailing family/genus/order
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            fruit.name,
                            style: AppTextStyles.w700p16,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap(8),
                        // Show one or two of family/genus/order as trailing info
                        if (fruit.family.isNotEmpty)
                          Row(
                            children: [
                              Icon(Icons.family_restroom,
                                  size: 16, color: theme.colorScheme.tertiary),
                              const Gap(2),
                              Text(fruit.family, style: AppTextStyles.w500p12),
                            ],
                          )
                        else if ((fruit.genus).isNotEmpty)
                          Row(
                            children: [
                              Icon(Icons.eco,
                                  size: 16, color: theme.colorScheme.secondary),
                              const Gap(2),
                              Text(fruit.genus, style: AppTextStyles.w500p12),
                            ],
                          )
                        else if ((fruit.order).isNotEmpty)
                          Row(
                            children: [
                              Icon(Icons.account_tree,
                                  size: 16, color: theme.colorScheme.primary),
                              const Gap(2),
                              Text(fruit.order, style: AppTextStyles.w500p12),
                            ],
                          ),
                        const Gap(6),
                        Icon(Icons.arrow_forward_ios,
                            size: 14, color: theme.colorScheme.outline),
                      ],
                    ),
                    const Gap(2),
                    // Row 2: Show the other two (if available)
                    Row(
                      children: [
                        if (fruit.genus.isNotEmpty)
                          Row(
                            children: [
                              Icon(Icons.eco,
                                  size: 16, color: theme.colorScheme.secondary),
                              const Gap(2),
                              Text(fruit.genus, style: AppTextStyles.w500p12),
                            ],
                          ),
                        if (fruit.order.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              children: [
                                Icon(Icons.account_tree,
                                    size: 16, color: theme.colorScheme.primary),
                                const Gap(2),
                                Text(fruit.order, style: AppTextStyles.w500p12),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const Gap(6),
                    // Row 3: Nutrition summary (split into two rows, calories at end)
                    Row(
                      children: [
                        _NutValue(
                          icon: NutritionConstants.nutrients['sugar']!.icon,
                          color: NutritionConstants.nutrients['sugar']!.color,
                          value: nutrition.sugar.toStringAsFixed(1),
                          label: 'sugar',
                        ),
                        _NutValue(
                          icon: NutritionConstants
                              .nutrients['carbohydrates']!.icon,
                          color: NutritionConstants
                              .nutrients['carbohydrates']!.color,
                          value: nutrition.carbohydrates.toStringAsFixed(1),
                          label: 'carbs',
                        ),
                        const Spacer(),
                        _NutValue(
                          icon: NutritionConstants.nutrients['calories']!.icon,
                          color:
                              NutritionConstants.nutrients['calories']!.color,
                          value: nutrition.calories.toString(),
                          label: 'kcal',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _NutValue(
                          icon: NutritionConstants.nutrients['protein']!.icon,
                          color: NutritionConstants.nutrients['protein']!.color,
                          value: nutrition.protein.toStringAsFixed(1),
                          label: 'protein',
                        ),
                        _NutValue(
                          icon: NutritionConstants.nutrients['fat']!.icon,
                          color: NutritionConstants.nutrients['fat']!.color,
                          value: nutrition.fat.toStringAsFixed(1),
                          label: 'fat',
                        ),
                        const Spacer(),
                        const Gap(48),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A compact, inline display for nutrient values
class _NutValue extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _NutValue({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const Gap(2),
          Text(
            value,
            style: AppTextStyles.w600p14.copyWith(
              color: color,
            ),
          ),
          Text(
            ' $label',
            style: AppTextStyles.w400p12.copyWith(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          ),
        ],
      ),
    );
  }
}
