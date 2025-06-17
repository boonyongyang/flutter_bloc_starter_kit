import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/constants/nutrition_constants.dart';

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
          style: AppTextStyles.w700p18,
        ),
        const Gap(12),
        Container(
          height: 160,
          decoration: BoxDecoration(
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
                      color: NutritionConstants.nutrients['sugar']!.color,
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
                      color:
                          NutritionConstants.nutrients['carbohydrates']!.color,
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
                      color: NutritionConstants.nutrients['protein']!.color,
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
                      color: NutritionConstants.nutrients['fat']!.color,
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
                          style: AppTextStyles.w700p10.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
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
