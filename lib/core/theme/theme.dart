import 'package:flutter/material.dart';
import 'package:news_c18_dokki/core/theme/app_colors.dart';

class AppTheme {
  AppColors colors;

  AppTheme(this.colors);

  ThemeData get theme => ThemeData(
    colorScheme: ColorScheme(
      brightness: colors.brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      secondary: colors.secondary,
      onSecondary: colors.onSecondary,
      error: colors.error,
      onError: colors.onError,
      surface: colors.surface,
      onSurface: colors.onSurface,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: colors.primary),
      bodyMedium: TextStyle(fontSize: 14, color: colors.primary),
      bodySmall: TextStyle(fontSize: 12, color: colors.primary),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: colors.primary,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: colors.primary,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: colors.primary,
      ),
    ),
  );
}
