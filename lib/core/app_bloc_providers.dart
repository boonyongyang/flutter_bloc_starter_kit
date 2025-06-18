import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/service_locator.dart';
import '../features/auth/presentation/bloc/auth_cubit.dart';
import '../features/theme/bloc/theme_cubit.dart';

/// Provides all BLoC providers for the application
class AppBlocProviders {
  /// Creates the MultiBlocProvider with all required providers
  static MultiBlocProvider create({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => locator<AuthCubit>()..checkAuthenticationStatus(),
        ),
      ],
      child: child,
    );
  }
}
