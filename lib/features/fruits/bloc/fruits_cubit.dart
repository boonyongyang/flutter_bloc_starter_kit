import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/fruits_repository.dart';
import 'fruits_state.dart';

/// FruitsCubit manages the state of the fruits list in the app.
///
/// It fetches fruits from the repository and emits loading, loaded, or error states.
class FruitsCubit extends Cubit<FruitsState> {
  final FruitsRepository _repository;

  /// Creates a [FruitsCubit] with the given [FruitsRepository].
  FruitsCubit(this._repository) : super(const FruitsInitial());

  /// Fetches all fruits and updates the state accordingly.
  Future<void> fetchFruits() async {
    try {
      emit(const FruitsLoading());
      final fruits = await _repository.fetchAllFruits();
      emit(FruitsLoaded(fruits: fruits));
    } catch (e) {
      emit(FruitsError(e.toString()));
    }
  }
}
