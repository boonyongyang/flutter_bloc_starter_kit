import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/nutrition_constants.dart';
import '../../../../core/constants/taxonomy_constants.dart';
import '../../../../core/constants/presentation_constants.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/style/app_colors.dart';
import '../../../auth/bloc/auth_cubit.dart';
import '../../../auth/bloc/auth_state.dart';
import '../../bloc/fruits_cubit.dart';
import '../../bloc/fruits_state.dart';
import '../../models/fruit_model.dart';
import '../../models/fruit_sort.dart';
import '../../utils/fruit_analysis_utils.dart';
import '../widgets/fruit_list_tile.dart';
import '../widgets/notable_fruits_section.dart';
import '../widgets/nutritional_bar_chart_section.dart';
import '../widgets/nutritional_comparison_section.dart';
import '../widgets/nutritional_overview_section.dart';
import '../widgets/taxonomy_distribution_section.dart';
import '../../../../core/constants/loading_constants.dart';

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
      // TODO: [Demo Enhancement] Add subtle animation on sort change.
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
    if (confirmLogout == true) {
      context.read<AuthCubit>().logout();
    }
  }

  Future<void> _onRefreshRequested() async {
    context.read<FruitsCubit>().fetchFruits();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Refreshing fruits data...'),
        duration: Duration(seconds: 1),
      ),
    );
    // It's better to show success/failure based on the actual result from the cubit.
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
        // TODO: [Demo Enhancement] Consider making AppBar theme more dynamic or customizable.
        appBar: AppBar(
          title: const Text('Fruits Dashboard'),
          leading: IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _onLogoutPressed,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'Icon legend',
              onPressed: _showIconInfoSheet,
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
                    // TODO: [Demo Enhancement] Consider a more descriptive icon or mini-fab.
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
    // TODO: [Demo Enhancement] Consider making this data driven from a config file or constants.
    final List<_IconInfo> items = IconGlossaryConstants.items.map((itemData) {
      final String key = itemData['key'] as String;
      final InfoSourceType sourceType =
          itemData['sourceType'] as InfoSourceType;
      IconData icon;
      Color color;

      if (sourceType == InfoSourceType.nutrition) {
        icon = NutritionInfo.nutrients[key]!.icon;
        color = NutritionInfo.nutrients[key]!.color;
      } else {
        // InfoSourceType.taxonomy
        icon = TaxonomyInfo.taxonomy[key]!.icon;
        color = TaxonomyInfo.taxonomy[key]!.color;
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
                Text('Glossary',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: item.color)),
                            const Gap(2),
                            Text(item.description,
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            const Gap(8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
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
          // TODO: [Demo Enhancement] Add a more engaging loading animation or placeholder.
          return const _FruitsBodyLoadingView();
        }

        if (state is FruitsLoaded) {
          final FruitSort effectiveSort = sort ?? FruitSort.name;
          final sortedFruits = List<Fruit>.from(state.fruits)
            ..sort(effectiveSort.compare);

          if (sortedFruits.isEmpty) {
            // TODO: [Demo Enhancement] Add an illustration or a "call to action" for empty states.
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
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
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
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const Gap(16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [
                            ActionChip(
                              avatar: const Icon(
                                Icons.sort,
                                size: 16,
                                color: AppColors.hologramWhite,
                              ),
                              label: Text(
                                effectiveSort.label,
                                style: const TextStyle(
                                  color: AppColors.hologramWhite,
                                  fontSize: 12,
                                ),
                              ),
                              onPressed: onSortPressed,
                              backgroundColor: AppColors.cyberpunkPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.matrixSilver,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // --- List of fruits ---
                // TODO: [Demo Enhancement] Implement pagination or infinite scrolling for very long lists.
                ...List.generate(
                  sortedFruits.length,
                  (index) => FruitListTile(fruit: sortedFruits[index]),
                ),
                const Gap(16),
              ],
            ),
          );
        }

        if (state is FruitsError) {
          // TODO: [Demo Enhancement] Provide a "Retry" button or more specific error feedback.
          return _buildErrorState(context, state.message);
        }

        // TODO: [Demo Enhancement] Handle unexpected states more gracefully.
        return _buildEmptyState(context,
            message: 'No data available (unexpected state).');
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
    final cardBorderRadius = BorderRadius.circular(kShimmerCardBorderRadius);
    final shimmerElementColor = Colors.white.withOpacity(0.5);

    return Shimmer.fromColors(
      baseColor: AppColors.midnightBlue,
      highlightColor: AppColors.nightShade,
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
                    kShimmerOverviewCardCount,
                    (_) => Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: cardBorderRadius),
                        child: Container(
                          height: kShimmerOverviewHeight,
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
                    height: kShimmerBarChartHeight,
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
                    height: kShimmerTaxonomyHeight,
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
                    height: kShimmerNotableHeight,
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
                    height: kShimmerComparisonHeight,
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
                        width: kShimmerListHeaderIconSize,
                        height: kShimmerListHeaderIconSize,
                        decoration: BoxDecoration(
                            color: shimmerElementColor,
                            borderRadius: BorderRadius.circular(4))),
                    const Gap(8),
                    Container(
                        width: kShimmerListHeaderTextWidth,
                        height: kShimmerListHeaderIconSize,
                        decoration: BoxDecoration(
                            color: shimmerElementColor,
                            borderRadius: BorderRadius.circular(4))),
                    const Spacer(),
                    Container(
                        width: kShimmerListHeaderCounterWidth,
                        height: kShimmerListHeaderIconSize,
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
            kShimmerListItemCount,
            (index) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Container(
                      width: kShimmerListItemImageSize,
                      height: kShimmerListItemImageSize,
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
                            height: kShimmerListItemTitleHeight,
                            decoration: BoxDecoration(
                                color: shimmerElementColor,
                                borderRadius: BorderRadius.circular(4))),
                        const Gap(4),
                        Container(
                            width:
                                100, // Could be a constant if desired, e.g., kShimmerListItemSubtitleMaxWidth
                            height: kShimmerListItemSubtitleHeight,
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
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Sort by',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
