import 'models/fruit_model.dart';

/// Abstract repository for fruit data
abstract class IFruitsRepository {
  /// Fetch all fruits
  Future<List<Fruit>> fetchAllFruits();

  /// Fetch details of a specific fruit by its name
  Future<Fruit> fetchFruitDetailByName(String fruitName);

  /// Fetch details of a specific fruit by its ID
  Future<Fruit> fetchFruitDetailById(int id);
}
