import 'package:flutter/material.dart';

import '../style/app_colors.dart';

/// Nutrition display constants
class NutritionConstants {
  // Icons and colors
  static const Map<String, ({IconData icon, Color color, String tooltip})>
      nutrients = {
    'sugar': (
      icon: Icons.cake,
      color: AppColors.errorRed,
      tooltip: 'Amount of sugar in grams'
    ),
    'carbohydrates': (
      icon: Icons.bubble_chart,
      color: AppColors.cyberpunkPurple,
      tooltip: 'Total carbohydrates in grams'
    ),
    'protein': (
      icon: Icons.fitness_center,
      color: AppColors.successGreen,
      tooltip: 'Protein content in grams'
    ),
    'fat': (
      icon: Icons.oil_barrel,
      color: AppColors.digitalTeal,
      tooltip: 'Fat content in grams'
    ),
    'calories': (
      icon: Icons.local_fire_department,
      color: AppColors.laserAmber,
      tooltip: 'Energy provided in kcal'
    ),
  };

  NutritionConstants._();
}
