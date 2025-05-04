import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../blocs/fruits_cubit.dart';
import '../../../../core/constants/nutrition_constants.dart';
import '../widgets/dashboard_widgets.dart';
import '../widgets/fruit_list_tile.dart';

enum FruitSort {
  name('Name (A-Z)'),
  sugar('Sugar (High to Low)'),
  sugarLow('Sugar (Low to High)'),
  protein('Protein (High to Low)'),
  fat('Fat (High to Low)'),
  calories('Calories (High to Low)');

  final String label;
  const FruitSort(this.label);

  int compare(dynamic a, dynamic b) {
    switch (this) {
      case FruitSort.name:
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      case FruitSort.sugar:
        return b.nutritions.sugar.compareTo(a.nutritions.sugar);
      case FruitSort.sugarLow:
        return a.nutritions.sugar.compareTo(b.nutritions.sugar);
      case FruitSort.protein:
        return b.nutritions.protein.compareTo(a.nutritions.protein);
      case FruitSort.fat:
        return b.nutritions.fat.compareTo(a.nutritions.fat);
      case FruitSort.calories:
        return b.nutritions.calories.compareTo(a.nutritions.calories);
    }
  }
}

class FruitsPage extends StatefulWidget {
  const FruitsPage({super.key});

  @override
  State<FruitsPage> createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage> {
  final ValueNotifier<FruitSort> _selectedSort =
      ValueNotifier(FruitSort.calories);

  @override
  void initState() {
    super.initState();
    // context.read<FruitsCubit>().fetchFruits(); // not required, as it's provided by parent
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
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSortSheet,
        tooltip: 'Sort',
        child: const Icon(Icons.sort),
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
  const _FruitsBody({this.sort, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FruitsCubit, FruitsState>(
      builder: (context, state) {
        if (state is FruitsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FruitsLoaded) {
          final FruitSort effectiveSort = sort ?? FruitSort.name;
          final sortedFruits = [...state.fruits]..sort(effectiveSort.compare);
          if (sortedFruits.isEmpty) {
            return const Center(child: Text('No fruits available'));
          }

          // --- Calculate nutritional averages and find extremes ---
          double totalSugar = 0,
              totalCarbs = 0,
              totalProtein = 0,
              totalFat = 0,
              totalCalories = 0;
          var highestCaloriesFruit = sortedFruits.first;
          var highestProteinFruit = sortedFruits.first;
          var highestSugarFruit = sortedFruits.first;
          var lowestCaloriesFruit = sortedFruits.first;

          for (final fruit in sortedFruits) {
            totalSugar += fruit.nutritions.sugar;
            totalCarbs += fruit.nutritions.carbohydrates;
            totalProtein += fruit.nutritions.protein;
            totalFat += fruit.nutritions.fat;
            totalCalories += fruit.nutritions.calories;

            if (fruit.nutritions.calories >
                highestCaloriesFruit.nutritions.calories) {
              highestCaloriesFruit = fruit;
            }
            if (fruit.nutritions.protein >
                highestProteinFruit.nutritions.protein) {
              highestProteinFruit = fruit;
            }
            if (fruit.nutritions.sugar > highestSugarFruit.nutritions.sugar) {
              highestSugarFruit = fruit;
            }
            if (fruit.nutritions.calories <
                lowestCaloriesFruit.nutritions.calories) {
              lowestCaloriesFruit = fruit;
            }
          }

          final fruitCount = sortedFruits.length;
          final avgSugar = fruitCount > 0 ? totalSugar / fruitCount : 0;
          final avgCarbs = fruitCount > 0 ? totalCarbs / fruitCount : 0;
          final avgProtein = fruitCount > 0 ? totalProtein / fruitCount : 0;
          final avgFat = fruitCount > 0 ? totalFat / fruitCount : 0;
          final avgCalories = fruitCount > 0 ? totalCalories / fruitCount : 0;

          // --- Modern dashboard layout ---
          return RefreshIndicator(
            onRefresh: onRefresh ?? () async {},
            child: ListView(
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
                        avgCalories: avgCalories,
                        avgProtein: avgProtein,
                        avgSugar: avgSugar,
                        avgCarbs: avgCarbs,
                        fruitCount: sortedFruits.length,
                      ),

                      const Gap(24),

                      // Bar chart comparing average nutrient values
                      NutritionalBarChartSection(
                        avgSugar: avgSugar,
                        avgCarbs: avgCarbs,
                        avgProtein: avgProtein,
                        avgFat: avgFat,
                      ),

                      const Gap(24),

                      // NEW: Taxonomy distribution bubble chart
                      TaxonomyDistributionSection(
                        fruits: sortedFruits,
                      ),

                      const Gap(24),

                      // Notable fruits section
                      NotableFruitsSection(
                        highestCaloriesFruit: highestCaloriesFruit,
                        highestProteinFruit: highestProteinFruit,
                        highestSugarFruit: highestSugarFruit,
                        lowestCaloriesFruit: lowestCaloriesFruit,
                      ),

                      const Gap(24),

                      // NEW: Nutritional radar chart comparison
                      NutritionalRadarChartSection(
                        fruits: sortedFruits,
                        selectedFruits: [
                          highestCaloriesFruit.name,
                          highestProteinFruit.name,
                          highestSugarFruit.name
                        ],
                      ),

                      const Gap(16),

                      // List header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
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
                            const Spacer(),
                            Text(
                              '${sortedFruits.length} items',
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
