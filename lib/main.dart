import 'package:flutter/material.dart';

import 'core/app.dart';
import 'core/app_initializer.dart';
import 'core/app_bloc_providers.dart';

void main() async {
  // Initialize all application services and data
  await AppInitializer.initialize();

  // Run the application with BLoC providers
  runApp(
    AppBlocProviders.create(
      child: const MyApp(),
    ),
  );
}
