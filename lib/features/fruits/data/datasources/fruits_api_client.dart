import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/fruit_model.dart';

part 'fruits_api_client.g.dart';

@RestApi()
abstract class FruitsApiClient {
  factory FruitsApiClient(
    Dio dio, {
    String? baseUrl,
  }) = _FruitsApiClient;

  @GET("/fruit/all")
  Future<List<Fruit>> getAllFruits();

  @GET("/fruit/{name}")
  Future<Fruit> getFruitDetailByName(
    @Path("name") String name,
  );

  @GET("/fruit/{id}")
  Future<Fruit> getFruitDetailById(
    @Path("id") int id,
  );
}
