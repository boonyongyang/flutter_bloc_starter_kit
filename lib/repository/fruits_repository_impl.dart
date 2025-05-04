import '../core/network/fruits_api_client.dart';
import '../models/fruit_model.dart';
import 'fruits_repository.dart';

class FruitsRepositoryImpl implements FruitsRepository {
  final FruitsApiClient _apiClient;

  FruitsRepositoryImpl(this._apiClient);

  @override
  Future<List<Fruit>> fetchAllFruits() async {
    return await _apiClient.getAllFruits();
  }

  @override
  Future<Fruit> fetchFruitDetail(String fruitName) async {
    return await _apiClient.getFruitDetail(fruitName);
  }
}
