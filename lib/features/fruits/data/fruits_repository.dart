import '../models/fruit_model.dart';

abstract class FruitsRepository {
  Future<List<Fruit>> fetchAllFruits();
  Future<Fruit> fetchFruitDetail(String fruitName);
}
