import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/fruit_constants.dart';
import '../../../../core/constants/loading_constants.dart';
import '../../../../core/constants/nutrition_constants.dart';
import '../../../../core/constants/taxonomy_constants.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/style/style.dart';
import '../../../auth/presentation/bloc/auth_cubit.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/fruits_cubit.dart';
import '../bloc/fruits_state.dart';
import '../../data/models/fruit_model.dart';
import '../../data/models/fruit_sort.dart';
import '../../utils/fruit_analysis_utils.dart';
import '../widgets/fruit_list_tile.dart';
import '../widgets/notable_fruits_section.dart';
import '../widgets/nutritional_bar_chart_section.dart';
import '../widgets/nutritional_comparison_section.dart';
import '../widgets/nutritional_overview_section.dart';
import '../widgets/taxonomy_distribution_section.dart';

class FruitsPage extends StatefulWidget {
  const FruitsPage({super.key});

  @override
  State<FruitsPage> createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage> {
  final ValueNotifier<FruitSort> _selectedSort =
      ValueNotifier(FruitSort.calories);
  late ScrollController _scrollController;
  final ValueNotifier<bool> _showFab = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    // Initial data fetch is handled by the parent/router.
  }

  @override
  void dispose() {
    _selectedSort.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _showFab.dispose();
    super.dispose();
  }

  // --- UI Event Handlers ---
  void _scrollListener() {
    if (!mounted) return;
    final screenHeight = MediaQuery.of(context).size.height;
    // Show FAB if scrolled more than half the screen height
    if (_scrollController.offset > screenHeight * 0.5) {
      if (!_showFab.value) {
        _showFab.value = true;
      }
    } else {
      if (_showFab.value) {
        _showFab.value = false;
      }
    }
  }

  void _showSortSheet() async {
    final result = await showModalBottomSheet<FruitSort>(
      showDragHandle: true,
      context: context,
      builder: (context) => _SortBottomSheet(selected: _selectedSort.value),
    );
    if (result != null && result != _selectedSort.value) {
      _selectedSort.value = result;
      HapticFeedback.lightImpact();
    }
  }

  void _showIconInfoSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => const _IconInfoSheet(),
    );
  }

  void _onLogoutPressed() async {
    final confirmLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmLogout == true && mounted) {
      context.read<AuthCubit>().logout();
    }
  }

  Future<void> _onRefreshRequested() async {
    if (!mounted) return;

    context.read<FruitsCubit>().fetchFruits();
  }

  void _onScrollToTopPressed() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  // --- Build Methods ---
  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: _scrollController,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Fruits Dashboard',
            style: AppTextStyles.w700p20,
          ),
          leading: IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Icon legend',
            onPressed: _showIconInfoSheet,
          ),
          actions: [
            // IconButton(
            //   icon: Icon(
            //     Theme.of(context).brightness == Brightness.dark
            //         ? Icons.light_mode
            //         : Icons.dark_mode,
            //   ),
            //   tooltip: 'Toggle Theme',
            //   onPressed: () {
            //     context.read<ThemeCubit>().toggleTheme();
            //   },
            // ),
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.error,
              ),
              tooltip: 'Logout',
              onPressed: _onLogoutPressed,
            ),
          ],
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            state.whenOrNull(
              unauthenticated: () {
                // Navigate to login when unauthenticated.
                // This assumes FruitsPage always requires authentication.
                final currentLocation = GoRouter.of(context)
                    .routerDelegate
                    .currentConfiguration
                    .uri
                    .toString();
                if (currentLocation != AppRoutes.login.path) {
                  context.go(AppRoutes.login.path);
                }
              },
            );
          },
          child: ValueListenableBuilder<FruitSort>(
            valueListenable: _selectedSort,
            builder: (context, sort, _) => _FruitsBody(
              sort: sort,
              onRefresh: _onRefreshRequested,
              onSortPressed: _showSortSheet,
              scrollController: _scrollController,
            ),
          ),
        ),
        floatingActionButton: ValueListenableBuilder<bool>(
          valueListenable: _showFab,
          builder: (context, show, child) {
            return show
                ? FloatingActionButton(
                    shape: const CircleBorder(),
                    onPressed: _onScrollToTopPressed,
                    tooltip: 'Scroll to Top',
                    child: const Icon(Icons.arrow_upward),
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

// Bottom sheet for icon legend/info
class _IconInfoSheet extends StatelessWidget {
  const _IconInfoSheet();

  @override
  Widget build(BuildContext context) {
    final List<_IconInfo> items =
        FruitConstants.iconGlossaryItems.map((itemData) {
      final String key = itemData['key'] as String;
      final InfoSourceType sourceType =
          itemData['sourceType'] as InfoSourceType;
      IconData icon;
      Color color;

      if (sourceType == InfoSourceType.nutrition) {
        icon = NutritionConstants.nutrients[key]!.icon;
        color = NutritionConstants.nutrients[key]!.color;
      } else {
        // InfoSourceType.taxonomy
        icon = TaxonomyConstants.taxonomyInfo[key]!.icon;
        color = TaxonomyConstants.taxonomyInfo[key]!.color;
      }

      return _IconInfo(
        icon: icon,
        color: color,
        title: itemData['title'] as String,
        description: itemData['description'] as String,
      );
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensure Column takes minimum height
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline, size: 24),
                const Gap(8),
                Text('Glossary', style: AppTextStyles.w700p18),
              ],
            ),
            const Gap(12),
            // Removed Expanded and ListView, directly using Column for items
            // as the content is not expected to be excessively long and
            // MainAxisSize.min on the parent Column will handle sizing.
            // If content *can* be very long, then ListView + Expanded is correct,
            // but isScrollControlled: true would also be needed on showModalBottomSheet.
            // For a typical glossary, this direct Column approach is often sufficient.
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(item.icon, color: item.color, size: 22),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title,
                                style: AppTextStyles.w600p14
                                    .copyWith(color: item.color)),
                            const Gap(2),
                            Text(item.description,
                                style: AppTextStyles.w400p12),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}

/// Data class to hold information for icon glossary
class _IconInfo {
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  const _IconInfo({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });
}

class _FruitsBody extends StatelessWidget {
  final FruitSort? sort;
  final Future<void> Function()? onRefresh;
  final VoidCallback? onSortPressed;
  final ScrollController? scrollController;

  const _FruitsBody({
    this.sort,
    this.onRefresh,
    this.onSortPressed,
    this.scrollController,
  });

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FruitsCubit, FruitsState>(
      builder: (context, state) {
        if (state is FruitsLoading) {
          return const _FruitsBodyLoadingView();
        }

        if (state is FruitsLoaded) {
          final FruitSort effectiveSort = sort ?? FruitSort.name;
          final sortedFruits = List<Fruit>.from(state.fruits)
            ..sort(effectiveSort.compare);

          if (sortedFruits.isEmpty) {
            return _buildEmptyState(context);
          }

          final analysisData = calculateFruitAnalysisData(sortedFruits);

          return RefreshIndicator(
            onRefresh: onRefresh ?? () async {},
            child: ListView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, authState) {
                          String username = 'User';
                          authState.whenOrNull(
                            authenticated: (name) {
                              username = name;
                            },
                          );
                          return Text(
                            '${_getGreeting()}, $username!',
                            style: AppTextStyles.w700p16,
                          );
                        },
                      ),
                      const Gap(12),

                      // Nutritional overview cards
                      NutritionalOverviewSection(
                        avgCalories: analysisData.avgCalories,
                        avgProtein: analysisData.avgProtein,
                        avgSugar: analysisData.avgSugar,
                        avgCarbs: analysisData.avgCarbs,
                        fruitCount: analysisData.fruitCount,
                      ),

                      const Gap(24),

                      // Bar chart comparing average nutrient values
                      NutritionalBarChartSection(
                        avgSugar: analysisData.avgSugar,
                        avgCarbs: analysisData.avgCarbs,
                        avgProtein: analysisData.avgProtein,
                        avgFat: analysisData.avgFat,
                      ),

                      const Gap(24),

                      // Taxonomy distribution bubble chart
                      TaxonomyDistributionSection(
                        fruits: sortedFruits,
                      ),

                      const Gap(24),

                      // Notable fruits section
                      NotableFruitsSection(
                        highestCaloriesFruit: analysisData.highestCaloriesFruit,
                        highestProteinFruit: analysisData.highestProteinFruit,
                        highestSugarFruit: analysisData.highestSugarFruit,
                        lowestCaloriesFruit: analysisData.lowestCaloriesFruit,
                      ),

                      const Gap(24),

                      // Nutritional radar chart comparison
                      NutritionalComparisonSection(
                        fruits: sortedFruits,
                        selectedFruits: [
                          analysisData.highestCaloriesFruit.name,
                          analysisData.highestProteinFruit.name,
                          analysisData.highestSugarFruit.name
                        ],
                      ),

                      const Gap(16),

                      // List header
                      Row(
                        children: [
                          const Icon(Icons.format_list_bulleted, size: 16),
                          const Gap(8),
                          Text(
                            'All Fruits',
                            style: AppTextStyles.w700p16,
                          ),
                        ],
                      ),
                      const Gap(16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [
                            ActionChip(
                              avatar: Icon(
                                Icons.sort,
                                size: 16,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              label: Text(
                                effectiveSort.label,
                                style: AppTextStyles.w400p12.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              onPressed: onSortPressed,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  width: 1,
                                ),
                              ),
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${analysisData.fruitCount} items',
                              style: AppTextStyles.w400p12.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // --- List of fruits ---
                ...List.generate(
                  sortedFruits.length,
                  (index) => FruitListTile(
                    fruit: sortedFruits[index],
                  ),
                ),
                const Gap(16),
              ],
            ),
          );
        }

        if (state is FruitsError) {
          return _buildErrorState(context, state.message);
        }

        return _buildEmptyState(context, message: 'No data available.');
      },
    );
  }

  Widget _buildEmptyState(BuildContext context,
      {String message = 'No fruits available'}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const Gap(8),
          ElevatedButton(
            onPressed: () {
              context.read<FruitsCubit>().fetchFruits();
            },
            child: const Text('Try Again'),
          )
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: $errorMessage'),
          const Gap(16),
          ElevatedButton(
            onPressed: () {
              context.read<FruitsCubit>().fetchFruits();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _FruitsBodyLoadingView extends StatelessWidget {
  const _FruitsBodyLoadingView();

  @override
  Widget build(BuildContext context) {
    final cardBorderRadius =
        BorderRadius.circular(LoadingConstants.shimmerCardBorderRadius);
    final shimmerElementColor =
        Theme.of(context).colorScheme.surface.withOpacity(0.5);

    return Shimmer.fromColors(
      baseColor: Theme.of(context)
          .colorScheme
          .surfaceContainerHighest
          .withOpacity(0.3),
      highlightColor: Theme.of(context).colorScheme.surface.withOpacity(0.5),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmer for NutritionalOverviewSection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    LoadingConstants.shimmerOverviewCardCount,
                    (_) => Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: cardBorderRadius),
                        child: Container(
                          height: LoadingConstants.shimmerOverviewHeight,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: shimmerElementColor,
                            borderRadius: cardBorderRadius,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(24),
                // Shimmer for NutritionalBarChartSection
                Card(
                  shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
                  child: Container(
                    height: LoadingConstants.shimmerBarChartHeight,
                    decoration: BoxDecoration(
                      color: shimmerElementColor,
                      borderRadius: cardBorderRadius,
                    ),
                  ),
                ),
                const Gap(24),
                // Shimmer for TaxonomyDistributionSection
                Card(
                  shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
                  child: Container(
                    height: LoadingConstants.shimmerTaxonomyHeight,
                    decoration: BoxDecoration(
                      color: shimmerElementColor,
                      borderRadius: cardBorderRadius,
                    ),
                  ),
                ),
                const Gap(24),
                // Shimmer for NotableFruitsSection
                Card(
                  shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
                  child: Container(
                    height: LoadingConstants.shimmerNotableHeight,
                    decoration: BoxDecoration(
                      color: shimmerElementColor,
                      borderRadius: cardBorderRadius,
                    ),
                  ),
                ),
                const Gap(24),
                // Shimmer for NutritionalComparisonSection
                Card(
                  shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
                  child: Container(
                    height: LoadingConstants.shimmerComparisonHeight,
                    decoration: BoxDecoration(
                      color: shimmerElementColor,
                      borderRadius: cardBorderRadius,
                    ),
                  ),
                ),
                const Gap(16),
                // Shimmer for List header
                Row(
                  children: [
                    Container(
                        width: LoadingConstants.shimmerListHeaderIconSize,
                        height: LoadingConstants.shimmerListHeaderIconSize,
                        decoration: BoxDecoration(
                            color: shimmerElementColor,
                            borderRadius: BorderRadius.circular(4))),
                    const Gap(8),
                    Container(
                        width: LoadingConstants.shimmerListHeaderTextWidth,
                        height: LoadingConstants.shimmerListHeaderIconSize,
                        decoration: BoxDecoration(
                            color: shimmerElementColor,
                            borderRadius: BorderRadius.circular(4))),
                    const Spacer(),
                    Container(
                        width: LoadingConstants.shimmerListHeaderCounterWidth,
                        height: LoadingConstants.shimmerListHeaderIconSize,
                        decoration: BoxDecoration(
                            color: shimmerElementColor,
                            borderRadius: BorderRadius.circular(4))),
                  ],
                ),
              ],
            ),
          ),
          // Shimmer for FruitListTiles
          ...List.generate(
            LoadingConstants.shimmerListItemCount,
            (index) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Container(
                      width: LoadingConstants.shimmerListItemImageSize,
                      height: LoadingConstants.shimmerListItemImageSize,
                      decoration: BoxDecoration(
                          color: shimmerElementColor,
                          borderRadius: BorderRadius.circular(8)),
                      margin: const EdgeInsets.only(right: 16)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: double.infinity,
                            height: LoadingConstants.shimmerListItemTitleHeight,
                            decoration: BoxDecoration(
                                color: shimmerElementColor,
                                borderRadius: BorderRadius.circular(4))),
                        const Gap(4),
                        Container(
                            width: 100,
                            height:
                                LoadingConstants.shimmerListItemSubtitleHeight,
                            decoration: BoxDecoration(
                                color: shimmerElementColor,
                                borderRadius: BorderRadius.circular(4))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SortBottomSheet extends StatelessWidget {
  final FruitSort selected;
  const _SortBottomSheet({required this.selected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Sort by', style: AppTextStyles.w700p18),
          ),
          ...FruitSort.values.map((sort) {
            return RadioListTile<FruitSort>(
              value: sort,
              groupValue: selected,
              title: Text(sort.label),
              onChanged: (value) {
                Navigator.of(context).pop(value);
              },
            );
          }),
        ],
      ),
    );
  }
}
