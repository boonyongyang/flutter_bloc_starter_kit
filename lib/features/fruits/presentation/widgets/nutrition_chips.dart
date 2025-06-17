import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/nutrition_constants.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../data/models/fruit_model.dart';

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
              icon: NutritionConstants.nutrients['carbohydrates']!.icon,
              color: NutritionConstants.nutrients['carbohydrates']!.color,
            ),
            _NutritionChip(
              label: 'Protein: ${nutrition.protein.toStringAsFixed(1)}g',
              icon: NutritionConstants.nutrients['protein']!.icon,
              color: NutritionConstants.nutrients['protein']!.color,
            ),
            _NutritionChip(
              label: 'Fat: ${nutrition.fat.toStringAsFixed(1)}g',
              icon: NutritionConstants.nutrients['fat']!.icon,
              color: NutritionConstants.nutrients['fat']!.color,
            ),
          ],
        ),
        const Gap(16),
        _NutritionSection(
          title: 'Other',
          chips: [
            _NutritionChip(
              label: 'Calories: ${nutrition.calories}',
              icon: NutritionConstants.nutrients['calories']!.icon,
              color: NutritionConstants.nutrients['calories']!.color,
            ),
            _NutritionChip(
              label: 'Sugar: ${nutrition.sugar.toStringAsFixed(1)}g',
              icon: NutritionConstants.nutrients['sugar']!.icon,
              color: NutritionConstants.nutrients['sugar']!.color,
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
          style: AppTextStyles.w600p14,
        ),
        const Gap(6),
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
        style: AppTextStyles.w400p12,
      ),
      backgroundColor: color.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
    );
  }
}
