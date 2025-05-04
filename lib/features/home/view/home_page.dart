import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/theme_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          AppLocalizations.of(context)?.homePageTitle ?? 'Home Page',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              context.read<ThemeCubit>().state.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: colorScheme.onPrimary,
            ),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)?.welcomeMessage ??
                    'Welcome to the Flutter Bloc Starter Kit!',
                style: textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                    color: colorScheme.secondary,
                  ),
                  title: Text(
                    AppLocalizations.of(context)?.aboutProjectTitle ??
                        'About the Project',
                    style: textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    AppLocalizations.of(context)?.aboutProjectDescription ??
                        'Learn more about the features and goals.',
                    style: textTheme.bodyMedium,
                  ),
                  onTap: () {
                    // Navigate to About Page
                  },
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(context, Icons.api,
                      AppLocalizations.of(context)?.apiCalls ?? 'API Calls'),
                  _buildFeatureCard(
                      context,
                      Icons.storage,
                      AppLocalizations.of(context)?.localDatabase ??
                          'Local Database'),
                  _buildFeatureCard(
                      context,
                      Icons.sync,
                      AppLocalizations.of(context)?.offlineSync ??
                          'Offline Sync'),
                  _buildFeatureCard(
                      context,
                      Icons.language,
                      AppLocalizations.of(context)?.localization ??
                          'Localization'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, IconData icon, String title) {
    void navigateToPage() {
      if (title == AppLocalizations.of(context)?.apiCalls ||
          title == 'API Calls') {
        context.go('/fruits');
      } else if (title == AppLocalizations.of(context)?.localDatabase ||
          title == 'Local Database') {
        context.go('/local-database');
      } else if (title == AppLocalizations.of(context)?.offlineSync ||
          title == 'Offline Sync') {
        context.go('/offline-sync');
      } else if (title == AppLocalizations.of(context)?.localization ||
          title == 'Localization') {
        context.go('/localization');
      }
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: navigateToPage,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
