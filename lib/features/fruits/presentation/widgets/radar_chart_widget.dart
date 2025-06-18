import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';

class MacroNutrientRadarChart extends StatefulWidget {
  final List<double> macroValues;
  final List<String> macroLabels;

  const MacroNutrientRadarChart({
    super.key,
    required this.macroValues,
    required this.macroLabels,
  });

  @override
  State<MacroNutrientRadarChart> createState() =>
      _MacroNutrientRadarChartState();
}

class _MacroNutrientRadarChartState extends State<MacroNutrientRadarChart> {
  int _tickCount = 3;
  RadarShape _radarShape = RadarShape.circle;
  final double _titlePositionOffset = 0.7;
  final double _labelRotation = 0.0;
  int? touchedIndex;

  // Helper method to ensure minimum data for radar chart
  List<double> get _safeValues {
    if (widget.macroValues.isEmpty) {
      return [0.0, 0.0, 0.0]; // Minimum 3 values required by fl_chart
    }
    if (widget.macroValues.length < 3) {
      final values = List<double>.from(widget.macroValues);
      while (values.length < 3) {
        values.add(0.0);
      }
      return values;
    }
    return widget.macroValues;
  }

  List<String> get _safeLabels {
    if (widget.macroLabels.isEmpty) {
      return ['Value 1', 'Value 2', 'Value 3']; // Default labels
    }
    if (widget.macroLabels.length < 3) {
      final labels = List<String>.from(widget.macroLabels);
      int count = labels.length + 1;
      while (labels.length < 3) {
        labels.add('Value $count');
        count++;
      }
      return labels;
    }
    return widget.macroLabels;
  }

  void _handleRadarTouch(RadarTouchResponse? response) {
    if (response == null || response.touchedSpot == null) {
      setState(() {
        touchedIndex = null;
      });
      return;
    }
    setState(() {
      touchedIndex = response.touchedSpot!.touchedRadarEntryIndex;
    });
  }

  void _toggleRadarShape() {
    setState(() {
      _radarShape = _radarShape == RadarShape.polygon
          ? RadarShape.circle
          : RadarShape.polygon;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tickStyle = AppTextStyles.w600p12.copyWith(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
    );

    final safeValues = _safeValues;
    final safeLabels = _safeLabels;

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                height: 220,
                width: 220,
                child: safeValues.isNotEmpty && safeValues.length >= 3
                    ? RadarChart(
                        RadarChartData(
                          radarShape: _radarShape,
                          radarBackgroundColor: Colors.transparent,
                          dataSets: [
                            RadarDataSet(
                              fillColor: AppColors.neonAqua.withOpacity(0.18),
                              borderColor: AppColors.neonAqua,
                              entryRadius: 7,
                              borderWidth: 4,
                              dataEntries: safeValues
                                  .map((value) => RadarEntry(value: value))
                                  .toList(),
                            ),
                          ],
                          radarBorderData: BorderSide(
                            color: _radarShape == RadarShape.polygon
                                ? AppColors.neonBlue
                                : AppColors.cyberpunkPurple,
                            width: 2.5,
                          ),
                          titleTextStyle: AppTextStyles.w700p16.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            letterSpacing: 1.2,
                          ),
                          getTitle: (index, angle) {
                            return RadarChartTitle(
                              text: index < safeLabels.length
                                  ? safeLabels[index]
                                  : 'Value ${index + 1}',
                              angle: _labelRotation,
                              positionPercentageOffset: _titlePositionOffset,
                            );
                          },
                          titlePositionPercentageOffset: _titlePositionOffset,
                          tickCount: _tickCount,
                          ticksTextStyle: tickStyle,
                          gridBorderData: BorderSide(
                            color: _radarShape == RadarShape.polygon
                                ? AppColors.matrixSilver
                                : AppColors.digitalTeal,
                            width: 1.5,
                          ),
                          tickBorderData: const BorderSide(
                              color: AppColors.digitalTeal, width: 1),
                          radarTouchData: RadarTouchData(
                            enabled: true,
                            touchCallback: (event, response) {
                              _handleRadarTouch(response);
                            },
                            touchSpotThreshold: 18,
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          'No data available',
                          style: AppTextStyles.w400p14.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                        ),
                      ),
              ),
              if (touchedIndex != null &&
                  touchedIndex! < safeLabels.length &&
                  touchedIndex! < safeValues.length)
                Positioned(
                  top: 30,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          safeLabels[touchedIndex!],
                          style: AppTextStyles.w700p12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          '${safeValues[touchedIndex!].toStringAsFixed(1)}g',
                          style: AppTextStyles.w400p12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const Gap(28),
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  'Chart Configuration',
                  style: AppTextStyles.w600p12.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Chart shape selector
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.techNavy.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Shape:',
                          style: AppTextStyles.w400p12.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                          ),
                        ),
                        const Gap(8),
                        GestureDetector(
                          onTap: _toggleRadarShape,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: _radarShape == RadarShape.circle
                                  ? AppColors.cyberpunkPurple.withOpacity(0.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: _radarShape == RadarShape.circle
                                    ? AppColors.cyberpunkPurple
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.circle_outlined,
                              size: 18,
                              color: AppColors.cyberpunkPurple,
                            ),
                          ),
                        ),
                        const Gap(6),
                        GestureDetector(
                          onTap: _toggleRadarShape,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: _radarShape == RadarShape.polygon
                                  ? AppColors.neonBlue.withOpacity(0.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: _radarShape == RadarShape.polygon
                                    ? AppColors.neonBlue
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.hexagon_outlined,
                              size: 18,
                              color: AppColors.neonBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tick count control
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.techNavy.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Ticks:',
                          style: AppTextStyles.w400p12.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                          ),
                        ),
                        const Gap(8),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (_tickCount > 3) _tickCount--;
                            });
                          },
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: _tickCount > 3
                                  ? AppColors.digitalTeal.withOpacity(0.2)
                                  : AppColors.techNavy.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 16,
                              color: _tickCount > 3
                                  ? AppColors.digitalTeal
                                  : AppColors.matrixSilver.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.digitalTeal.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '$_tickCount',
                            style: AppTextStyles.w600p12.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (_tickCount < 7) _tickCount++;
                            });
                          },
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: _tickCount < 7
                                  ? AppColors.digitalTeal.withOpacity(0.2)
                                  : AppColors.techNavy.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: _tickCount < 7
                                  ? AppColors.digitalTeal
                                  : AppColors.matrixSilver.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
