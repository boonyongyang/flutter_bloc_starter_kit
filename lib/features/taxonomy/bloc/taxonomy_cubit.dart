import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/taxonomy_constants.dart';
import '../data/taxonomy_repository.dart';
import 'taxonomy_state.dart';

class TaxonomyCubit extends Cubit<TaxonomyState> {
  final TaxonomyRepository _taxonomyRepository;

  TaxonomyCubit(this._taxonomyRepository) : super(const TaxonomyInitial());

  /// Fetch taxonomy facts for a specific family
  Future<void> getFamilyFact(String familyName) async {
    if (familyName.isEmpty) {
      emit(const TaxonomyError('Family name is empty'));
      return;
    }

    try {
      emit(const TaxonomyLoading());
      final fact = await _taxonomyRepository.getFamilyFact(familyName);

      if (fact != null) {
        emit(TaxonomyLoaded(
          fact: fact,
          taxonomyName: familyName,
          taxonomyType: kFamilyType,
        ));
      } else {
        emit(TaxonomyError(
            'No taxonomy facts available for $familyName family'));
      }
    } catch (e) {
      emit(TaxonomyError('Failed to load family data: ${e.toString()}'));
    }
  }

  /// Fetch taxonomy facts for a specific genus
  Future<void> getGenusFact(String genusName) async {
    if (genusName.isEmpty) {
      emit(const TaxonomyError('Genus name is empty'));
      return;
    }

    try {
      emit(const TaxonomyLoading());
      final fact = await _taxonomyRepository.getGenusFact(genusName);

      if (fact != null) {
        emit(TaxonomyLoaded(
          fact: fact,
          taxonomyName: genusName,
          taxonomyType: kGenusType,
        ));
      } else {
        emit(TaxonomyError('No information found for genus: $genusName'));
      }
    } catch (e) {
      emit(TaxonomyError('Failed to load genus data: ${e.toString()}'));
    }
  }

  /// Fetch taxonomy facts for a specific order
  Future<void> getOrderFact(String orderName) async {
    if (orderName.isEmpty) {
      emit(const TaxonomyError('Order name is empty'));
      return;
    }

    try {
      emit(const TaxonomyLoading());
      final fact = await _taxonomyRepository.getOrderFact(orderName);

      if (fact != null) {
        emit(TaxonomyLoaded(
          fact: fact,
          taxonomyName: orderName,
          taxonomyType: kOrderType,
        ));
      } else {
        emit(TaxonomyError('No information found for order: $orderName'));
      }
    } catch (e) {
      emit(TaxonomyError('Failed to load order data: ${e.toString()}'));
    }
  }

  /// Reset the taxonomy state
  void reset() {
    emit(const TaxonomyInitial());
  }
}
