import 'package:flutter/material.dart';

import '../../../../core/constants/nutrition_constants.dart';
import '../../../../models/fruit_model.dart';

class NutritionChips extends StatelessWidget {
  final Nutrition nutrition;

  const NutritionChips({
    super.key,
    required this.nutrition,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _NutritionSection(
          title: 'Main Macros',
          chips: [
            _NutritionChip(
              label: 'Carbs: ${nutrition.carbohydrates.toStringAsFixed(1)}g',
              icon: NutritionInfo.nutrients['carbohydrates']!.icon,
              color: NutritionInfo.nutrients['carbohydrates']!.color,
            ),
            _NutritionChip(
              label: 'Protein: ${nutrition.protein.toStringAsFixed(1)}g',
              icon: NutritionInfo.nutrients['protein']!.icon,
              color: NutritionInfo.nutrients['protein']!.color,
            ),
            _NutritionChip(
              label: 'Fat: ${nutrition.fat.toStringAsFixed(1)}g',
              icon: NutritionInfo.nutrients['fat']!.icon,
              color: NutritionInfo.nutrients['fat']!.color,
            ),
          ],
        ),
        const SizedBox(height: 16),
        _NutritionSection(
          title: 'Other',
          chips: [
            _NutritionChip(
              label: 'Calories: ${nutrition.calories}',
              icon: NutritionInfo.nutrients['calories']!.icon,
              color: NutritionInfo.nutrients['calories']!.color,
            ),
            _NutritionChip(
              label: 'Sugar: ${nutrition.sugar.toStringAsFixed(1)}g',
              icon: NutritionInfo.nutrients['sugar']!.icon,
              color: NutritionInfo.nutrients['sugar']!.color,
            ),
          ],
        ),
      ],
    );
  }
}

class _NutritionSection extends StatelessWidget {
  final String title;
  final List<Widget> chips;

  const _NutritionSection({
    required this.title,
    required this.chips,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: chips,
        ),
      ],
    );
  }
}

class _NutritionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _NutritionChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, color: color, size: 16),
      label: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      backgroundColor: color.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
    );
  }
}
