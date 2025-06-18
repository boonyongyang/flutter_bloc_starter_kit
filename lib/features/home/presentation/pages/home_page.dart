import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/l10n_extensions.dart';
import '../../../theme/bloc/theme_cubit.dart';

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
          context.l10n.homePageTitle,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimary,
          ),
        ),
        actions: [
          BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, themeState) {
              return IconButton(
                icon: Icon(
                  themeState.brightness == Brightness.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color: colorScheme.onPrimary,
                ),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
              );
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
                context.l10n.welcomeMessage,
                style: textTheme.headlineLarge,
              ),
              const Gap(16),
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
                    context.l10n.aboutProjectTitle,
                    style: textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    context.l10n.aboutProjectDescription,
                    style: textTheme.bodyMedium,
                  ),
                  onTap: () {
                    // Navigate to About Page
                  },
                ),
              ),
              const Gap(16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(context, Icons.api, context.l10n.apiCalls),
                  _buildFeatureCard(
                      context, Icons.storage, context.l10n.localDatabase),
                  _buildFeatureCard(
                      context, Icons.sync, context.l10n.offlineSync),
                  _buildFeatureCard(
                      context, Icons.language, context.l10n.localization),
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
      if (title == context.l10n.apiCalls) {
        context.go('/fruits');
      } else if (title == context.l10n.localDatabase) {
        context.go('/local-database');
      } else if (title == context.l10n.offlineSync) {
        context.go('/offline-sync');
      } else if (title == context.l10n.localization) {
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
            const Gap(8),
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
