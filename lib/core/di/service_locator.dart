import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:uuid/uuid.dart';

import '../config/env.dart';
import '../../features/fruits/data/datasources/fruits_api_client.dart';
import '../../features/fruits/data/fruits_repository.dart';
import '../../features/taxonomy/data/repositories/taxonomy_repository.dart';
import '../../features/taxonomy/data/datasources/taxonomy_local_client.dart';
import '../../features/auth/presentation/bloc/auth_cubit.dart';
import '../../features/auth/services/auth_service.dart';
import '../../features/fruits/data/i_fruits_repository.dart';
import '../../features/taxonomy/data/repositories/i_taxonomy_repository.dart';

final locator = GetIt.instance;

void setupServiceLocator() {
  // Register Dio as a lazy singleton
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.fruitsApiBaseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
    dio.interceptors.add(
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
    return dio;
  });

  // Register services as singletons
  locator.registerLazySingleton<IFruitsRepository>(
      () => FruitsRepository(FruitsApiClient(locator<Dio>())));

  // Register FlutterSecureStorage
  locator.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  // Register Uuid
  locator.registerLazySingleton<Uuid>(() => const Uuid());

  // Register AuthService
  locator.registerLazySingleton<AuthService>(() => AuthService(
        locator<FlutterSecureStorage>(),
        locator<Uuid>(),
      ));

  // Register our taxonomy local data source as a singleton
  final taxonomyDataSource = TaxonomyLocalClient();
  locator.registerLazySingleton(() => taxonomyDataSource);

  // Register our taxonomy repository (using the local data source)
  locator.registerLazySingleton<ITaxonomyRepository>(
      () => TaxonomyRepository(taxonomyDataSource));

  // Register Cubits/Blocs as factories
  locator.registerFactory<AuthCubit>(
    () => AuthCubit(locator<AuthService>()),
  );
}
