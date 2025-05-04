part of 'fruits_cubit.dart';

abstract class FruitsState {}

class FruitsInitial extends FruitsState {}

class FruitsLoading extends FruitsState {}

class FruitsLoaded extends FruitsState {
  final List<Fruit> fruits;

  FruitsLoaded(this.fruits);
}

class FruitsError extends FruitsState {
  final String message;

  FruitsError(this.message);
}
