part of 'fruit_detail_cubit.dart';

abstract class FruitDetailState {}

class FruitDetailInitial extends FruitDetailState {}

class FruitDetailLoading extends FruitDetailState {}

class FruitDetailLoaded extends FruitDetailState {
  final Fruit fruit;

  FruitDetailLoaded(this.fruit);
}

class FruitDetailError extends FruitDetailState {
  final String message;

  FruitDetailError(this.message);
}
