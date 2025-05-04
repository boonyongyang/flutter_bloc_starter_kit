import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/fruits_repository.dart';
import 'fruit_detail_state.dart';

class FruitDetailCubit extends Cubit<FruitDetailState> {
  final FruitsRepository _repository;

  FruitDetailCubit(this._repository) : super(const FruitDetailInitial());

  Future<void> fetchFruitDetail(String fruitName) async {
    try {
      emit(const FruitDetailLoading());
      final fruit = await _repository.fetchFruitDetail(fruitName);
      emit(FruitDetailLoaded(fruit: fruit));
    } catch (e) {
      emit(FruitDetailError(e.toString()));
    }
  }
}
