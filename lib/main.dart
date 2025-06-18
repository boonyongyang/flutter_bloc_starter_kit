import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/config/logger.dart';
import 'core/utils/app_info.dart';
import 'features/auth/presentation/bloc/auth_cubit.dart';
import 'features/auth/services/auth_service.dart';
import 'features/theme/bloc/theme_cubit.dart';
import 'core/app.dart';
import 'core/di/service_locator.dart';
import 'features/taxonomy/data/datasources/taxonomy_local_client.dart';
import 'core/constants/storage_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Log application startup information
  AppInfo.logStartupInfo();

  // Initialize Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Open the app settings box
  await Hive.openBox(StorageConstants.appSettingsBox);

  // Setup service locator for dependency injection
  setupServiceLocator();

  // Initialize AuthService (which opens its Hive box)
  final authService = locator<AuthService>();
  await authService.init();

  // Initialize taxonomy local data source
  final taxonomyDataSource = locator<TaxonomyLocalClient>();
  await taxonomyDataSource.init();

  // Force refresh data from asset to get the latest taxonomy facts
  logger.d('Refreshing taxonomy facts from JSON file...');
  await taxonomyDataSource
      .clearAll(); // Clear existing data to ensure we get the latest
  await taxonomyDataSource.refreshFromAsset();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => locator<AuthCubit>()..checkAuthenticationStatus(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
