import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/services/auth_service.dart';
import '../../features/fruits/presentation/pages/fruits_page.dart';
import '../../features/fruits/bloc/fruits_cubit.dart';
import '../../features/fruits/presentation/pages/fruit_detail_page.dart';
import '../../features/fruits/models/fruit_model.dart';
import '../../features/fruits/data/fruits_repository.dart';
import '../di/service_locator.dart';
import 'app_routes.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.login.path,
  redirect: (BuildContext context, GoRouterState state) async {
    final authService = locator<AuthService>();
    final isLoggedIn = await authService.isLoggedIn();
    final isLoggingIn = state.matchedLocation == AppRoutes.login.path;

    if (!isLoggedIn && !isLoggingIn) {
      return AppRoutes.login.path;
    }

    if (isLoggedIn && isLoggingIn) {
      return AppRoutes.fruits.path;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.login.path,
      pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
    ),
    GoRoute(
      path: AppRoutes.fruits.path,
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
          path: AppRoutes.fruitDetail.path,
          pageBuilder: (context, state) => MaterialPage(
            child: FruitDetailPage(fruit: state.extra as Fruit),
          ),
        ),
      ],
    ),
  ],
);
