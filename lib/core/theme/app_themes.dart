import 'package:flutter/material.dart';
import '../style/app_colors.dart';
import '../style/app_text_styles.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.cyberpunkPurple,
    scaffoldBackgroundColor: AppColors.hologramWhite,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.cyberpunkPurple,
      foregroundColor: AppColors.hologramWhite,
      titleTextStyle:
          AppTextStyles.w700p20.copyWith(color: AppColors.hologramWhite),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.cyberpunkPurple,
      onPrimary: AppColors.hologramWhite,
      secondary: AppColors.neonAqua,
      onSecondary: AppColors.hologramWhite,
      surface: AppColors.hologramWhite,
      onSurface: AppColors.shadowBlack,
      tertiary: AppColors.neonBlue,
      onTertiary: AppColors.hologramWhite,
      error: AppColors.errorRed,
      onError: AppColors.hologramWhite,
      outline: AppColors.matrixSilver,
      surfaceContainerHighest: AppColors.matrixSilver,
      onSurfaceVariant: AppColors.shadowBlack,
    ),
    textTheme: TextTheme(
      headlineLarge:
          AppTextStyles.w800p32.copyWith(color: AppColors.shadowBlack),
      titleLarge: AppTextStyles.w700p20.copyWith(color: AppColors.shadowBlack),
      bodyLarge: AppTextStyles.w400p16.copyWith(color: AppColors.shadowBlack),
      bodyMedium: AppTextStyles.w400p14.copyWith(color: AppColors.shadowBlack),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.shadowBlack,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.cyberpunkPurple,
    scaffoldBackgroundColor: AppColors.nightShade,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.nightShade,
      foregroundColor: AppColors.hologramWhite,
      titleTextStyle:
          AppTextStyles.w700p20.copyWith(color: AppColors.hologramWhite),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.cyberpunkPurple,
      onPrimary: AppColors.hologramWhite,
      secondary: AppColors.neonAqua,
      onSecondary: AppColors.hologramWhite,
      surface: AppColors.nightShade,
      onSurface: AppColors.hologramWhite,
      tertiary: AppColors.neonBlue,
      onTertiary: AppColors.hologramWhite,
      error: AppColors.errorRed,
      onError: AppColors.hologramWhite,
      outline: AppColors.matrixSilver,
      surfaceContainerHighest: AppColors.matrixSilver,
      onSurfaceVariant: AppColors.hologramWhite,
    ),
    textTheme: TextTheme(
      headlineLarge: AppTextStyles.w800p32.copyWith(
        color: AppColors.hologramWhite,
      ),
      titleLarge: AppTextStyles.w700p20.copyWith(
        color: AppColors.hologramWhite,
      ),
      bodyLarge: AppTextStyles.w400p16.copyWith(color: AppColors.hologramWhite),
      bodyMedium:
          AppTextStyles.w400p14.copyWith(color: AppColors.hologramWhite),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.hologramWhite,
    ),
  );
}
