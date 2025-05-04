// filepath: /Users/boonyongyang/Development/flutterProjects/flutter_bloc_starter_kit/lib/core/utils/nutrition_constants.dart
import 'package:flutter/material.dart';

import '../style/app_colors.dart';
import '../../models/fruit_model.dart';

/// Utility functions for formatting nutrition values
class NutritionFormatter {
  /// Format a nutrition value with the specified number of decimal places
  static String formatDouble(double value, {int decimalPlaces = 1}) {
    return value.toStringAsFixed(decimalPlaces);
  }

  /// Format a nutrition value with a unit (g, kcal, etc.)
  static String formatWithUnit(double value, String unit,
      {int decimalPlaces = 1}) {
    return '${formatDouble(value, decimalPlaces: decimalPlaces)}$unit';
  }

  /// Get a formatted value with unit based on the nutrient name
  static String formatNutrient(Nutrition nutrition, String nutrientName) {
    switch (nutrientName) {
      case 'sugar':
        return formatWithUnit(nutrition.sugar, 'g');
      case 'carbohydrates':
        return formatWithUnit(nutrition.carbohydrates, 'g');
      case 'protein':
        return formatWithUnit(nutrition.protein, 'g');
      case 'fat':
        return formatWithUnit(nutrition.fat, 'g');
      case 'calories':
        return nutrition.calories.toString();
      default:
        return '';
    }
  }
}

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
