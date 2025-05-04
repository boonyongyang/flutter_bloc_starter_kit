import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/fruits_cubit.dart';
import '../../features/home/presentation/pages/fruits_page.dart';
import '../../features/home/presentation/pages/local_database_page.dart';
import '../../features/home/presentation/pages/localization_page.dart';
import '../../features/home/presentation/pages/offline_sync_page.dart';
import '../../features/home/presentation/pages/fruit_detail_page.dart';
import '../../features/home/view/home_page.dart';
import '../../models/fruit_model.dart';
import '../../repository/fruits_repository.dart';
import '../di/service_locator.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'fruits',
          pageBuilder: (context, state) => MaterialPage(
            child: BlocProvider(
              create: (context) => FruitsCubit(
                locator<FruitsRepository>(),
              )..fetchFruits(),
              child: const FruitsPage(),
            ),
          ),
          routes: [
            GoRoute(
              path: 'fruit-detail',
              pageBuilder: (context, state) => MaterialPage(
                child: FruitDetailPage(fruit: state.extra as Fruit),
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'local-database',
          builder: (context, state) => const LocalDatabasePage(),
        ),
        GoRoute(
          path: 'offline-sync',
          builder: (context, state) => const OfflineSyncPage(),
        ),
        GoRoute(
          path: 'localization',
          builder: (context, state) => const LocalizationPage(),
        ),
      ],
    ),
  ],
);
