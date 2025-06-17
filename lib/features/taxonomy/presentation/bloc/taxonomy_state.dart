import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/taxonomy_fact_model.dart';

part 'taxonomy_state.freezed.dart';

@freezed
class TaxonomyState with _$TaxonomyState {
  const factory TaxonomyState.initial() = TaxonomyInitial;

  const factory TaxonomyState.loading() = TaxonomyLoading;

  const factory TaxonomyState.loaded({
    required TaxonomyFact fact,
    required String taxonomyName,
    required String taxonomyType, // kFamilyType, kGenusType, or kOrderType
  }) = TaxonomyLoaded;

  const factory TaxonomyState.error(String message) = TaxonomyError;
}
