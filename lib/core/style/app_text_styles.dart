import 'package:flutter/material.dart';
import 'style.dart';

/// Contains all text styles used in the app
/// Naming convention: w{weight}p{size}
/// Example: w600p12 means weight 600, text size 12
class AppTextStyles {
  // Base style with default color
  static const TextStyle _baseStyle = TextStyle(
    color: AppColors.hologramWhite,
  );

  static final TextStyle w700p24 = _baseStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  // Regular weight (w400) text styles
  static final TextStyle w400p10 = _baseStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle w400p12 = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle w400p14 = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle w400p16 = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle w400p18 = _baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle w400p20 = _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  // Medium weight (w500) text styles
  static final TextStyle w500p10 = _baseStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle w500p12 = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle w500p14 = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle w500p16 = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle w500p18 = _baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle w500p20 = _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  // Semi-bold weight (w600) text styles
  static final TextStyle w600p10 = _baseStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle w600p12 = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle w600p14 = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle w600p16 = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle w600p18 = _baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle w600p20 = _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  // Bold weight (w700) text styles
  static final TextStyle w700p10 = _baseStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle w700p12 = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle w700p14 = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle w700p16 = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle w700p18 = _baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle w700p20 = _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  // Extra Bold weight (w800) text styles for headings
  static final TextStyle w800p22 = _baseStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle w800p24 = _baseStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle w800p28 = _baseStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle w800p32 = _baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w800,
  );

  // Larger sizes for display text
  static final TextStyle w700p36 = _baseStyle.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle w700p48 = _baseStyle.copyWith(
    fontSize: 48,
    fontWeight: FontWeight.w700,
  );

  // Special text styles
  static final TextStyle caption = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.ghostBlue,
    letterSpacing: 0.4,
  );

  static final TextStyle button = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
    height: 1.5,
  );

  static final TextStyle overline = _baseStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.matrixSilver,
    letterSpacing: 1.5,
    textBaseline: TextBaseline.alphabetic,
  );

  static final TextStyle link = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.neonAqua,
    decoration: TextDecoration.underline,
  );
}
