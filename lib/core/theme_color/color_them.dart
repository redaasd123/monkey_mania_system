import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.lightPrimary,
    colorScheme: ColorScheme.light(
      background: AppColors.lightBackground,
      primary: AppColors.lightPrimary,
      onPrimary: Colors.white,
      secondary: AppColors.lightSecondary,
      onSecondary: Colors.white,
      error: AppColors.lightError,
      onError: Colors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightText,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.lightText),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurface,
      hintStyle: const TextStyle(color: AppColors.lightHint),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.lightPrimary),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.darkPrimary,
    colorScheme: ColorScheme.dark(
      background: AppColors.darkBackground,
      primary: AppColors.darkPrimary,
      onPrimary: Colors.white,
      secondary: AppColors.darkSecondary,
      onSecondary: Colors.white,
      error: AppColors.darkError,
      onError: Colors.black,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkText,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.darkText),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkCard,
      hintStyle: const TextStyle(color: AppColors.darkHint),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkPrimary),
      ),
    ),
  );
}
