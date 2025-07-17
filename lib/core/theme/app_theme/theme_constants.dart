// lib/core/theme/app_theme/theme_constants.dart
/// Design system constants for the app theme
class ThemeConstants {
  ThemeConstants._();

  // === Spacing (8pt grid system) ===
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;
  static const double spaceXxl = 48.0;

  // === Border radius ===
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;

  // === Elevations ===
  static const double elevationXs = 1.0;
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;

  // === Icon sizes ===
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  // === Primary Font ===
  static const String fontFamily = 'PlusJakartaSans';

  // === FilterChip specific constants ===
  static const double filterChipHeight = 40.0;
  static const double filterChipBorderRadius = 20.0;
  static const double filterChipPaddingHorizontal = 16.0;
  static const double filterChipPaddingVertical = 8.0;
  static const double filterChipFontSize = 14.0;
  static const double filterChipIconSize = 18.0;

  // === Animation durations ===
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // === Breakpoints for responsive design ===
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;
}
