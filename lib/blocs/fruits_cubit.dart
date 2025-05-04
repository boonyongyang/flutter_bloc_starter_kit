import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/fruit_model.dart';
import '../repository/fruits_repository.dart';

part 'fruits_state.dart';

class FruitsCubit extends Cubit<FruitsState> {
  final FruitsRepository _repository;

  FruitsCubit(this._repository) : super(FruitsInitial());

  Future<void> fetchFruits() async {
    try {
      emit(FruitsLoading());
      final fruits = await _repository.fetchAllFruits();
      emit(FruitsLoaded(fruits));
    } catch (e) {
      emit(FruitsError(e.toString()));
    }
  }
}
