import 'dart:math' show sqrt;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/style/app_colors.dart';
import '../../models/fruit_model.dart';

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
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
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
