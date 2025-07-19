// lib/core/theme/components/form_themes.dart
import 'package:flutter/material.dart';

class FormThemes {
  FormThemes._();

  // Design tokens
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double elevationXs = 1.0;
  static const String fontFamily = 'PlusJakartaSans';

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
}
