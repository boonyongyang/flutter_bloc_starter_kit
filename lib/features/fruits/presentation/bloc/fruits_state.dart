import '../../data/models/fruit_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fruits_state.freezed.dart';

/// FruitsState represents all possible UI states for the fruits list.
///
/// - [FruitsInitial]: The initial state before any action.
/// - [FruitsLoading]: Indicates data is being loaded.
/// - [FruitsLoaded]: Contains the loaded list of fruits.
/// - [FruitsError]: Contains an error message if loading fails.
@freezed
class FruitsState with _$FruitsState {
  /// The initial state before any action.
  const factory FruitsState.initial() = FruitsInitial;

  /// Indicates data is being loaded.
  const factory FruitsState.loading() = FruitsLoading;

  /// Contains the loaded list of fruits.
  const factory FruitsState.loaded({
    required List<Fruit> fruits,
  }) = FruitsLoaded;

  /// Contains an error message if loading fails.
  const factory FruitsState.error(String message) = FruitsError;
}
