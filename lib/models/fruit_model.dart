import 'package:freezed_annotation/freezed_annotation.dart';

part 'fruit_model.freezed.dart';
part 'fruit_model.g.dart';

@freezed
class Fruit with _$Fruit {
  const factory Fruit({
    required String name,
    required int id,
    required String family,
    required String order,
    required String genus,
    required Nutrition nutritions,
  }) = _Fruit;

  factory Fruit.fromJson(Map<String, dynamic> json) => _$FruitFromJson(json);
}

@freezed
class Nutrition with _$Nutrition {
  const factory Nutrition({
    required int calories,
    required double fat,
    required double sugar,
    required double carbohydrates,
    required double protein,
  }) = _Nutrition;

  factory Nutrition.fromJson(Map<String, dynamic> json) =>
      _$NutritionFromJson(json);
}
