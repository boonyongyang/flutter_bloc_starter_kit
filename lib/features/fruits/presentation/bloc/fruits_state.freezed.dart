// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fruits_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FruitsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Fruit> fruits) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Fruit> fruits)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Fruit> fruits)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FruitsInitial value) initial,
    required TResult Function(FruitsLoading value) loading,
    required TResult Function(FruitsLoaded value) loaded,
    required TResult Function(FruitsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FruitsInitial value)? initial,
    TResult? Function(FruitsLoading value)? loading,
    TResult? Function(FruitsLoaded value)? loaded,
    TResult? Function(FruitsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FruitsInitial value)? initial,
    TResult Function(FruitsLoading value)? loading,
    TResult Function(FruitsLoaded value)? loaded,
    TResult Function(FruitsError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FruitsStateCopyWith<$Res> {
  factory $FruitsStateCopyWith(
          FruitsState value, $Res Function(FruitsState) then) =
      _$FruitsStateCopyWithImpl<$Res, FruitsState>;
}

/// @nodoc
class _$FruitsStateCopyWithImpl<$Res, $Val extends FruitsState>
    implements $FruitsStateCopyWith<$Res> {
  _$FruitsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FruitsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FruitsInitialImplCopyWith<$Res> {
  factory _$$FruitsInitialImplCopyWith(
          _$FruitsInitialImpl value, $Res Function(_$FruitsInitialImpl) then) =
      __$$FruitsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FruitsInitialImplCopyWithImpl<$Res>
    extends _$FruitsStateCopyWithImpl<$Res, _$FruitsInitialImpl>
    implements _$$FruitsInitialImplCopyWith<$Res> {
  __$$FruitsInitialImplCopyWithImpl(
      _$FruitsInitialImpl _value, $Res Function(_$FruitsInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of FruitsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FruitsInitialImpl implements FruitsInitial {
  const _$FruitsInitialImpl();

  @override
  String toString() {
    return 'FruitsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FruitsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Fruit> fruits) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Fruit> fruits)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Fruit> fruits)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FruitsInitial value) initial,
    required TResult Function(FruitsLoading value) loading,
    required TResult Function(FruitsLoaded value) loaded,
    required TResult Function(FruitsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FruitsInitial value)? initial,
    TResult? Function(FruitsLoading value)? loading,
    TResult? Function(FruitsLoaded value)? loaded,
    TResult? Function(FruitsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FruitsInitial value)? initial,
    TResult Function(FruitsLoading value)? loading,
    TResult Function(FruitsLoaded value)? loaded,
    TResult Function(FruitsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class FruitsInitial implements FruitsState {
  const factory FruitsInitial() = _$FruitsInitialImpl;
}

/// @nodoc
abstract class _$$FruitsLoadingImplCopyWith<$Res> {
  factory _$$FruitsLoadingImplCopyWith(
          _$FruitsLoadingImpl value, $Res Function(_$FruitsLoadingImpl) then) =
      __$$FruitsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FruitsLoadingImplCopyWithImpl<$Res>
    extends _$FruitsStateCopyWithImpl<$Res, _$FruitsLoadingImpl>
    implements _$$FruitsLoadingImplCopyWith<$Res> {
  __$$FruitsLoadingImplCopyWithImpl(
      _$FruitsLoadingImpl _value, $Res Function(_$FruitsLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of FruitsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FruitsLoadingImpl implements FruitsLoading {
  const _$FruitsLoadingImpl();

  @override
  String toString() {
    return 'FruitsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FruitsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Fruit> fruits) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Fruit> fruits)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Fruit> fruits)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FruitsInitial value) initial,
    required TResult Function(FruitsLoading value) loading,
    required TResult Function(FruitsLoaded value) loaded,
    required TResult Function(FruitsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FruitsInitial value)? initial,
    TResult? Function(FruitsLoading value)? loading,
    TResult? Function(FruitsLoaded value)? loaded,
    TResult? Function(FruitsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FruitsInitial value)? initial,
    TResult Function(FruitsLoading value)? loading,
    TResult Function(FruitsLoaded value)? loaded,
    TResult Function(FruitsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class FruitsLoading implements FruitsState {
  const factory FruitsLoading() = _$FruitsLoadingImpl;
}

/// @nodoc
abstract class _$$FruitsLoadedImplCopyWith<$Res> {
  factory _$$FruitsLoadedImplCopyWith(
          _$FruitsLoadedImpl value, $Res Function(_$FruitsLoadedImpl) then) =
      __$$FruitsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Fruit> fruits});
}

/// @nodoc
class __$$FruitsLoadedImplCopyWithImpl<$Res>
    extends _$FruitsStateCopyWithImpl<$Res, _$FruitsLoadedImpl>
    implements _$$FruitsLoadedImplCopyWith<$Res> {
  __$$FruitsLoadedImplCopyWithImpl(
      _$FruitsLoadedImpl _value, $Res Function(_$FruitsLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of FruitsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fruits = null,
  }) {
    return _then(_$FruitsLoadedImpl(
      fruits: null == fruits
          ? _value._fruits
          : fruits // ignore: cast_nullable_to_non_nullable
              as List<Fruit>,
    ));
  }
}

/// @nodoc

class _$FruitsLoadedImpl implements FruitsLoaded {
  const _$FruitsLoadedImpl({required final List<Fruit> fruits})
      : _fruits = fruits;

  final List<Fruit> _fruits;
  @override
  List<Fruit> get fruits {
    if (_fruits is EqualUnmodifiableListView) return _fruits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fruits);
  }

  @override
  String toString() {
    return 'FruitsState.loaded(fruits: $fruits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FruitsLoadedImpl &&
            const DeepCollectionEquality().equals(other._fruits, _fruits));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_fruits));

  /// Create a copy of FruitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FruitsLoadedImplCopyWith<_$FruitsLoadedImpl> get copyWith =>
      __$$FruitsLoadedImplCopyWithImpl<_$FruitsLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Fruit> fruits) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(fruits);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Fruit> fruits)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(fruits);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Fruit> fruits)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(fruits);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FruitsInitial value) initial,
    required TResult Function(FruitsLoading value) loading,
    required TResult Function(FruitsLoaded value) loaded,
    required TResult Function(FruitsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FruitsInitial value)? initial,
    TResult? Function(FruitsLoading value)? loading,
    TResult? Function(FruitsLoaded value)? loaded,
    TResult? Function(FruitsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FruitsInitial value)? initial,
    TResult Function(FruitsLoading value)? loading,
    TResult Function(FruitsLoaded value)? loaded,
    TResult Function(FruitsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class FruitsLoaded implements FruitsState {
  const factory FruitsLoaded({required final List<Fruit> fruits}) =
      _$FruitsLoadedImpl;

  List<Fruit> get fruits;

  /// Create a copy of FruitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FruitsLoadedImplCopyWith<_$FruitsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FruitsErrorImplCopyWith<$Res> {
  factory _$$FruitsErrorImplCopyWith(
          _$FruitsErrorImpl value, $Res Function(_$FruitsErrorImpl) then) =
      __$$FruitsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FruitsErrorImplCopyWithImpl<$Res>
    extends _$FruitsStateCopyWithImpl<$Res, _$FruitsErrorImpl>
    implements _$$FruitsErrorImplCopyWith<$Res> {
  __$$FruitsErrorImplCopyWithImpl(
      _$FruitsErrorImpl _value, $Res Function(_$FruitsErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of FruitsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$FruitsErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FruitsErrorImpl implements FruitsError {
  const _$FruitsErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'FruitsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FruitsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of FruitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FruitsErrorImplCopyWith<_$FruitsErrorImpl> get copyWith =>
      __$$FruitsErrorImplCopyWithImpl<_$FruitsErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Fruit> fruits) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Fruit> fruits)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Fruit> fruits)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FruitsInitial value) initial,
    required TResult Function(FruitsLoading value) loading,
    required TResult Function(FruitsLoaded value) loaded,
    required TResult Function(FruitsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FruitsInitial value)? initial,
    TResult? Function(FruitsLoading value)? loading,
    TResult? Function(FruitsLoaded value)? loaded,
    TResult? Function(FruitsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FruitsInitial value)? initial,
    TResult Function(FruitsLoading value)? loading,
    TResult Function(FruitsLoaded value)? loaded,
    TResult Function(FruitsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class FruitsError implements FruitsState {
  const factory FruitsError(final String message) = _$FruitsErrorImpl;

  String get message;

  /// Create a copy of FruitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FruitsErrorImplCopyWith<_$FruitsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
