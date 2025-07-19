// lib/core/theme/components/navigation_themes.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavigationThemes {
  NavigationThemes._();

  // Design tokens
  static const double elevationXs = 1.0;
  static const double elevationMd = 4.0;
  static const double iconMd = 24.0;
  static const String fontFamily = 'PlusJakartaSans';

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

  static BottomNavigationBarThemeData getBottomNavigationBarTheme(ColorScheme colorScheme, bool isDark) {
    return BottomNavigationBarThemeData(
      backgroundColor: colorScheme.surface,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: elevationMd,
    );
  }
}