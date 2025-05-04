// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'taxonomy_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TaxonomyState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaxonomyInitial value) initial,
    required TResult Function(TaxonomyLoading value) loading,
    required TResult Function(TaxonomyLoaded value) loaded,
    required TResult Function(TaxonomyError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaxonomyInitial value)? initial,
    TResult? Function(TaxonomyLoading value)? loading,
    TResult? Function(TaxonomyLoaded value)? loaded,
    TResult? Function(TaxonomyError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaxonomyInitial value)? initial,
    TResult Function(TaxonomyLoading value)? loading,
    TResult Function(TaxonomyLoaded value)? loaded,
    TResult Function(TaxonomyError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaxonomyStateCopyWith<$Res> {
  factory $TaxonomyStateCopyWith(
          TaxonomyState value, $Res Function(TaxonomyState) then) =
      _$TaxonomyStateCopyWithImpl<$Res, TaxonomyState>;
}

/// @nodoc
class _$TaxonomyStateCopyWithImpl<$Res, $Val extends TaxonomyState>
    implements $TaxonomyStateCopyWith<$Res> {
  _$TaxonomyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaxonomyState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TaxonomyInitialImplCopyWith<$Res> {
  factory _$$TaxonomyInitialImplCopyWith(_$TaxonomyInitialImpl value,
          $Res Function(_$TaxonomyInitialImpl) then) =
      __$$TaxonomyInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TaxonomyInitialImplCopyWithImpl<$Res>
    extends _$TaxonomyStateCopyWithImpl<$Res, _$TaxonomyInitialImpl>
    implements _$$TaxonomyInitialImplCopyWith<$Res> {
  __$$TaxonomyInitialImplCopyWithImpl(
      _$TaxonomyInitialImpl _value, $Res Function(_$TaxonomyInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaxonomyState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TaxonomyInitialImpl implements TaxonomyInitial {
  const _$TaxonomyInitialImpl();

  @override
  String toString() {
    return 'TaxonomyState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TaxonomyInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)
        loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)?
        loaded,
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
    required TResult Function(TaxonomyInitial value) initial,
    required TResult Function(TaxonomyLoading value) loading,
    required TResult Function(TaxonomyLoaded value) loaded,
    required TResult Function(TaxonomyError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaxonomyInitial value)? initial,
    TResult? Function(TaxonomyLoading value)? loading,
    TResult? Function(TaxonomyLoaded value)? loaded,
    TResult? Function(TaxonomyError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaxonomyInitial value)? initial,
    TResult Function(TaxonomyLoading value)? loading,
    TResult Function(TaxonomyLoaded value)? loaded,
    TResult Function(TaxonomyError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TaxonomyInitial implements TaxonomyState {
  const factory TaxonomyInitial() = _$TaxonomyInitialImpl;
}

/// @nodoc
abstract class _$$TaxonomyLoadingImplCopyWith<$Res> {
  factory _$$TaxonomyLoadingImplCopyWith(_$TaxonomyLoadingImpl value,
          $Res Function(_$TaxonomyLoadingImpl) then) =
      __$$TaxonomyLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TaxonomyLoadingImplCopyWithImpl<$Res>
    extends _$TaxonomyStateCopyWithImpl<$Res, _$TaxonomyLoadingImpl>
    implements _$$TaxonomyLoadingImplCopyWith<$Res> {
  __$$TaxonomyLoadingImplCopyWithImpl(
      _$TaxonomyLoadingImpl _value, $Res Function(_$TaxonomyLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaxonomyState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TaxonomyLoadingImpl implements TaxonomyLoading {
  const _$TaxonomyLoadingImpl();

  @override
  String toString() {
    return 'TaxonomyState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TaxonomyLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)?
        loaded,
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
    required TResult Function(TaxonomyInitial value) initial,
    required TResult Function(TaxonomyLoading value) loading,
    required TResult Function(TaxonomyLoaded value) loaded,
    required TResult Function(TaxonomyError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaxonomyInitial value)? initial,
    TResult? Function(TaxonomyLoading value)? loading,
    TResult? Function(TaxonomyLoaded value)? loaded,
    TResult? Function(TaxonomyError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaxonomyInitial value)? initial,
    TResult Function(TaxonomyLoading value)? loading,
    TResult Function(TaxonomyLoaded value)? loaded,
    TResult Function(TaxonomyError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TaxonomyLoading implements TaxonomyState {
  const factory TaxonomyLoading() = _$TaxonomyLoadingImpl;
}

/// @nodoc
abstract class _$$TaxonomyLoadedImplCopyWith<$Res> {
  factory _$$TaxonomyLoadedImplCopyWith(_$TaxonomyLoadedImpl value,
          $Res Function(_$TaxonomyLoadedImpl) then) =
      __$$TaxonomyLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TaxonomyFact fact, String taxonomyName, String taxonomyType});
}

/// @nodoc
class __$$TaxonomyLoadedImplCopyWithImpl<$Res>
    extends _$TaxonomyStateCopyWithImpl<$Res, _$TaxonomyLoadedImpl>
    implements _$$TaxonomyLoadedImplCopyWith<$Res> {
  __$$TaxonomyLoadedImplCopyWithImpl(
      _$TaxonomyLoadedImpl _value, $Res Function(_$TaxonomyLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaxonomyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fact = null,
    Object? taxonomyName = null,
    Object? taxonomyType = null,
  }) {
    return _then(_$TaxonomyLoadedImpl(
      fact: null == fact
          ? _value.fact
          : fact // ignore: cast_nullable_to_non_nullable
              as TaxonomyFact,
      taxonomyName: null == taxonomyName
          ? _value.taxonomyName
          : taxonomyName // ignore: cast_nullable_to_non_nullable
              as String,
      taxonomyType: null == taxonomyType
          ? _value.taxonomyType
          : taxonomyType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaxonomyLoadedImpl implements TaxonomyLoaded {
  const _$TaxonomyLoadedImpl(
      {required this.fact,
      required this.taxonomyName,
      required this.taxonomyType});

  @override
  final TaxonomyFact fact;
  @override
  final String taxonomyName;
  @override
  final String taxonomyType;

  @override
  String toString() {
    return 'TaxonomyState.loaded(fact: $fact, taxonomyName: $taxonomyName, taxonomyType: $taxonomyType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaxonomyLoadedImpl &&
            (identical(other.fact, fact) || other.fact == fact) &&
            (identical(other.taxonomyName, taxonomyName) ||
                other.taxonomyName == taxonomyName) &&
            (identical(other.taxonomyType, taxonomyType) ||
                other.taxonomyType == taxonomyType));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, fact, taxonomyName, taxonomyType);

  /// Create a copy of TaxonomyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaxonomyLoadedImplCopyWith<_$TaxonomyLoadedImpl> get copyWith =>
      __$$TaxonomyLoadedImplCopyWithImpl<_$TaxonomyLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(fact, taxonomyName, taxonomyType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(fact, taxonomyName, taxonomyType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(fact, taxonomyName, taxonomyType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaxonomyInitial value) initial,
    required TResult Function(TaxonomyLoading value) loading,
    required TResult Function(TaxonomyLoaded value) loaded,
    required TResult Function(TaxonomyError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaxonomyInitial value)? initial,
    TResult? Function(TaxonomyLoading value)? loading,
    TResult? Function(TaxonomyLoaded value)? loaded,
    TResult? Function(TaxonomyError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaxonomyInitial value)? initial,
    TResult Function(TaxonomyLoading value)? loading,
    TResult Function(TaxonomyLoaded value)? loaded,
    TResult Function(TaxonomyError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TaxonomyLoaded implements TaxonomyState {
  const factory TaxonomyLoaded(
      {required final TaxonomyFact fact,
      required final String taxonomyName,
      required final String taxonomyType}) = _$TaxonomyLoadedImpl;

  TaxonomyFact get fact;
  String get taxonomyName;
  String get taxonomyType;

  /// Create a copy of TaxonomyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaxonomyLoadedImplCopyWith<_$TaxonomyLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaxonomyErrorImplCopyWith<$Res> {
  factory _$$TaxonomyErrorImplCopyWith(
          _$TaxonomyErrorImpl value, $Res Function(_$TaxonomyErrorImpl) then) =
      __$$TaxonomyErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TaxonomyErrorImplCopyWithImpl<$Res>
    extends _$TaxonomyStateCopyWithImpl<$Res, _$TaxonomyErrorImpl>
    implements _$$TaxonomyErrorImplCopyWith<$Res> {
  __$$TaxonomyErrorImplCopyWithImpl(
      _$TaxonomyErrorImpl _value, $Res Function(_$TaxonomyErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaxonomyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$TaxonomyErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaxonomyErrorImpl implements TaxonomyError {
  const _$TaxonomyErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'TaxonomyState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaxonomyErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TaxonomyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaxonomyErrorImplCopyWith<_$TaxonomyErrorImpl> get copyWith =>
      __$$TaxonomyErrorImplCopyWithImpl<_$TaxonomyErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            TaxonomyFact fact, String taxonomyName, String taxonomyType)?
        loaded,
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
    required TResult Function(TaxonomyInitial value) initial,
    required TResult Function(TaxonomyLoading value) loading,
    required TResult Function(TaxonomyLoaded value) loaded,
    required TResult Function(TaxonomyError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaxonomyInitial value)? initial,
    TResult? Function(TaxonomyLoading value)? loading,
    TResult? Function(TaxonomyLoaded value)? loaded,
    TResult? Function(TaxonomyError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaxonomyInitial value)? initial,
    TResult Function(TaxonomyLoading value)? loading,
    TResult Function(TaxonomyLoaded value)? loaded,
    TResult Function(TaxonomyError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TaxonomyError implements TaxonomyState {
  const factory TaxonomyError(final String message) = _$TaxonomyErrorImpl;

  String get message;

  /// Create a copy of TaxonomyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaxonomyErrorImplCopyWith<_$TaxonomyErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
