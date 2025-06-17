import 'package:flutter/material.dart';

/// Animation durations and curves
class AnimationConstants {
  // Durations
  static const Duration shortDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 400);
  static const Duration longDuration = Duration(milliseconds: 800);
  static const Duration extraLongDuration = Duration(milliseconds: 2400);

  // Curves
  static const Curve defaultEasing = Curves.easeOutQuart;
  static const Curve smoothEasing = Curves.easeInOutCubic;
  static const Curve bounceEasing = Curves.elasticOut;
  static const Curve customEasing = Cubic(0.23, 0.86, 0.39, 0.96);
  static const Curve softEasing = Cubic(0.4, 0.0, 0.2, 1.0);

  AnimationConstants._();
}
