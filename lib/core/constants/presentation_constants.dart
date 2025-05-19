// lib/core/constants/presentation_constants.dart

enum InfoSourceType { nutrition, taxonomy }

class IconGlossaryConstants {
  static final List<Map<String, dynamic>> items = [
    {
      'key': 'sugar',
      'sourceType': InfoSourceType.nutrition,
      'title': 'Sugar',
      'description':
          'Amount of sugar (g) in the fruit. High sugar fruits are sweeter.',
    },
    {
      'key': 'carbohydrates',
      'sourceType': InfoSourceType.nutrition,
      'title': 'Carbohydrates',
      'description': 'Total carbohydrates (g), including sugars and fiber.',
    },
    {
      'key': 'protein',
      'sourceType': InfoSourceType.nutrition,
      'title': 'Protein',
      'description':
          'Protein (g) content. Important for body repair and growth.',
    },
    {
      'key': 'fat',
      'sourceType': InfoSourceType.nutrition,
      'title': 'Fat',
      'description': 'Fat (g) content. Most fruits are naturally low in fat.',
    },
    {
      'key': 'calories',
      'sourceType': InfoSourceType.nutrition,
      'title': 'Calories',
      'description': 'Energy provided by the fruit (kcal).',
    },
    {
      'key': 'family',
      'sourceType': InfoSourceType.taxonomy,
      'title': 'Family',
      'description': 'The botanical family this fruit belongs to.',
    },
    {
      'key': 'genus',
      'sourceType': InfoSourceType.taxonomy,
      'title': 'Genus',
      'description': 'The genus classification of the fruit.',
    },
    {
      'key': 'order',
      'sourceType': InfoSourceType.taxonomy,
      'title': 'Order',
      'description': 'The order classification in plant taxonomy.',
    },
  ];
}
