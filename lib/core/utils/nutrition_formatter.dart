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
  static String formatNutrient(dynamic nutrition, String nutrientName) {
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
