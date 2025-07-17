// lib/core/theme/app_theme/theme_colors.dart
import 'package:flutter/material.dart';

/// Color definitions for light and dark themes
class ThemeColors {
  ThemeColors._();

  // === Light Theme Color Scheme ===
  static const ColorScheme lightColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0xFF2563EB), // Blue-600
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFDCE7FF),
    onPrimaryContainer: Color(0xFF1E40AF),

    // Secondary colors
    secondary: Color(0xFF7C3AED), // Violet-600
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFEDE9FE),
    onSecondaryContainer: Color(0xFF6D28D9),

    // Tertiary colors
    tertiary: Color(0xFFDC2626), // Red-600
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFEE2E2),
    onTertiaryContainer: Color(0xFFB91C1C),

    // Error colors
    error: Color(0xFFDC2626),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFEE2E2),
    onErrorContainer: Color(0xFFB91C1C),

    // Surface colors
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1F2937), // Gray-800
    surfaceContainerHighest: Color(0xFFF9FAFB), // Gray-50
    onSurfaceVariant: Color(0xFF6B7280), // Gray-500

    // Outline
    outline: Color(0xFFD1D5DB), // Gray-300
    outlineVariant: Color(0xFFF3F4F6), // Gray-100

    // Background
    background: Color(0xFFFAFAFA), // Very light gray
    onBackground: Color(0xFF1F2937),

    // Shadow
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  // === Dark Theme Color Scheme ===
  static const ColorScheme darkColorScheme = ColorScheme.dark(
    // Primary colors
    primary: Color(0xFF60A5FA), // Blue-400
    onPrimary: Color(0xFF1E293B), // Slate-800
    primaryContainer: Color(0xFF1E3A8A), // Blue-900
    onPrimaryContainer: Color(0xFFD1E4FF),

    // Secondary colors
    secondary: Color(0xFF818CF8), // Indigo-400
    onSecondary: Color(0xFF1E293B),
    secondaryContainer: Color(0xFF3730A3), // Indigo-800
    onSecondaryContainer: Color(0xFFE0E7FF),

    // Tertiary colors
    tertiary: Color(0xFFF87171), // Red-400
    onTertiary: Color(0xFF1E293B),
    tertiaryContainer: Color(0xFF7F1D1D), // Red-900
    onTertiaryContainer: Color(0xFFFEE2E2),

    // Error colors
    error: Color(0xFFF87171),
    onError: Color(0xFF1E293B),
    errorContainer: Color(0xFF7F1D1D),
    onErrorContainer: Color(0xFFFEE2E2),
    
    // Surface colors
    surface: Color(0xFF1E293B), // Slate-800
    onSurface: Color(0xFFF1F5F9), // Slate-100
    surfaceContainerHighest: Color(0xFF334155), // Slate-700
    onSurfaceVariant: Color(0xFF94A3B8), // Slate-400

    // Outline
    outline: Color(0xFF475569), // Slate-600
    outlineVariant: Color(0xFF334155), // Slate-700
    
    // Background
    background: Color(0xFF0F172A), // Slate-900
    onBackground: Color(0xFFF1F5F9),
    
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );
}
