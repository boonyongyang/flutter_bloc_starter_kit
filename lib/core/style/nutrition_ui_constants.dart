import 'package:flutter/material.dart';
import '../style/app_colors.dart';

/// Common nutrition icons and colors used throughout the app
class NutritionInfo {
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
      icon: Icons.egg,
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
}

/// Taxonomy information for displaying fruit classifications
class TaxonomyInfo {
  static const Map<String, ({IconData icon, Color color, String tooltip})>
      taxonomy = {
    'family': (
      icon: Icons.family_restroom,
      color: AppColors.neonBlue,
      tooltip: 'Botanical family'
    ),
    'genus': (
      icon: Icons.eco,
      color: AppColors.successGreen,
      tooltip: 'Genus classification'
    ),
    'order': (
      icon: Icons.account_tree,
      color: AppColors.cyberpunkPurple,
      tooltip: 'Order in plant taxonomy'
    ),
  };
}
