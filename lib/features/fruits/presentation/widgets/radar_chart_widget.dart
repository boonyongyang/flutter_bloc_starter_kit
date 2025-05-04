import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';

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
    final tickStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.matrixSilver,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        );

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.nightShade.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonBlue.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                height: 220,
                width: 220,
                child: RadarChart(
                  RadarChartData(
                    radarShape: _radarShape,
                    radarBackgroundColor: Colors.transparent,
                    dataSets: [
                      RadarDataSet(
                        fillColor: AppColors.neonAqua.withOpacity(0.18),
                        borderColor: AppColors.neonAqua,
                        entryRadius: 7,
                        borderWidth: 4,
                        dataEntries: widget.macroValues
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
                    titleTextStyle:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.neonAqua,
                              letterSpacing: 1.2,
                            ),
                    getTitle: (index, angle) {
                      return RadarChartTitle(
                        text: widget.macroLabels[index],
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
                ),
              ),
              if (touchedIndex != null)
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
                          widget.macroLabels[touchedIndex!],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${widget.macroValues[touchedIndex!].toStringAsFixed(1)}g',
                          style: const TextStyle(
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
        const SizedBox(height: 28),
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.nightShade.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.matrixSilver.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  'Chart Configuration',
                  style: TextStyle(
                    color: AppColors.ghostBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
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
                        const Text(
                          'Shape:',
                          style: TextStyle(
                            color: AppColors.ghostBlue,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
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
                        const SizedBox(width: 6),
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
                        const Text(
                          'Ticks:',
                          style: TextStyle(
                            color: AppColors.ghostBlue,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
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
                            style: const TextStyle(
                              color: AppColors.digitalTeal,
                              fontWeight: FontWeight.w600,
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
