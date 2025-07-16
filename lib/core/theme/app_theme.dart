import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    // Defines the color palette for the light theme.
    const colorScheme = ColorScheme.light(
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

    // Returns the complete theme data for the light theme.
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: colorScheme.background,

      // === AppBar ===
      appBarTheme: AppBarTheme(
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
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(
          color: colorScheme.onSurface,
          size: iconMd,
        ),
      ),

      // === Cards ===
      cardTheme: CardThemeData(
        elevation: elevationXs,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        color: colorScheme.surface,
        shadowColor: colorScheme.shadow.withOpacity(0.08),
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
      ),

      // === Buttons ===
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: elevationSm,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          shadowColor: colorScheme.primary.withOpacity(0.25),
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
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
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
      ),

      textButtonTheme: TextButtonThemeData(
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
      ),
      
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: elevationLg,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const CircleBorder(),
      ),

      // === Input Decoration ===
      inputDecorationTheme: InputDecorationTheme(
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
      ),

      // === List Tiles ===
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spaceMd,
          vertical: spaceSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        iconColor: colorScheme.onSurfaceVariant,
        textColor: colorScheme.onSurface,
      ),

      // === Bottom Navigation ===
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: elevationMd,
      ),

      // === Dialogs ===
      dialogTheme: DialogThemeData(
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
      ),

      // === Chips ===
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.primaryContainer,
        disabledColor: colorScheme.onSurface.withOpacity(0.12),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        labelStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),

      // === Divider ===
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      // === Icon Theme ===
      iconTheme: IconThemeData(
        color: colorScheme.onSurfaceVariant,
        size: iconMd,
      ),
      
      primaryIconTheme: IconThemeData(
        color: colorScheme.onPrimary,
        size: iconMd,
      ),

      // === Text Theme ===
      textTheme: TextTheme(
        // Display
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 48,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.5,
          color: colorScheme.onSurface,
        ),
        displayMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 36,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
          color: colorScheme.onSurface,
        ),
        displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: colorScheme.onSurface,
        ),

        // Headlines
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: colorScheme.onSurface,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          color: colorScheme.onSurface,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          color: colorScheme.onSurface,
        ),

        // Titles
        titleLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          color: colorScheme.onSurface,
        ),
        titleMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          color: colorScheme.onSurface,
        ),
        titleSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          color: colorScheme.onSurface,
        ),

        // Body
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          color: colorScheme.onSurface,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: colorScheme.onSurface,
        ),
        bodySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: colorScheme.onSurfaceVariant,
        ),

        // Labels
        labelLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          color: colorScheme.onSurface,
        ),
        labelMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: colorScheme.onSurface,
        ),
        labelSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }

  // === Dark Theme ===
  static ThemeData get darkTheme {
    // Defines the color palette for the dark theme.
    final colorScheme = ColorScheme.dark(
      // Primary colors
      primary: const Color(0xFF60A5FA), // Blue-400
      onPrimary: const Color(0xFF1E293B), // Slate-800
      primaryContainer: const Color(0xFF1E3A8A), // Blue-900
      onPrimaryContainer: const Color(0xFFD1E4FF),

      // Secondary colors
      secondary: const Color(0xFF818CF8), // Indigo-400
      onSecondary: const Color(0xFF1E293B),
      secondaryContainer: const Color(0xFF3730A3), // Indigo-800
      onSecondaryContainer: const Color(0xFFE0E7FF),

      // Tertiary colors
      tertiary: const Color(0xFFF87171), // Red-400
      onTertiary: const Color(0xFF1E293B),
      tertiaryContainer: const Color(0xFF7F1D1D), // Red-900
      onTertiaryContainer: const Color(0xFFFEE2E2),

      // Error colors
      error: const Color(0xFFF87171),
      onError: const Color(0xFF1E293B),
      errorContainer: const Color(0xFF7F1D1D),
      onErrorContainer: const Color(0xFFFEE2E2),
      
      // Surface colors
      surface: const Color(0xFF1E293B), // Slate-800
      onSurface: const Color(0xFFF1F5F9), // Slate-100
      surfaceContainerHighest: const Color(0xFF334155), // Slate-700
      onSurfaceVariant: const Color(0xFF94A3B8), // Slate-400

      // Outline
      outline: const Color(0xFF475569), // Slate-600
      outlineVariant: const Color(0xFF334155), // Slate-700
      
      // Background
      background: const Color(0xFF0F172A), // Slate-900
      onBackground: const Color(0xFFF1F5F9),
      
      shadow: const Color(0xFF000000),
      scrim: const Color(0xFF000000),
    );

    // Takes the light theme and overwrites properties for the dark theme.
    return lightTheme.copyWith(
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      
      // === AppBar (Dark) ===
      appBarTheme: lightTheme.appBarTheme.copyWith(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      
      // === Cards (Dark) ===
      cardTheme: lightTheme.cardTheme.copyWith(
        color: colorScheme.surface,
        shadowColor: colorScheme.shadow.withOpacity(0.2),
      ),

      // === Buttons (Dark) ===
       elevatedButtonTheme: ElevatedButtonThemeData(
        style: lightTheme.elevatedButtonTheme.style?.copyWith(
            backgroundColor: MaterialStateProperty.all(colorScheme.primary),
            foregroundColor: MaterialStateProperty.all(colorScheme.onPrimary),
            shadowColor: MaterialStateProperty.all(colorScheme.primary.withOpacity(0.25)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: lightTheme.outlinedButtonTheme.style?.copyWith(
            foregroundColor: MaterialStateProperty.all(colorScheme.primary),
            side: MaterialStateProperty.all(BorderSide(color: colorScheme.outline)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: lightTheme.textButtonTheme.style?.copyWith(
            foregroundColor: MaterialStateProperty.all(colorScheme.primary),
        ),
      ),
      
      // === Input Decoration (Dark) ===
      inputDecorationTheme: lightTheme.inputDecorationTheme.copyWith(
        fillColor: colorScheme.surfaceContainerHighest,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
      
      // === Bottom Navigation (Dark) ===
      bottomNavigationBarTheme: lightTheme.bottomNavigationBarTheme.copyWith(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
      ),
      
      // === Dialogs (Dark) ===
      dialogTheme: lightTheme.dialogTheme.copyWith(
        backgroundColor: colorScheme.surface,
      ),
      
      // === Chips (Dark) ===
      chipTheme: lightTheme.chipTheme.copyWith(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.primaryContainer,
      ),
      
      // === Divider (Dark) ===
      dividerTheme: lightTheme.dividerTheme.copyWith(
        color: colorScheme.outlineVariant,
      ),
      
      // === Icon (Dark) ===
      iconTheme: lightTheme.iconTheme.copyWith(
        color: colorScheme.onSurfaceVariant,
      )
    );
  }
}
