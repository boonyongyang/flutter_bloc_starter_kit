import 'package:equatable/equatable.dart';

import '../models/taxonomy_fact_model.dart';

abstract class TaxonomyState extends Equatable {
  const TaxonomyState();

  @override
  List<Object?> get props => [];
}

class TaxonomyInitial extends TaxonomyState {
  const TaxonomyInitial();
}

class TaxonomyLoading extends TaxonomyState {
  const TaxonomyLoading();
}

class TaxonomyLoaded extends TaxonomyState {
  final TaxonomyFact fact;
  final String taxonomyName;
  final String taxonomyType; // kFamilyType, kGenusType, or kOrderType

  const TaxonomyLoaded({
    required this.fact,
    required this.taxonomyName,
    required this.taxonomyType,
  });

  @override
  List<Object?> get props => [fact, taxonomyName, taxonomyType];
}

class TaxonomyError extends TaxonomyState {
  final String message;

  const TaxonomyError(this.message);

  @override
  List<Object?> get props => [message];
}
