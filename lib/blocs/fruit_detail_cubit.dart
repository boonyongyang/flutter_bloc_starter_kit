import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/fruit_model.dart';
import '../repository/fruits_repository.dart';

part 'fruit_detail_state.dart';

class FruitDetailCubit extends Cubit<FruitDetailState> {
  final FruitsRepository _repository;

  FruitDetailCubit(this._repository) : super(FruitDetailInitial());

  Future<void> fetchFruitDetail(String fruitName) async {
    try {
      emit(FruitDetailLoading());
      final fruit = await _repository.fetchFruitDetail(fruitName);
      emit(FruitDetailLoaded(fruit));
    } catch (e) {
      emit(FruitDetailError(e.toString()));
    }
  }
}
