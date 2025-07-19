// lib/core/theme/app_theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme_colors.dart';
import 'theme_typography.dart';
// --- FIX: Import the new, smaller theme component files ---
import '../components/button_themes.dart';
import '../components/container_themes.dart';
import '../components/form_themes.dart';
import '../components/navigation_themes.dart';
// Note: You can remove the import for 'theme_components.dart' as it's no longer needed.

/// Modern, minimal app theme following Material Design 3 principles.
class AppTheme {
  AppTheme._();

  // === Design Tokens (can be moved to a separate file if they grow) ===
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double radiusMd = 12.0;
  static const double iconMd = 24.0;
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
      
      // --- FIX: Corrected the method calls to match the refactored components ---
      // Note: Ensure your component theme files (e.g., button_themes.dart) are updated
      // to only accept ColorScheme, except where 'isDark' is truly needed.

      // 'isDark' is passed as a positional argument here.
      appBarTheme: NavigationThemes.getAppBarTheme(colorScheme, false),
      
      // These methods should only require the colorScheme.
      cardTheme: ContainerThemes.getCardTheme(colorScheme,false),
      dialogTheme: ContainerThemes.getDialogTheme(colorScheme,false),
      elevatedButtonTheme: ButtonThemes.getElevatedButtonTheme(colorScheme,false),
      outlinedButtonTheme: ButtonThemes.getOutlinedButtonTheme(colorScheme,false),
      textButtonTheme: ButtonThemes.getTextButtonTheme(colorScheme,false),
      floatingActionButtonTheme: ButtonThemes.getFloatingActionButtonTheme(colorScheme,false),
      inputDecorationTheme: FormThemes.getInputDecorationTheme(colorScheme,false),
      chipTheme: FormThemes.getChipTheme(colorScheme,false),
      tabBarTheme: NavigationThemes.getTabBarTheme(colorScheme,false),
      bottomNavigationBarTheme: NavigationThemes.getBottomNavigationBarTheme(colorScheme,false),
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
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: ThemeTypography.getTextTheme(colorScheme),
      
      // --- FIX: Corrected the method calls for the dark theme as well ---
      appBarTheme: NavigationThemes.getAppBarTheme(colorScheme, true),
      cardTheme: ContainerThemes.getCardTheme(colorScheme, true),
      dialogTheme: ContainerThemes.getDialogTheme(colorScheme, true),
      elevatedButtonTheme: ButtonThemes.getElevatedButtonTheme(colorScheme, true),
      outlinedButtonTheme: ButtonThemes.getOutlinedButtonTheme(colorScheme, true),
      textButtonTheme: ButtonThemes.getTextButtonTheme(colorScheme, true),
      floatingActionButtonTheme: ButtonThemes.getFloatingActionButtonTheme(colorScheme, true),
      inputDecorationTheme: FormThemes.getInputDecorationTheme(colorScheme, true),
      chipTheme: FormThemes.getChipTheme(colorScheme, true),
      tabBarTheme: NavigationThemes.getTabBarTheme(colorScheme, true),
      bottomNavigationBarTheme: NavigationThemes.getBottomNavigationBarTheme(colorScheme, true),
    );
  }
}
