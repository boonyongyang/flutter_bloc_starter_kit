import '../../../core/storage/local_database_client.dart';
import '../models/taxonomy_fact_model.dart';
import 'taxonomy_repository.dart';

/// Implementation of the TaxonomyRepository using LocalDatabaseClient
class TaxonomyRepositoryImpl implements TaxonomyRepository {
  final LocalDatabaseClient _localDatabaseClient;

  TaxonomyRepositoryImpl(this._localDatabaseClient);

  @override
  Future<TaxonomyFact?> getFamilyFact(String familyName) async {
    return await _localDatabaseClient.getFamilyFact(familyName);
  }

  @override
  Future<TaxonomyFact?> getGenusFact(String genusName) async {
    return await _localDatabaseClient.getGenusFact(genusName);
  }

  @override
  Future<TaxonomyFact?> getOrderFact(String orderName) async {
    return await _localDatabaseClient.getOrderFact(orderName);
  }

  @override
  Future<TaxonomyType?> getAllTaxonomyFacts() async {
    return await _localDatabaseClient.getAllTaxonomyFacts();
  }

  @override
  Future<bool> hasTaxonomyName(String taxonomyType, String name) async {
    return await _localDatabaseClient.hasTaxonomyName(taxonomyType, name);
  }
}
