import 'dart:math' show sqrt;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/constants/nutrition_constants.dart';
import '../../../../models/fruit_model.dart';

/// Widget for displaying nutritional overview cards in a horizontal list
class NutritionalOverviewSection extends StatelessWidget {
  final num avgCalories;
  final num avgProtein;
  final num avgSugar;
  final num avgCarbs;
  final int fruitCount;

  const NutritionalOverviewSection({
    super.key,
    required this.avgCalories,
    required this.avgProtein,
    required this.avgSugar,
    required this.avgCarbs,
    required this.fruitCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutritional Overview',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const Gap(12),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _NutritionSummaryCard(
                title: 'Avg. Calories',
                value: avgCalories.toStringAsFixed(0),
                icon: NutritionInfo.nutrients['calories']!.icon,
                color: NutritionInfo.nutrients['calories']!.color,
                subtitle: '$fruitCount fruits',
              ),
              _NutritionSummaryCard(
                title: 'Avg. Protein',
                value: '${avgProtein.toStringAsFixed(1)}g',
                icon: NutritionInfo.nutrients['protein']!.icon,
                color: NutritionInfo.nutrients['protein']!.color,
                subtitle: 'per fruit',
              ),
              _NutritionSummaryCard(
                title: 'Avg. Sugar',
                value: '${avgSugar.toStringAsFixed(1)}g',
                icon: NutritionInfo.nutrients['sugar']!.icon,
                color: NutritionInfo.nutrients['sugar']!.color,
                subtitle: 'per fruit',
              ),
              _NutritionSummaryCard(
                title: 'Avg. Carbs',
                value: '${avgCarbs.toStringAsFixed(1)}g',
                icon: NutritionInfo.nutrients['carbohydrates']!.icon,
                color: NutritionInfo.nutrients['carbohydrates']!.color,
                subtitle: 'per fruit',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Card for displaying a summary of a particular nutritional value
class _NutritionSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String subtitle;

  const _NutritionSummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(right: 12, bottom: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.3), width: 1),
      ),
      child: Container(
        width: 130,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 16),
                const Gap(6),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Gap(2),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.matrixSilver,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget for displaying bar chart of average nutritional content
class NutritionalBarChartSection extends StatelessWidget {
  final num avgSugar;
  final num avgCarbs;
  final num avgProtein;
  final num avgFat;

  const NutritionalBarChartSection({
    super.key,
    required this.avgSugar,
    required this.avgCarbs,
    required this.avgProtein,
    required this.avgFat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Average Nutritional Content',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const Gap(12),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.nightShade.withOpacity(0.04),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceBetween,
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                      toY: avgSugar.toDouble(),
                      color: NutritionInfo.nutrients['sugar']!.color,
                      width: 20,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      toY: avgCarbs.toDouble(),
                      color: NutritionInfo.nutrients['carbohydrates']!.color,
                      width: 20,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                      toY: avgProtein.toDouble(),
                      color: NutritionInfo.nutrients['protein']!.color,
                      width: 20,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(
                      toY: avgFat.toDouble(),
                      color: NutritionInfo.nutrients['fat']!.color,
                      width: 20,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      String text = '';
                      switch (value.toInt()) {
                        case 0:
                          text = 'Sugar';
                          break;
                        case 1:
                          text = 'Carbs';
                          break;
                        case 2:
                          text = 'Protein';
                          break;
                        case 3:
                          text = 'Fat';
                          break;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget for displaying notable fruits section
class NotableFruitsSection extends StatelessWidget {
  final Fruit highestCaloriesFruit;
  final Fruit highestProteinFruit;
  final Fruit highestSugarFruit;
  final Fruit lowestCaloriesFruit;

  const NotableFruitsSection({
    super.key,
    required this.highestCaloriesFruit,
    required this.highestProteinFruit,
    required this.highestSugarFruit,
    required this.lowestCaloriesFruit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notable Fruits',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: NotableFruitCard(
                fruit: highestCaloriesFruit,
                title: 'Highest Calories',
                icon: NutritionInfo.nutrients['calories']!.icon,
                color: NutritionInfo.nutrients['calories']!.color,
                value: '${highestCaloriesFruit.nutritions.calories} kcal',
              ),
            ),
            const Gap(12),
            Expanded(
              child: NotableFruitCard(
                fruit: highestProteinFruit,
                title: 'Highest Protein',
                icon: NutritionInfo.nutrients['protein']!.icon,
                color: NutritionInfo.nutrients['protein']!.color,
                value:
                    '${highestProteinFruit.nutritions.protein.toStringAsFixed(1)}g',
              ),
            ),
          ],
        ),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: NotableFruitCard(
                fruit: highestSugarFruit,
                title: 'Sweetest',
                icon: NutritionInfo.nutrients['sugar']!.icon,
                color: NutritionInfo.nutrients['sugar']!.color,
                value:
                    '${highestSugarFruit.nutritions.sugar.toStringAsFixed(1)}g sugar',
              ),
            ),
            const Gap(12),
            Expanded(
              child: NotableFruitCard(
                fruit: lowestCaloriesFruit,
                title: 'Lowest Calories',
                icon: Icons.local_fire_department_outlined,
                color: Colors.green,
                value: '${lowestCaloriesFruit.nutritions.calories} kcal',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Card displaying a notable fruit with its impressive stats
class NotableFruitCard extends StatelessWidget {
  final Fruit fruit;
  final String title;
  final IconData icon;
  final Color color;
  final String value;

  const NotableFruitCard({
    super.key,
    required this.fruit,
    required this.title,
    required this.icon,
    required this.color,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to fruit detail page using go_router
          context.push('/fruits/fruit-detail', extra: fruit);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 16),
                  const Gap(6),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const Gap(8),
              Text(
                fruit.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget for displaying nutritional comparison with customizable layout and fruit selection
class NutritionalRadarChartSection extends StatefulWidget {
  final List<Fruit> fruits;
  final List<String> selectedFruits;

  const NutritionalRadarChartSection({
    super.key,
    required this.fruits,
    required this.selectedFruits,
  });

  @override
  State<NutritionalRadarChartSection> createState() =>
      _NutritionalRadarChartSectionState();
}

class _NutritionalRadarChartSectionState
    extends State<NutritionalRadarChartSection> {
  // Use ValueNotifiers for reactive state
  late final ValueNotifier<bool> _isVerticalLayout;
  late final ValueNotifier<Fruit> _leftFruit;
  late final ValueNotifier<Fruit> _rightFruit;

  // Setup colors for fruits
  final colors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.amberAccent,
  ];

  @override
  void initState() {
    super.initState();

    // Initialize ValueNotifiers
    _isVerticalLayout = ValueNotifier<bool>(false);

    // Initialize selected fruits
    if (widget.fruits.length >= 2) {
      final firstFruit = widget.fruits.firstWhere(
          (fruit) => widget.selectedFruits.contains(fruit.name),
          orElse: () => widget.fruits[0]);

      final secondFruit = widget.fruits.firstWhere(
          (fruit) =>
              widget.selectedFruits.contains(fruit.name) &&
              fruit.name != firstFruit.name,
          orElse: () =>
              widget.fruits.length > 1 ? widget.fruits[1] : widget.fruits[0]);

      _leftFruit = ValueNotifier<Fruit>(firstFruit);
      _rightFruit = ValueNotifier<Fruit>(secondFruit);
    } else if (widget.fruits.isNotEmpty) {
      _leftFruit = ValueNotifier<Fruit>(widget.fruits.first);
      _rightFruit = ValueNotifier<Fruit>(widget.fruits.first);
    } else {
      throw Exception('Fruits list cannot be empty!');
    }
  }

  @override
  void dispose() {
    // Dispose all ValueNotifiers
    _isVerticalLayout.dispose();
    _leftFruit.dispose();
    _rightFruit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fruits.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nutritional Comparison',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Gap(4),
                  Text(
                    'Compare nutrients between any two fruits',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.matrixSilver,
                        ),
                  ),
                ],
              ),
            ),
            // Layout toggle button with ValueListenableBuilder
            ValueListenableBuilder<bool>(
              valueListenable: _isVerticalLayout,
              builder: (context, isVertical, _) {
                return IconButton(
                  icon:
                      Icon(isVertical ? Icons.view_agenda : Icons.view_column),
                  onPressed: () {
                    _isVerticalLayout.value = !isVertical;
                  },
                  tooltip: isVertical
                      ? 'Switch to side-by-side view'
                      : 'Switch to vertical view',
                );
              },
            ),
          ],
        ),
        const Gap(12),
        // Main content container with ValueListenableBuilder
        ValueListenableBuilder<bool>(
          valueListenable: _isVerticalLayout,
          builder: (context, isVertical, _) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.nightShade.withOpacity(0.04),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: isVertical
                  ? _buildVerticalComparisonView(context)
                  : _buildHorizontalComparisonView(context),
            );
          },
        ),
      ],
    );
  }

  // Build side-by-side comparison
  Widget _buildHorizontalComparisonView(BuildContext context) {
    return Column(
      children: [
        // Selection dropdowns for fruits
        Row(
          children: [
            Expanded(child: _buildFruitDropdown(true)),
            const Gap(12),
            Expanded(child: _buildFruitDropdown(false)),
          ],
        ),
        const Gap(16),

        // Header row with nutrient types
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              // Empty space for alignment
              const SizedBox(width: 90),

              // Nutrient labels
              ..._buildNutrientLabels(),
            ],
          ),
        ),

        // Fruit comparison rows
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nutrient names column
            SizedBox(
              width: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10), // For alignment
                  Text('Sugar', style: Theme.of(context).textTheme.bodySmall),
                  const Gap(12),
                  Text('Carbs', style: Theme.of(context).textTheme.bodySmall),
                  const Gap(12),
                  Text('Protein', style: Theme.of(context).textTheme.bodySmall),
                  const Gap(12),
                  Text('Fat', style: Theme.of(context).textTheme.bodySmall),
                  const Gap(12),
                  Text('Calories',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),

            // Left fruit values with ValueListenableBuilder
            Expanded(
              child: ValueListenableBuilder<Fruit>(
                  valueListenable: _leftFruit,
                  builder: (context, leftFruit, _) {
                    return _buildFruitValuesColumn(leftFruit, colors[0]);
                  }),
            ),

            // Right fruit values with ValueListenableBuilder
            Expanded(
              child: ValueListenableBuilder<Fruit>(
                  valueListenable: _rightFruit,
                  builder: (context, rightFruit, _) {
                    return _buildFruitValuesColumn(rightFruit, colors[1]);
                  }),
            ),
          ],
        ),
      ],
    );
  }

  // Build vertical comparison (one above the other)
  Widget _buildVerticalComparisonView(BuildContext context) {
    return Column(
      children: [
        // First fruit with ValueListenableBuilder
        ValueListenableBuilder<Fruit>(
          valueListenable: _leftFruit,
          builder: (context, leftFruit, _) {
            return _buildFruitRow(leftFruit, colors[0], true);
          },
        ),

        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Divider(),
        ),

        // Second fruit with ValueListenableBuilder
        ValueListenableBuilder<Fruit>(
          valueListenable: _rightFruit,
          builder: (context, rightFruit, _) {
            return _buildFruitRow(rightFruit, colors[1], false);
          },
        ),
      ],
    );
  }

  // Build a row with fruit selection and its nutrients
  Widget _buildFruitRow(Fruit fruit, Color color, bool isLeftFruit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFruitDropdown(isLeftFruit),
        const Gap(12),
        Row(
          children: [
            // Fruit indicator
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const Gap(8),
            Text(
              fruit.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const Gap(12),
        Row(
          children: [
            // Nutrient bars in a row
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                          width: 70,
                          child:
                              Text('Sugar:', style: TextStyle(fontSize: 12))),
                      Expanded(
                        child: _NutrientBar(
                          value: fruit.nutritions.sugar,
                          maxValue: 20,
                          color: NutritionInfo.nutrients['sugar']!.color,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      const SizedBox(
                          width: 70,
                          child:
                              Text('Carbs:', style: TextStyle(fontSize: 12))),
                      Expanded(
                        child: _NutrientBar(
                          value: fruit.nutritions.carbohydrates,
                          maxValue: 25,
                          color:
                              NutritionInfo.nutrients['carbohydrates']!.color,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      const SizedBox(
                          width: 70,
                          child:
                              Text('Protein:', style: TextStyle(fontSize: 12))),
                      Expanded(
                        child: _NutrientBar(
                          value: fruit.nutritions.protein,
                          maxValue: 5,
                          color: NutritionInfo.nutrients['protein']!.color,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      const SizedBox(
                          width: 70,
                          child: Text('Fat:', style: TextStyle(fontSize: 12))),
                      Expanded(
                        child: _NutrientBar(
                          value: fruit.nutritions.fat,
                          maxValue: 5,
                          color: NutritionInfo.nutrients['fat']!.color,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      const SizedBox(
                          width: 70,
                          child: Text('Calories:',
                              style: TextStyle(fontSize: 12))),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${fruit.nutritions.calories}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: NutritionInfo.nutrients['calories']!.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Build fruit selection dropdown using ValueListenableBuilder
  Widget _buildFruitDropdown(bool isLeftFruit) {
    final valueNotifier = isLeftFruit ? _leftFruit : _rightFruit;

    return ValueListenableBuilder<Fruit>(
      valueListenable: valueNotifier,
      builder: (context, selectedFruit, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.nightShade.withOpacity(0.3)
                : Colors.white,
          ),
          child: DropdownButton<Fruit>(
            value: selectedFruit,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            icon: const Icon(Icons.arrow_drop_down, size: 20),
            items: widget.fruits.map((Fruit fruit) {
              return DropdownMenuItem<Fruit>(
                value: fruit,
                child: Text(
                  fruit.name,
                  style: const TextStyle(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (Fruit? newValue) {
              if (newValue == null) return;
              valueNotifier.value = newValue;
            },
          ),
        );
      },
    );
  }

  // Build a list of nutrient label widgets
  List<Widget> _buildNutrientLabels() {
    return [
      Expanded(
        child: Center(
          child: _NutrientLabel(
            icon: NutritionInfo.nutrients['sugar']!.icon,
            color: NutritionInfo.nutrients['sugar']!.color,
            label: 'Sugar',
          ),
        ),
      ),
      Expanded(
        child: Center(
          child: _NutrientLabel(
            icon: NutritionInfo.nutrients['carbohydrates']!.icon,
            color: NutritionInfo.nutrients['carbohydrates']!.color,
            label: 'Carbs',
          ),
        ),
      ),
      Expanded(
        child: Center(
          child: _NutrientLabel(
            icon: NutritionInfo.nutrients['protein']!.icon,
            color: NutritionInfo.nutrients['protein']!.color,
            label: 'Protein',
          ),
        ),
      ),
    ];
  }

  // Build a column with fruit nutrient values
  Widget _buildFruitValuesColumn(Fruit fruit, Color color) {
    return Column(
      children: [
        // Fruit name
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const Gap(8),
            Expanded(
              child: Text(
                fruit.name,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const Gap(12),

        // Sugar value
        _NutrientBar(
          value: fruit.nutritions.sugar,
          maxValue: 20,
          color: NutritionInfo.nutrients['sugar']!.color,
        ),
        const Gap(12),

        // Carbs value
        _NutrientBar(
          value: fruit.nutritions.carbohydrates,
          maxValue: 25,
          color: NutritionInfo.nutrients['carbohydrates']!.color,
        ),
        const Gap(12),

        // Protein value
        _NutrientBar(
          value: fruit.nutritions.protein,
          maxValue: 5,
          color: NutritionInfo.nutrients['protein']!.color,
        ),
        const Gap(12),

        // Fat value
        _NutrientBar(
          value: fruit.nutritions.fat,
          maxValue: 5,
          color: NutritionInfo.nutrients['fat']!.color,
        ),
        const Gap(12),

        // Calories value
        Text(
          '${fruit.nutritions.calories} kcal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: NutritionInfo.nutrients['calories']!.color,
          ),
        ),
      ],
    );
  }
}

/// Nutrient label widget
class _NutrientLabel extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _NutrientLabel({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 16),
        const Gap(4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

/// Nutrient bar widget with value
class _NutrientBar extends StatelessWidget {
  final double value;
  final double maxValue;
  final Color color;

  const _NutrientBar({
    required this.value,
    required this.maxValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate percentage (capped at 100%)
    final percentage = (value / maxValue).clamp(0.0, 1.0);

    return Column(
      children: [
        Container(
          width: 60,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const Gap(2),
        Text(
          '${value.toStringAsFixed(1)}g',
          style: TextStyle(
            fontSize: 9,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// Widget for displaying taxonomy distribution in a bubble chart
class TaxonomyDistributionSection extends StatelessWidget {
  final List<Fruit> fruits;

  const TaxonomyDistributionSection({
    super.key,
    required this.fruits,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate family distribution
    final Map<String, int> familyCount = {};
    int totalFruits = 0;
    for (var fruit in fruits) {
      familyCount[fruit.family] = (familyCount[fruit.family] ?? 0) + 1;
      totalFruits++;
    }

    // Sort families by count descending
    final sortedFamilies = familyCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Take top 6 families for visualization
    final topFamilies = sortedFamilies.take(6).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Taxonomy Distribution',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const Gap(8),
        Text(
          'Most common fruit families in the database',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.matrixSilver,
              ),
        ),
        const Gap(12),
        Container(
          height: 220, // Increased height for better layout
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF1E1E2E) // Dark theme background
                : const Color(0xFFF8F8FB), // Light theme background
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120, // Fixed height for bubble area
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Pre-calculate positions to avoid overlaps
                    const positions = [
                      [0.1, 0.2], // left, center-top
                      [0.35, 0.5], // center-left
                      [0.6, 0.3], // center-right
                      [0.8, 0.6], // right, center-bottom
                      [0.25, 0.7], // left, bottom
                      [0.55, 0.65], // center, bottom
                    ];

                    return Stack(
                      children: List.generate(
                        topFamilies.length > positions.length
                            ? positions.length
                            : topFamilies.length,
                        (index) {
                          // Determine position and size based on count
                          final family = topFamilies[index];
                          final size =
                              _calculateBubbleSize(family.value, totalFruits);

                          // Use pre-calculated positions
                          final xPos = positions[index][0] *
                              (constraints.maxWidth - size);
                          final yPos = positions[index][1] *
                              (constraints.maxHeight - size);

                          // Get a color based on family name for consistency
                          final color = _getFamilyColor(family.key);

                          return Positioned(
                            left: xPos,
                            top: yPos,
                            child: Tooltip(
                              message: '${family.key}: ${family.value} fruits',
                              child: MaterialButton(
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                shape: const CircleBorder(),
                                minWidth: 0,
                                height: 0,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                child: Container(
                                  width: size,
                                  height: size,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: color.withOpacity(0.85),
                                    boxShadow: [
                                      BoxShadow(
                                        color: color.withOpacity(0.3),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    family.value.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size > 50 ? 14 : 12,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: topFamilies.map((family) {
                      final color = _getFamilyColor(family.key);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Chip(
                          avatar: CircleAvatar(
                            radius: 8,
                            backgroundColor: color,
                            child: Text(
                              family.value.toString(),
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          label: Text(
                            family.key,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          backgroundColor: Theme.of(context).brightness ==
                                  Brightness.dark
                              ? const Color(
                                  0xFF2D2D3F) // Darker background for dark mode
                              : Theme.of(context).cardColor,
                          side: BorderSide(color: color, width: 1),
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Calculate bubble size based on count and total with improved scaling
  double _calculateBubbleSize(int count, int total) {
    // Fixed sizes with smaller range for better proportionality
    const maxSize = 58.0;
    const minSize = 36.0;

    // Calculate ratio and use square root to make size differences more balanced
    final ratio = count / (total * 1.0);
    final adjustedRatio =
        sqrt(ratio); // Square root gives better visual scaling

    // Ensure minimum value for small counts
    return minSize +
        ((maxSize - minSize) * adjustedRatio).clamp(0.0, maxSize - minSize);
  } // Simple color selection based on family name

  Color _getFamilyColor(String family) {
    // Vivid colors with excellent contrast against white text
    final colors = [
      const Color(0xFF4E79A7), // Blue
      const Color(0xFFF28E2B), // Orange
      const Color(0xFFE15759), // Red
      const Color(0xFF76B7B2), // Teal
      const Color(0xFF59A14F), // Green
      const Color(0xFFEDC948), // Yellow
      const Color(0xFFB07AA1), // Purple
      const Color(0xFFFF9DA7), // Pink
      const Color(0xFF9C755F), // Brown
      const Color(0xFFBAB0AC), // Gray
      const Color(0xFF8CD17D), // Light green
      const Color(0xFFB6992D), // Olive
      const Color(0xFFF1CE63), // Light yellow
      const Color(0xFF499894), // Dark teal
      const Color(0xFFD37295), // Rose
    ];

    // Use the name length as a simple way to get a consistent but "random" color
    // This will always give the same color for the same family name
    final colorIndex = (family.length + family.codeUnitAt(0)) % colors.length;

    return colors[colorIndex];
  }
}
