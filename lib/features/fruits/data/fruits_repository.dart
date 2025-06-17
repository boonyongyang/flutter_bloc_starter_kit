import 'datasources/fruits_api_client.dart';
import 'models/fruit_model.dart';
import 'i_fruits_repository.dart';

/// Repository for accessing fruit data from the API
class FruitsRepository implements IFruitsRepository {
  final FruitsApiClient _apiClient;

  FruitsRepository(this._apiClient);

  /// Fetches all fruits from the API
  @override
  Future<List<Fruit>> fetchAllFruits() async {
    return await _apiClient.getAllFruits();
  }

  /// Fetches details of a specific fruit by its name from the API
  @override
  Future<Fruit> fetchFruitDetailByName(String fruitName) async {
    return await _apiClient.getFruitDetailByName(fruitName);
  }

  /// Fetches details of a specific fruit by its ID from the API
  @override
  Future<Fruit> fetchFruitDetailById(int id) async {
    return await _apiClient.getFruitDetailById(id);
  }
}
