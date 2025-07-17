// lib/core/theme/app_theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme_colors.dart';
import 'theme_typography.dart';
import 'theme_components.dart';

/// Modern, minimal app theme following Material Design 3 principles.
/// This class provides a consistent theme for both light and dark modes,
/// based on a custom color scheme and typography.
class AppTheme {
  AppTheme._();

  // === Design Tokens ===

  // Spacing (8pt grid system)
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;
  static const double spaceXxl = 48.0;

  // Border radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;

  // Elevations
  static const double elevationXs = 1.0;
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;

  // Icon sizes
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  // === Primary Font ===
  static const String fontFamily = 'PlusJakartaSans';

  // === Light Theme ===
  static ThemeData get lightTheme {
    final colorScheme = ThemeColors.lightColorScheme;
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: ThemeTypography.getTextTheme(colorScheme),
      
      // Component themes
      appBarTheme: ThemeComponents.getAppBarTheme(colorScheme, false),
      cardTheme: ThemeComponents.getCardTheme(colorScheme, false),
      elevatedButtonTheme: ThemeComponents.getElevatedButtonTheme(colorScheme, false),
      outlinedButtonTheme: ThemeComponents.getOutlinedButtonTheme(colorScheme, false),
      textButtonTheme: ThemeComponents.getTextButtonTheme(colorScheme, false),
      floatingActionButtonTheme: ThemeComponents.getFloatingActionButtonTheme(colorScheme, false),
      inputDecorationTheme: ThemeComponents.getInputDecorationTheme(colorScheme, false),
      listTileTheme: ThemeComponents.getListTileTheme(colorScheme, false),
      bottomNavigationBarTheme: ThemeComponents.getBottomNavigationBarTheme(colorScheme, false),
      dialogTheme: ThemeComponents.getDialogTheme(colorScheme, false),
      chipTheme: ThemeComponents.getChipTheme(colorScheme, false),
      tabBarTheme: ThemeComponents.getTabBarTheme(colorScheme, false),
      dividerTheme: ThemeComponents.getDividerTheme(colorScheme, false),
      iconTheme: ThemeComponents.getIconTheme(colorScheme, false),
      primaryIconTheme: ThemeComponents.getPrimaryIconTheme(colorScheme, false),
    );
  }

  // === Dark Theme ===
  static ThemeData get darkTheme {
    final colorScheme = ThemeColors.darkColorScheme;
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: colorScheme.background,
      textTheme: ThemeTypography.getTextTheme(colorScheme),
      
      // Component themes
      appBarTheme: ThemeComponents.getAppBarTheme(colorScheme, true),
      cardTheme: ThemeComponents.getCardTheme(colorScheme, true),
      elevatedButtonTheme: ThemeComponents.getElevatedButtonTheme(colorScheme, true),
      outlinedButtonTheme: ThemeComponents.getOutlinedButtonTheme(colorScheme, true),
      textButtonTheme: ThemeComponents.getTextButtonTheme(colorScheme, true),
      floatingActionButtonTheme: ThemeComponents.getFloatingActionButtonTheme(colorScheme, true),
      inputDecorationTheme: ThemeComponents.getInputDecorationTheme(colorScheme, true),
      listTileTheme: ThemeComponents.getListTileTheme(colorScheme, true),
      bottomNavigationBarTheme: ThemeComponents.getBottomNavigationBarTheme(colorScheme, true),
      dialogTheme: ThemeComponents.getDialogTheme(colorScheme, true),
      chipTheme: ThemeComponents.getChipTheme(colorScheme, true),
      tabBarTheme: ThemeComponents.getTabBarTheme(colorScheme, true),
      dividerTheme: ThemeComponents.getDividerTheme(colorScheme, true),
      iconTheme: ThemeComponents.getIconTheme(colorScheme, true),
      primaryIconTheme: ThemeComponents.getPrimaryIconTheme(colorScheme, true),
    );
  }
}
