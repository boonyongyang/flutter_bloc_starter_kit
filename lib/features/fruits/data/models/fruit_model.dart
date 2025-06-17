import 'package:freezed_annotation/freezed_annotation.dart';

part 'fruit_model.freezed.dart';
part 'fruit_model.g.dart';

/// Data model representing a fruit and its nutritional information.
@freezed
class Fruit with _$Fruit {
  /// Creates a [Fruit] with the given properties.
  const factory Fruit({
    required String name,
    required int id,
    required String family,
    required String order,
    required String genus,
    required Nutrition nutritions,
  }) = _Fruit;

  /// Creates a [Fruit] from a JSON map.
  factory Fruit.fromJson(Map<String, dynamic> json) => _$FruitFromJson(json);
}

/// Data model for nutrition values of a fruit.
@freezed
class Nutrition with _$Nutrition {
  /// Creates a [Nutrition] object.
  const factory Nutrition({
    required int calories,
    required double fat,
    required double sugar,
    required double carbohydrates,
    required double protein,
  }) = _Nutrition;

  /// Creates a [Nutrition] object from a JSON map.
  factory Nutrition.fromJson(Map<String, dynamic> json) =>
      _$NutritionFromJson(json);
}
