import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/nutrition_constants.dart';
import '../../../../core/constants/taxonomy_constants.dart';
import '../../../../core/style/app_colors.dart';
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
import '../widgets/loading_constants.dart';

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
    // context.read<FruitsCubit>().fetchFruits(); // not required, as it's provided by parent
  }

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
    }
  }

  @override
  void dispose() {
    _selectedSort.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _showFab.dispose();
    super.dispose();
  }

  void _showIconInfoSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => const _IconInfoSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Icon legend',
            onPressed: _showIconInfoSheet,
          ),
        ],
      ),
      body: ValueListenableBuilder<FruitSort>(
        valueListenable: _selectedSort,
        builder: (context, sort, _) => _FruitsBody(
          sort: sort,
          onRefresh: () async {
            context.read<FruitsCubit>().fetchFruits();
          },
          onSortPressed: _showSortSheet,
          scrollController: _scrollController, // Pass the scroll controller
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _showFab,
        builder: (context, show, child) {
          return show
              ? FloatingActionButton(
                  onPressed: () {
                    _scrollController.animateTo(
                      0.0,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeInOut,
                    );
                  },
                  tooltip: 'Scroll to Top',
                  child: const Icon(Icons.arrow_upward),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}

// Bottom sheet for icon legend/info
class _IconInfoSheet extends StatelessWidget {
  const _IconInfoSheet();

  @override
  Widget build(BuildContext context) {
    final List<_IconInfo> items = [
      _IconInfo(
        icon: NutritionInfo.nutrients['sugar']!.icon,
        color: NutritionInfo.nutrients['sugar']!.color,
        title: 'Sugar',
        description:
            'Amount of sugar (g) in the fruit. High sugar fruits are sweeter.',
      ),
      _IconInfo(
        icon: NutritionInfo.nutrients['carbohydrates']!.icon,
        color: NutritionInfo.nutrients['carbohydrates']!.color,
        title: 'Carbohydrates',
        description: 'Total carbohydrates (g), including sugars and fiber.',
      ),
      _IconInfo(
        icon: NutritionInfo.nutrients['protein']!.icon,
        color: NutritionInfo.nutrients['protein']!.color,
        title: 'Protein',
        description:
            'Protein (g) content. Important for body repair and growth.',
      ),
      _IconInfo(
        icon: NutritionInfo.nutrients['fat']!.icon,
        color: NutritionInfo.nutrients['fat']!.color,
        title: 'Fat',
        description: 'Fat (g) content. Most fruits are naturally low in fat.',
      ),
      _IconInfo(
        icon: NutritionInfo.nutrients['calories']!.icon,
        color: NutritionInfo.nutrients['calories']!.color,
        title: 'Calories',
        description: 'Energy provided by the fruit (kcal).',
      ),
      _IconInfo(
        icon: TaxonomyInfo.taxonomy['family']!.icon,
        color: TaxonomyInfo.taxonomy['family']!.color,
        title: 'Family',
        description: 'The botanical family this fruit belongs to.',
      ),
      _IconInfo(
        icon: TaxonomyInfo.taxonomy['genus']!.icon,
        color: TaxonomyInfo.taxonomy['genus']!.color,
        title: 'Genus',
        description: 'The genus classification of the fruit.',
      ),
      _IconInfo(
        icon: TaxonomyInfo.taxonomy['order']!.icon,
        color: TaxonomyInfo.taxonomy['order']!.color,
        title: 'Order',
        description: 'The order classification in plant taxonomy.',
      ),
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
  final ScrollController? scrollController; // Add scrollController

  const _FruitsBody({
    this.sort,
    this.onRefresh,
    this.onSortPressed,
    this.scrollController, // Add to constructor
  });

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
            return const Center(child: Text('No fruits available'));
          }

          // Calculate nutritional data using the imported function
          final analysisData = calculateFruitAnalysisData(sortedFruits);

          return RefreshIndicator(
            onRefresh: onRefresh ?? () async {},
            child: ListView(
              controller: scrollController, // Assign the controller
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
                      // Center(
                      //   child: Text(
                      //     'Fruit Nutrition Dashboard',
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .titleLarge
                      //         ?.copyWith(fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      // const Gap(24),

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
                ...List.generate(
                  sortedFruits.length,
                  (index) => FruitListTile(fruit: sortedFruits[index]),
                ),
              ],
            ),
          );
        }

        if (state is FruitsError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        return const Center(child: Text('No data available'));
      },
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
