// lib/core/theme/app_theme/theme_components.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Component theme definitions for the app
class ThemeComponents {
  ThemeComponents._();

  // Design tokens
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double elevationXs = 1.0;
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;
  static const double iconMd = 24.0;
  static const String fontFamily = 'PlusJakartaSans';

  // === AppBar Theme ===
  static AppBarTheme getAppBarTheme(ColorScheme colorScheme, bool isDark) {
    return AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: elevationXs,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        letterSpacing: -0.5,
      ),
      systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      iconTheme: IconThemeData(
        color: colorScheme.onSurface,
        size: iconMd,
      ),
    );
  }

  // === Card Theme ===
  static CardThemeData getCardTheme(ColorScheme colorScheme, bool isDark) {
    return CardThemeData(
      elevation: elevationXs,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      color: colorScheme.surface,
      shadowColor: colorScheme.shadow.withValues(alpha: isDark ? 0.2 : 0.08),
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
    );
  }

  // === Button Themes ===
  static ElevatedButtonThemeData getElevatedButtonTheme(ColorScheme colorScheme, bool isDark) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: elevationSm,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: colorScheme.onSurface.withValues(alpha: 0.12),
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
        shadowColor: colorScheme.primary.withValues(alpha: 0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: spaceLg,
          vertical: spaceMd,
        ),
        minimumSize: const Size(64, 48),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData getOutlinedButtonTheme(ColorScheme colorScheme, bool isDark) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: spaceLg,
          vertical: spaceMd,
        ),
        minimumSize: const Size(64, 48),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  static TextButtonThemeData getTextButtonTheme(ColorScheme colorScheme, bool isDark) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: spaceMd,
          vertical: spaceSm,
        ),
        minimumSize: const Size(48, 40),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  static FloatingActionButtonThemeData getFloatingActionButtonTheme(ColorScheme colorScheme, bool isDark) {
    return FloatingActionButtonThemeData(
      elevation: elevationLg,
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      shape: const CircleBorder(),
    );
  }

  // === Input Decoration Theme ===
  static InputDecorationTheme getInputDecorationTheme(ColorScheme colorScheme, bool isDark) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest,
      contentPadding: const EdgeInsets.all(spaceMd),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: colorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: colorScheme.error, width: 2),
      ),
      hintStyle: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // === List Tile Theme ===
  static ListTileThemeData getListTileTheme(ColorScheme colorScheme, bool isDark) {
    return ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spaceMd,
        vertical: spaceSm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      iconColor: colorScheme.onSurfaceVariant,
      textColor: colorScheme.onSurface,
    );
  }

  // === Bottom Navigation Theme ===
  static BottomNavigationBarThemeData getBottomNavigationBarTheme(ColorScheme colorScheme, bool isDark) {
    return BottomNavigationBarThemeData(
      backgroundColor: colorScheme.surface,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: elevationMd,
    );
  }

  // === Dialog Theme ===
  static DialogThemeData getDialogTheme(ColorScheme colorScheme, bool isDark) {
    return DialogThemeData(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusXl),
      ),
      elevation: elevationLg,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      contentTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        color: colorScheme.onSurface,
      ),
    );
  }

  // === Enhanced Chip Theme (optimized for FilterChips) ===
  static ChipThemeData getChipTheme(ColorScheme colorScheme, bool isDark) {
    return ChipThemeData(
      // Background colors for FilterChips
      backgroundColor: colorScheme.surfaceContainerHighest,
      selectedColor: colorScheme.primaryContainer,
      disabledColor: colorScheme.onSurface.withValues(alpha: 0.12),
      
      // Border - no border for modern look
      side: BorderSide.none,
      
      // Shape - more rounded for FilterChips
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLg), // More rounded for modern look
      ),
      
      // Typography optimized for FilterChips
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
        letterSpacing: 0.1,
      ),
      secondaryLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: colorScheme.onPrimaryContainer,
        letterSpacing: 0.1,
      ),
      
      // Spacing optimized for FilterChips
      padding: const EdgeInsets.symmetric(
        horizontal: spaceMd,
        vertical: spaceSm,
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: spaceSm),
      
      // Interaction feedback
      pressElevation: elevationXs,
      elevation: 0,
      
      // Icons for FilterChips
      iconTheme: IconThemeData(
        color: colorScheme.onSurfaceVariant,
        size: 18,
      ),
      deleteIconColor: colorScheme.onSurfaceVariant,
      checkmarkColor: colorScheme.onPrimaryContainer,
      selectedShadowColor: colorScheme.primary.withValues(alpha: 0.12),
      showCheckmark: true,
    );
  }

  // === Tab Bar Theme ===
  static TabBarThemeData getTabBarTheme(ColorScheme colorScheme, bool isDark) {
    return TabBarThemeData(
      labelColor: colorScheme.primary,
      unselectedLabelColor: colorScheme.onSurfaceVariant,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.primary,
            width: 2.0,
          ),
        ),
      ),
      labelStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // === Divider Theme ===
  static DividerThemeData getDividerTheme(ColorScheme colorScheme, bool isDark) {
    return DividerThemeData(
      color: colorScheme.outlineVariant,
      thickness: 1,
      space: 1,
    );
  }

  // === Icon Themes ===
  static IconThemeData getIconTheme(ColorScheme colorScheme, bool isDark) {
    return IconThemeData(
      color: colorScheme.onSurfaceVariant,
      size: iconMd,
    );
  }

  static IconThemeData getPrimaryIconTheme(ColorScheme colorScheme, bool isDark) {
    return IconThemeData(
      color: colorScheme.onPrimary,
      size: iconMd,
    );
  }
}
