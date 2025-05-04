import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  static const LinearGradient cyberHorizon = LinearGradient(
    colors: [AppColors.nightShade, AppColors.techNavy],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient neuroPortal = LinearGradient(
    colors: [AppColors.cyberpunkPurple, AppColors.midnightBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient synthwaveEnergy = LinearGradient(
    colors: [AppColors.syntheticIndigo, AppColors.cyborgPurple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient neonDream = LinearGradient(
    colors: [AppColors.neonBlue, AppColors.neonAqua],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
