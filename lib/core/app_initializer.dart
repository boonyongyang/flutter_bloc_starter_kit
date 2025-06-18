import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'config/logger.dart';
import 'constants/storage_constants.dart';
import 'di/service_locator.dart';
import 'utils/app_info.dart';
import '../features/auth/services/auth_service.dart';
import '../features/taxonomy/data/datasources/taxonomy_local_client.dart';

/// Handles all application initialization logic
class AppInitializer {
  /// Initialize the application with all required services and data
  static Future<void> initialize() async {
    await _initializeFlutter();
    await _initializeStorage();
    await _initializeDependencies();
    await _initializeServices();
    await _initializeData();
  }

  /// Initialize Flutter framework
  static Future<void> _initializeFlutter() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppInfo.logStartupInfo();
  }

  /// Initialize storage (Hive)
  static Future<void> _initializeStorage() async {
    logger.d('Initializing local storage...');
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Open the app settings box
    await Hive.openBox(StorageConstants.appSettingsBox);
    logger.d('Storage initialized successfully');
  }

  /// Initialize dependency injection
  static Future<void> _initializeDependencies() async {
    logger.d('Setting up service locator...');
    setupServiceLocator();
    logger.d('Service locator setup complete');
  }

  /// Initialize core services
  static Future<void> _initializeServices() async {
    logger.d('Initializing core services...');

    // Initialize AuthService (which opens its Hive box)
    final authService = locator<AuthService>();
    await authService.init();

    logger.d('Core services initialized successfully');
  }

  /// Initialize application data
  static Future<void> _initializeData() async {
    logger.d('Initializing application data...');

    // Initialize taxonomy local data source
    final taxonomyDataSource = locator<TaxonomyLocalClient>();
    await taxonomyDataSource.init();

    // Force refresh data from asset to get the latest taxonomy facts
    logger.d('Refreshing taxonomy facts from JSON file...');
    await taxonomyDataSource
        .clearAll(); // Clear existing data to ensure we get the latest
    await taxonomyDataSource.refreshFromAsset();

    logger.d('Application data initialized successfully');
  }
}
