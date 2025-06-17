import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/nutrition_constants.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../data/models/fruit_model.dart';

class NutritionalComparisonSection extends StatefulWidget {
  final List<Fruit> fruits;
  final List<String> selectedFruits;

  const NutritionalComparisonSection({
    super.key,
    required this.fruits,
    required this.selectedFruits,
  });

  @override
  State<NutritionalComparisonSection> createState() =>
      _NutritionalComparisonSectionState();
}

class _NutritionalComparisonSectionState
    extends State<NutritionalComparisonSection> {
  late final ValueNotifier<bool> _isVerticalLayout;
  late final ValueNotifier<Fruit> _leftFruit;
  late final ValueNotifier<Fruit> _rightFruit;

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
    _isVerticalLayout = ValueNotifier<bool>(false);
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
                    style: AppTextStyles.w700p16,
                  ),
                  const Gap(4),
                  Text(
                    'Compare nutrients between any two fruits',
                    style: AppTextStyles.w400p12.copyWith(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ],
              ),
            ),
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
        ValueListenableBuilder<bool>(
          valueListenable: _isVerticalLayout,
          builder: (context, isVertical, _) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.04),
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

  Widget _buildHorizontalComparisonView(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildFruitDropdown(true)),
            const Gap(12),
            Expanded(child: _buildFruitDropdown(false)),
          ],
        ),
        const Gap(16),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              const Gap(90),
              ..._buildNutrientLabels(),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  Text('Sugar', style: AppTextStyles.w400p12),
                  const Gap(12),
                  Text('Carbs', style: AppTextStyles.w400p12),
                  const Gap(12),
                  Text('Protein', style: AppTextStyles.w400p12),
                  const Gap(12),
                  Text('Fat', style: AppTextStyles.w400p12),
                  const Gap(12),
                  Text('Calories', style: AppTextStyles.w400p12),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<Fruit>(
                  valueListenable: _leftFruit,
                  builder: (context, leftFruit, _) {
                    return _buildFruitValuesColumn(leftFruit, colors[0]);
                  }),
            ),
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

  Widget _buildVerticalComparisonView(BuildContext context) {
    return Column(
      children: [
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
        ValueListenableBuilder<Fruit>(
          valueListenable: _rightFruit,
          builder: (context, rightFruit, _) {
            return _buildFruitRow(rightFruit, colors[1], false);
          },
        ),
      ],
    );
  }

  Widget _buildFruitRow(Fruit fruit, Color color, bool isLeftFruit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFruitDropdown(isLeftFruit),
        const Gap(12),
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
            Text(
              fruit.name,
              style: AppTextStyles.w600p14,
            ),
          ],
        ),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 70,
                          child: Text('Sugar:', style: AppTextStyles.w400p12)),
                      Expanded(
                        child: _NutrientBar(
                          value: fruit.nutritions.sugar,
                          maxValue: 20,
                          color: NutritionConstants.nutrients['sugar']!.color,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      SizedBox(
                          width: 70,
                          child: Text('Carbs:', style: AppTextStyles.w400p12)),
                      Expanded(
                        child: _NutrientBar(
                          value: fruit.nutritions.carbohydrates,
                          maxValue: 25,
                          color: NutritionConstants
                              .nutrients['carbohydrates']!.color,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      SizedBox(
                          width: 70,
                          child:
                              Text('Protein:', style: AppTextStyles.w400p12)),
                      Expanded(
                        child: _NutrientBar(
                          value: fruit.nutritions.protein,
                          maxValue: 5,
                          color: NutritionConstants.nutrients['protein']!.color,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      SizedBox(
                          width: 70,
                          child: Text('Fat:', style: AppTextStyles.w400p12)),
                      Expanded(
                        child: _NutrientBar(
                          value: fruit.nutritions.fat,
                          maxValue: 5,
                          color: NutritionConstants.nutrients['fat']!.color,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      SizedBox(
                          width: 70,
                          child:
                              Text('Calories:', style: AppTextStyles.w400p12)),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${fruit.nutritions.calories}',
                          style: AppTextStyles.w700p12.copyWith(
                            color:
                                NutritionConstants.nutrients['calories']!.color,
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

  Widget _buildFruitDropdown(bool isLeftFruit) {
    final valueNotifier = isLeftFruit ? _leftFruit : _rightFruit;
    return ValueListenableBuilder<Fruit>(
      valueListenable: valueNotifier,
      builder: (context, selectedFruit, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
            color: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).colorScheme.surface.withOpacity(0.3)
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
                  style: AppTextStyles.w400p12,
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

  List<Widget> _buildNutrientLabels() {
    return [
      Expanded(
        child: Center(
          child: _NutrientLabel(
            icon: NutritionConstants.nutrients['sugar']!.icon,
            color: NutritionConstants.nutrients['sugar']!.color,
            label: 'Sugar',
          ),
        ),
      ),
      Expanded(
        child: Center(
          child: _NutrientLabel(
            icon: NutritionConstants.nutrients['carbohydrates']!.icon,
            color: NutritionConstants.nutrients['carbohydrates']!.color,
            label: 'Carbs',
          ),
        ),
      ),
      Expanded(
        child: Center(
          child: _NutrientLabel(
            icon: NutritionConstants.nutrients['protein']!.icon,
            color: NutritionConstants.nutrients['protein']!.color,
            label: 'Protein',
          ),
        ),
      ),
    ];
  }

  Widget _buildFruitValuesColumn(Fruit fruit, Color color) {
    return Column(
      children: [
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
                style: AppTextStyles.w600p12,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const Gap(12),
        _NutrientBar(
          value: fruit.nutritions.sugar,
          maxValue: 20,
          color: NutritionConstants.nutrients['sugar']!.color,
        ),
        const Gap(12),
        _NutrientBar(
          value: fruit.nutritions.carbohydrates,
          maxValue: 25,
          color: NutritionConstants.nutrients['carbohydrates']!.color,
        ),
        const Gap(12),
        _NutrientBar(
          value: fruit.nutritions.protein,
          maxValue: 5,
          color: NutritionConstants.nutrients['protein']!.color,
        ),
        const Gap(12),
        _NutrientBar(
          value: fruit.nutritions.fat,
          maxValue: 5,
          color: NutritionConstants.nutrients['fat']!.color,
        ),
        const Gap(12),
        Text(
          '${fruit.nutritions.calories} kcal',
          style: AppTextStyles.w700p12.copyWith(
            color: NutritionConstants.nutrients['calories']!.color,
          ),
        ),
      ],
    );
  }
}

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
          style: AppTextStyles.w700p10.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }
}

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
    final percentage = (value / maxValue).clamp(0.0, 1.0);

    return Column(
      children: [
        Container(
          width: 60,
          height: 8,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
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
          style: AppTextStyles.w700p10.copyWith(
            fontSize: 9,
            color: color,
          ),
        ),
      ],
    );
  }
}
