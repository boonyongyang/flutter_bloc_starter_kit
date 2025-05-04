import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../network/fruits_api_client.dart';
import '../local/local_database_client.dart';
import '../providers/navigation_state.dart';
import '../providers/performance_config.dart';
import '../../repository/sample_repository.dart';
import '../../repository/fruits_repository_impl.dart';
import '../../repository/fruits_repository.dart';
import '../../repository/taxonomy_repository.dart';
import '../../repository/taxonomy_repository_impl.dart';

final locator = GetIt.instance;
final Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.example.com',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
  ),
)..interceptors.add(
    PrettyDioLogger(),
  );

void setupServiceLocator() {
  debugPrint('setupServiceLocator called');
  // Register services as singletons
  locator.registerLazySingleton(() => NavigationState());
  locator.registerLazySingleton(() => PerformanceConfig());
  locator.registerLazySingleton(() => SampleRepository());
  locator.registerLazySingleton<FruitsRepository>(
      () => FruitsRepositoryImpl(FruitsApiClient(dio)));

  // Register our local database client as a singleton
  final localDbClient = LocalDatabaseClient();
  locator.registerLazySingleton(() => localDbClient);

  // Register our taxonomy repository (using the local database)
  locator.registerLazySingleton<TaxonomyRepository>(
      () => TaxonomyRepositoryImpl(localDbClient));
}
