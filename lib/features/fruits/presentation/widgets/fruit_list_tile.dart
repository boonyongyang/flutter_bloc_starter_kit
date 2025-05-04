import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/style/style.dart';
import '../../../../core/constants/nutrition_constants.dart';
import '../../models/fruit_model.dart';

class FruitListTile extends StatelessWidget {
  final Fruit fruit;
  const FruitListTile({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    final nutrition = fruit.nutritions;
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
                backgroundColor: AppColors.neonBlue.withOpacity(0.12),
                child: Text(
                  fruit.name.isNotEmpty ? fruit.name[0].toUpperCase() : '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.neonBlue,
                        fontWeight: FontWeight.bold,
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
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap(8),
                        // Show one or two of family/genus/order as trailing info
                        if (fruit.family.isNotEmpty)
                          Row(
                            children: [
                              const Icon(Icons.family_restroom,
                                  size: 16, color: AppColors.neonBlue),
                              const Gap(2),
                              Text(fruit.family,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w500)),
                            ],
                          )
                        else if ((fruit.genus).isNotEmpty)
                          Row(
                            children: [
                              const Icon(Icons.eco,
                                  size: 16, color: AppColors.successGreen),
                              const Gap(2),
                              Text(fruit.genus,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w500)),
                            ],
                          )
                        else if ((fruit.order).isNotEmpty)
                          Row(
                            children: [
                              const Icon(Icons.account_tree,
                                  size: 16, color: AppColors.cyberpunkPurple),
                              const Gap(2),
                              Text(fruit.order,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        const Gap(6),
                        const Icon(Icons.arrow_forward_ios,
                            size: 14, color: AppColors.matrixSilver),
                      ],
                    ),
                    const Gap(2),
                    // Row 2: Show the other two (if available)
                    Row(
                      children: [
                        if (fruit.genus.isNotEmpty)
                          Row(
                            children: [
                              const Icon(Icons.eco,
                                  size: 16, color: AppColors.successGreen),
                              const Gap(2),
                              Text(fruit.genus,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        if (fruit.order.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              children: [
                                const Icon(Icons.account_tree,
                                    size: 16, color: AppColors.cyberpunkPurple),
                                const Gap(2),
                                Text(fruit.order,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500)),
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
                          icon: NutritionInfo.nutrients['sugar']!.icon,
                          color: NutritionInfo.nutrients['sugar']!.color,
                          value: nutrition.sugar.toStringAsFixed(1),
                          label: 'sugar',
                        ),
                        _NutValue(
                          icon: NutritionInfo.nutrients['carbohydrates']!.icon,
                          color:
                              NutritionInfo.nutrients['carbohydrates']!.color,
                          value: nutrition.carbohydrates.toStringAsFixed(1),
                          label: 'carbs',
                        ),
                        const Spacer(),
                        _NutValue(
                          icon: NutritionInfo.nutrients['calories']!.icon,
                          color: NutritionInfo.nutrients['calories']!.color,
                          value: nutrition.calories.toString(),
                          label: 'kcal',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _NutValue(
                          icon: NutritionInfo.nutrients['protein']!.icon,
                          color: NutritionInfo.nutrients['protein']!.color,
                          value: nutrition.protein.toStringAsFixed(1),
                          label: 'protein',
                        ),
                        _NutValue(
                          icon: NutritionInfo.nutrients['fat']!.icon,
                          color: NutritionInfo.nutrients['fat']!.color,
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
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            ' $label',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.matrixSilver,
                ),
          ),
        ],
      ),
    );
  }
}
