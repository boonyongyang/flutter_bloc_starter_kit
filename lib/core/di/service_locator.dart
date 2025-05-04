import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/logger.dart';
import '../network/fruits_api_client.dart';
import '../storage/local_database_client.dart';
import '../providers/performance_config.dart';
import '../../features/fruits/data/fruits_repository_impl.dart';
import '../../features/fruits/data/fruits_repository.dart';
import '../../features/taxonomy/data/taxonomy_repository.dart';
import '../../features/taxonomy/data/taxonomy_repository_impl.dart';

final locator = GetIt.instance;
final Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.example.com',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
  ),
)..interceptors.add(
    PrettyDioLogger(
      compact: true,
      maxWidth: 150,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ),
  );

void setupServiceLocator() {
  logger.d('setupServiceLocator called');
  // Register services as singletons
  locator.registerLazySingleton(() => PerformanceConfig());
  locator.registerLazySingleton<FruitsRepository>(
      () => FruitsRepositoryImpl(FruitsApiClient(dio)));

  // Register our local database client as a singleton
  final localDbClient = LocalDatabaseClient();
  locator.registerLazySingleton(() => localDbClient);

  // Register our taxonomy repository (using the local database)
  locator.registerLazySingleton<TaxonomyRepository>(
      () => TaxonomyRepositoryImpl(localDbClient));
}
