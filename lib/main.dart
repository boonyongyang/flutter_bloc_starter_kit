import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/logger.dart';
import 'features/theme/bloc/theme_cubit.dart';
import 'core/app.dart';
import 'core/di/service_locator.dart';
import 'core/storage/local_database_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  logger.d('in main');

  // Setup service locator for dependency injection
  setupServiceLocator(); // Initialize local database
  final localDbClient = locator<LocalDatabaseClient>();
  await localDbClient.init();

  // Force refresh data from asset to get the latest taxonomy facts
  logger.d('Refreshing taxonomy facts from JSON file...');
  await localDbClient
      .clearAll(); // Clear existing data to ensure we get the latest
  await localDbClient.refreshFromAsset();
  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(),
      child: const MyApp(),
    ),
  );
}
