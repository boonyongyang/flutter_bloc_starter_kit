import '../../../../core/storage/local_database_client.dart';
import '../models/taxonomy_fact_model.dart';
import 'i_taxonomy_repository.dart';

/// Repository for accessing taxonomy facts from the local database
class TaxonomyRepository implements ITaxonomyRepository {
  final LocalDatabaseClient _localDatabaseClient;

  TaxonomyRepository(this._localDatabaseClient);

  /// Fetches taxonomy facts for a specific family from the local database
  @override
  Future<TaxonomyFact?> getFamilyFact(String familyName) async {
    return await _localDatabaseClient.getFamilyFact(familyName);
  }

  /// Fetches taxonomy facts for a specific genus from the local database
  @override
  Future<TaxonomyFact?> getGenusFact(String genusName) async {
    return await _localDatabaseClient.getGenusFact(genusName);
  }

  /// Fetches taxonomy facts for a specific order from the local database
  @override
  Future<TaxonomyFact?> getOrderFact(String orderName) async {
    return await _localDatabaseClient.getOrderFact(orderName);
  }

  /// Fetches all taxonomy facts from the local database
  @override
  Future<TaxonomyType?> getAllTaxonomyFacts() async {
    return await _localDatabaseClient.getAllTaxonomyFacts();
  }

  /// Checks if a taxonomy name exists in the specified taxonomy type
  @override
  Future<bool> hasTaxonomyName(String taxonomyType, String name) async {
    return await _localDatabaseClient.hasTaxonomyName(taxonomyType, name);
  }
}
