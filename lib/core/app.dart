import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/theme/bloc/theme_cubit.dart';
import 'config/env.dart';

import 'routes/app_router.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // First, we get the ThemeCubit instance
    final themeCubit = BlocProvider.of<ThemeCubit>(context);

    // Then we listen to the theme changes with BlocBuilder
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        // We wrap our router in another BlocProvider to ensure all route builders have access to the ThemeCubit
        return BlocProvider.value(
          value: themeCubit,
          child: MaterialApp.router(
            routerConfig: router,
            theme: theme,
            restorationScopeId: 'app',
            localizationsDelegates: const [
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
            ],
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)?.homePageTitle ?? Env.appName,
          ),
        );
      },
    );
  }
}
