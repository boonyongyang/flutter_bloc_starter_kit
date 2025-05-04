import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/fruits/models/fruit_model.dart';

part 'fruits_api_client.g.dart';

@RestApi(baseUrl: "https://fruityvice.com/api")
abstract class FruitsApiClient {
  factory FruitsApiClient(
    Dio dio, {
    String baseUrl,
  }) = _FruitsApiClient;

  @GET("/fruit/all")
  Future<List<Fruit>> getAllFruits();

  @GET("/fruit/{name}")
  Future<Fruit> getFruitDetail(
    // @Path("id") int id, // id works as well, but need to update the path above
    @Path("name") String name,
  );
}
