// lib/core/theme/components/base_themes.dart
import 'package:flutter/material.dart';

class BaseThemes {
  BaseThemes._();

  // Design tokens
  static const double iconMd = 24.0;

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
