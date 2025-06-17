// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fruit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FruitImpl _$$FruitImplFromJson(Map<String, dynamic> json) => _$FruitImpl(
      name: json['name'] as String,
      id: (json['id'] as num).toInt(),
      family: json['family'] as String,
      order: json['order'] as String,
      genus: json['genus'] as String,
      nutritions:
          Nutrition.fromJson(json['nutritions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FruitImplToJson(_$FruitImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'family': instance.family,
      'order': instance.order,
      'genus': instance.genus,
      'nutritions': instance.nutritions,
    };

_$NutritionImpl _$$NutritionImplFromJson(Map<String, dynamic> json) =>
    _$NutritionImpl(
      calories: (json['calories'] as num).toInt(),
      fat: (json['fat'] as num).toDouble(),
      sugar: (json['sugar'] as num).toDouble(),
      carbohydrates: (json['carbohydrates'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
    );

Map<String, dynamic> _$$NutritionImplToJson(_$NutritionImpl instance) =>
    <String, dynamic>{
      'calories': instance.calories,
      'fat': instance.fat,
      'sugar': instance.sugar,
      'carbohydrates': instance.carbohydrates,
      'protein': instance.protein,
    };
