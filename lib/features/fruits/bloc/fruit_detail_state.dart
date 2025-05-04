import '../models/fruit_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fruit_detail_state.freezed.dart';

@freezed
class FruitDetailState with _$FruitDetailState {
  const factory FruitDetailState.initial() = FruitDetailInitial;

  const factory FruitDetailState.loading() = FruitDetailLoading;

  const factory FruitDetailState.loaded({
    required Fruit fruit,
  }) = FruitDetailLoaded;

  const factory FruitDetailState.error(String message) = FruitDetailError;
}
