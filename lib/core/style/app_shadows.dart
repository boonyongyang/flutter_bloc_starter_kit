import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppShadows {
  static List<BoxShadow> subtle = [
    BoxShadow(
      color: AppColors.nightShade.withOpacity(0.3),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> neonGlow = [
    BoxShadow(
      color: AppColors.neonAqua.withOpacity(0.3),
      blurRadius: 8,
      spreadRadius: 1,
      offset: const Offset(0, 3),
    ),
  ];

  static List<BoxShadow> purpleGlow = [
    BoxShadow(
      color: AppColors.cyborgPurple.withOpacity(0.4),
      blurRadius: 10,
      spreadRadius: 1,
      offset: const Offset(0, 3),
    ),
  ];
}
