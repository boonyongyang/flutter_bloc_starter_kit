import '../models/taxonomy_fact_model.dart';

/// Abstract repository for taxonomy facts
abstract class TaxonomyRepository {
  /// Get facts for a specific taxonomy family
  Future<TaxonomyFact?> getFamilyFact(String familyName);

  /// Get facts for a specific taxonomy genus
  Future<TaxonomyFact?> getGenusFact(String genusName);

  /// Get facts for a specific taxonomy order
  Future<TaxonomyFact?> getOrderFact(String orderName);

  /// Check if a taxonomy name exists in the specified taxonomy type
  Future<bool> hasTaxonomyName(String taxonomyType, String name);

  /// Get all taxonomy facts
  Future<TaxonomyType?> getAllTaxonomyFacts();
}
