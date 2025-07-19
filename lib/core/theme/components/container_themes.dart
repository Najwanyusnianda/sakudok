// lib/core/theme/components/container_themes.dart
import 'package:flutter/material.dart';

class ContainerThemes {
  ContainerThemes._();

  // Design tokens
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double elevationXs = 1.0;
  static const double elevationLg = 8.0;
  static const String fontFamily = 'PlusJakartaSans';

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

  static ListTileThemeData getListTileTheme(ColorScheme colorScheme, bool isDark) {
    return ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      iconColor: colorScheme.onSurfaceVariant,
      textColor: colorScheme.onSurface,
    );
  }

  static DividerThemeData getDividerTheme(ColorScheme colorScheme, bool isDark) {
    return DividerThemeData(
      color: colorScheme.outlineVariant,
      thickness: 1,
      space: 1,
    );
  }
}
