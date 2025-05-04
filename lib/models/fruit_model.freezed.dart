// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fruit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Fruit _$FruitFromJson(Map<String, dynamic> json) {
  return _Fruit.fromJson(json);
}

/// @nodoc
mixin _$Fruit {
  String get name => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get family => throw _privateConstructorUsedError;
  String get order => throw _privateConstructorUsedError;
  String get genus => throw _privateConstructorUsedError;
  Nutrition get nutritions => throw _privateConstructorUsedError;

  /// Serializes this Fruit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Fruit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FruitCopyWith<Fruit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FruitCopyWith<$Res> {
  factory $FruitCopyWith(Fruit value, $Res Function(Fruit) then) =
      _$FruitCopyWithImpl<$Res, Fruit>;
  @useResult
  $Res call(
      {String name,
      int id,
      String family,
      String order,
      String genus,
      Nutrition nutritions});

  $NutritionCopyWith<$Res> get nutritions;
}

/// @nodoc
class _$FruitCopyWithImpl<$Res, $Val extends Fruit>
    implements $FruitCopyWith<$Res> {
  _$FruitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Fruit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? family = null,
    Object? order = null,
    Object? genus = null,
    Object? nutritions = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      family: null == family
          ? _value.family
          : family // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as String,
      genus: null == genus
          ? _value.genus
          : genus // ignore: cast_nullable_to_non_nullable
              as String,
      nutritions: null == nutritions
          ? _value.nutritions
          : nutritions // ignore: cast_nullable_to_non_nullable
              as Nutrition,
    ) as $Val);
  }

  /// Create a copy of Fruit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionCopyWith<$Res> get nutritions {
    return $NutritionCopyWith<$Res>(_value.nutritions, (value) {
      return _then(_value.copyWith(nutritions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FruitImplCopyWith<$Res> implements $FruitCopyWith<$Res> {
  factory _$$FruitImplCopyWith(
          _$FruitImpl value, $Res Function(_$FruitImpl) then) =
      __$$FruitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int id,
      String family,
      String order,
      String genus,
      Nutrition nutritions});

  @override
  $NutritionCopyWith<$Res> get nutritions;
}

/// @nodoc
class __$$FruitImplCopyWithImpl<$Res>
    extends _$FruitCopyWithImpl<$Res, _$FruitImpl>
    implements _$$FruitImplCopyWith<$Res> {
  __$$FruitImplCopyWithImpl(
      _$FruitImpl _value, $Res Function(_$FruitImpl) _then)
      : super(_value, _then);

  /// Create a copy of Fruit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? family = null,
    Object? order = null,
    Object? genus = null,
    Object? nutritions = null,
  }) {
    return _then(_$FruitImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      family: null == family
          ? _value.family
          : family // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as String,
      genus: null == genus
          ? _value.genus
          : genus // ignore: cast_nullable_to_non_nullable
              as String,
      nutritions: null == nutritions
          ? _value.nutritions
          : nutritions // ignore: cast_nullable_to_non_nullable
              as Nutrition,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FruitImpl implements _Fruit {
  const _$FruitImpl(
      {required this.name,
      required this.id,
      required this.family,
      required this.order,
      required this.genus,
      required this.nutritions});

  factory _$FruitImpl.fromJson(Map<String, dynamic> json) =>
      _$$FruitImplFromJson(json);

  @override
  final String name;
  @override
  final int id;
  @override
  final String family;
  @override
  final String order;
  @override
  final String genus;
  @override
  final Nutrition nutritions;

  @override
  String toString() {
    return 'Fruit(name: $name, id: $id, family: $family, order: $order, genus: $genus, nutritions: $nutritions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FruitImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.family, family) || other.family == family) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.genus, genus) || other.genus == genus) &&
            (identical(other.nutritions, nutritions) ||
                other.nutritions == nutritions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, id, family, order, genus, nutritions);

  /// Create a copy of Fruit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FruitImplCopyWith<_$FruitImpl> get copyWith =>
      __$$FruitImplCopyWithImpl<_$FruitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FruitImplToJson(
      this,
    );
  }
}

abstract class _Fruit implements Fruit {
  const factory _Fruit(
      {required final String name,
      required final int id,
      required final String family,
      required final String order,
      required final String genus,
      required final Nutrition nutritions}) = _$FruitImpl;

  factory _Fruit.fromJson(Map<String, dynamic> json) = _$FruitImpl.fromJson;

  @override
  String get name;
  @override
  int get id;
  @override
  String get family;
  @override
  String get order;
  @override
  String get genus;
  @override
  Nutrition get nutritions;

  /// Create a copy of Fruit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FruitImplCopyWith<_$FruitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Nutrition _$NutritionFromJson(Map<String, dynamic> json) {
  return _Nutrition.fromJson(json);
}

/// @nodoc
mixin _$Nutrition {
  int get calories => throw _privateConstructorUsedError;
  double get fat => throw _privateConstructorUsedError;
  double get sugar => throw _privateConstructorUsedError;
  double get carbohydrates => throw _privateConstructorUsedError;
  double get protein => throw _privateConstructorUsedError;

  /// Serializes this Nutrition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Nutrition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionCopyWith<Nutrition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionCopyWith<$Res> {
  factory $NutritionCopyWith(Nutrition value, $Res Function(Nutrition) then) =
      _$NutritionCopyWithImpl<$Res, Nutrition>;
  @useResult
  $Res call(
      {int calories,
      double fat,
      double sugar,
      double carbohydrates,
      double protein});
}

/// @nodoc
class _$NutritionCopyWithImpl<$Res, $Val extends Nutrition>
    implements $NutritionCopyWith<$Res> {
  _$NutritionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Nutrition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calories = null,
    Object? fat = null,
    Object? sugar = null,
    Object? carbohydrates = null,
    Object? protein = null,
  }) {
    return _then(_value.copyWith(
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      sugar: null == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double,
      carbohydrates: null == carbohydrates
          ? _value.carbohydrates
          : carbohydrates // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionImplCopyWith<$Res>
    implements $NutritionCopyWith<$Res> {
  factory _$$NutritionImplCopyWith(
          _$NutritionImpl value, $Res Function(_$NutritionImpl) then) =
      __$$NutritionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int calories,
      double fat,
      double sugar,
      double carbohydrates,
      double protein});
}

/// @nodoc
class __$$NutritionImplCopyWithImpl<$Res>
    extends _$NutritionCopyWithImpl<$Res, _$NutritionImpl>
    implements _$$NutritionImplCopyWith<$Res> {
  __$$NutritionImplCopyWithImpl(
      _$NutritionImpl _value, $Res Function(_$NutritionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Nutrition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calories = null,
    Object? fat = null,
    Object? sugar = null,
    Object? carbohydrates = null,
    Object? protein = null,
  }) {
    return _then(_$NutritionImpl(
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      sugar: null == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double,
      carbohydrates: null == carbohydrates
          ? _value.carbohydrates
          : carbohydrates // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionImpl implements _Nutrition {
  const _$NutritionImpl(
      {required this.calories,
      required this.fat,
      required this.sugar,
      required this.carbohydrates,
      required this.protein});

  factory _$NutritionImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionImplFromJson(json);

  @override
  final int calories;
  @override
  final double fat;
  @override
  final double sugar;
  @override
  final double carbohydrates;
  @override
  final double protein;

  @override
  String toString() {
    return 'Nutrition(calories: $calories, fat: $fat, sugar: $sugar, carbohydrates: $carbohydrates, protein: $protein)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionImpl &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.sugar, sugar) || other.sugar == sugar) &&
            (identical(other.carbohydrates, carbohydrates) ||
                other.carbohydrates == carbohydrates) &&
            (identical(other.protein, protein) || other.protein == protein));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, calories, fat, sugar, carbohydrates, protein);

  /// Create a copy of Nutrition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionImplCopyWith<_$NutritionImpl> get copyWith =>
      __$$NutritionImplCopyWithImpl<_$NutritionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionImplToJson(
      this,
    );
  }
}

abstract class _Nutrition implements Nutrition {
  const factory _Nutrition(
      {required final int calories,
      required final double fat,
      required final double sugar,
      required final double carbohydrates,
      required final double protein}) = _$NutritionImpl;

  factory _Nutrition.fromJson(Map<String, dynamic> json) =
      _$NutritionImpl.fromJson;

  @override
  int get calories;
  @override
  double get fat;
  @override
  double get sugar;
  @override
  double get carbohydrates;
  @override
  double get protein;

  /// Create a copy of Nutrition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionImplCopyWith<_$NutritionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
