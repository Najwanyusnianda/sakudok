import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();
  
  // === FONT FAMILIES ===
  
  static const String primaryFont = 'PlusJakartaSans';
  static const String secondaryFont = 'Poppins';
  
  // === FONT WEIGHTS ===
  
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
  
  // === DISPLAY STYLES (For hero text, marketing headers) ===
  
  static const TextStyle displayLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 64,
    fontWeight: bold,
    height: 1.1,
    letterSpacing: -0.5,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 48,
    fontWeight: bold,
    height: 1.15,
    letterSpacing: -0.25,
  );
  
  static const TextStyle displaySmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 36,
    fontWeight: semiBold,
    height: 1.2,
    letterSpacing: 0,
  );
  
  // === HEADLINE STYLES (For section headers, page titles) ===
  
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 32,
    fontWeight: semiBold,
    height: 1.25,
    letterSpacing: 0,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 28,
    fontWeight: semiBold,
    height: 1.3,
    letterSpacing: 0,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: medium,
    height: 1.35,
    letterSpacing: 0,
  );
  
  // === TITLE STYLES (For card titles, form labels) ===
  
  static const TextStyle titleLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    fontWeight: medium,
    height: 1.45,
    letterSpacing: 0.1,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: medium,
    height: 1.5,
    letterSpacing: 0.1,
  );
  
  // === BODY STYLES (For content, descriptions) ===
  
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: regular,
    height: 1.6,
    letterSpacing: 0.15,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: regular,
    height: 1.6,
    letterSpacing: 0.25,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: regular,
    height: 1.65,
    letterSpacing: 0.4,
  );
  
  // === LABEL STYLES (For buttons, chips, form fields) ===
  
  static const TextStyle labelLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.1,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: medium,
    height: 1.35,
    letterSpacing: 0.5,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    fontWeight: medium,
    height: 1.3,
    letterSpacing: 0.5,
  );
  
  // === SPECIALIZED STYLES ===
  
  // Button text styles
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: semiBold,
    height: 1.25,
    letterSpacing: 0.1,
  );
  
  static const TextStyle buttonMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: semiBold,
    height: 1.3,
    letterSpacing: 0.25,
  );
  
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: semiBold,
    height: 1.35,
    letterSpacing: 0.4,
  );
  
  // Caption styles (for hints, helper text, timestamps)
  static const TextStyle caption = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: regular,
    height: 1.4,
    letterSpacing: 0.4,
  );
  
  static const TextStyle captionSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    fontWeight: regular,
    height: 1.4,
    letterSpacing: 0.5,
  );
  
  // Overline styles (for categories, tags)
  static const TextStyle overline = TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    fontWeight: medium,
    height: 1.6,
    letterSpacing: 1.5,
  );
  
  // Code/monospace styles
  static const TextStyle code = TextStyle(
    fontFamily: 'JetBrains Mono',
    fontSize: 14,
    fontWeight: regular,
    height: 1.4,
    letterSpacing: 0,
  );
  
  static const TextStyle codeSmall = TextStyle(
    fontFamily: 'JetBrains Mono',
    fontSize: 12,
    fontWeight: regular,
    height: 1.4,
    letterSpacing: 0,
  );
  
  // === SEMANTIC STYLES (Context-specific typography) ===
  
  // Document titles
  static const TextStyle documentTitle = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    fontWeight: semiBold,
    height: 1.4,
    letterSpacing: 0,
  );
  
  // Document metadata
  static const TextStyle documentMeta = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: regular,
    height: 1.5,
    letterSpacing: 0.25,
  );
  
  // Form field labels
  static const TextStyle fieldLabel = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.1,
  );
  
  // Form field input text
  static const TextStyle fieldInput = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: regular,
    height: 1.5,
    letterSpacing: 0.15,
  );
  
  // Form field helper text
  static const TextStyle fieldHelper = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: regular,
    height: 1.35,
    letterSpacing: 0.4,
  );
  
  // Error messages
  static const TextStyle error = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: regular,
    height: 1.35,
    letterSpacing: 0.25,
  );
  
  // Success messages
  static const TextStyle success = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.1,
  );
  
  // Navigation items
  static const TextStyle navigation = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: medium,
    height: 1.3,
    letterSpacing: 0.1,
  );
  
  // Tab labels
  static const TextStyle tab = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: semiBold,
    height: 1.2,
    letterSpacing: 0.25,
  );
  
  // App bar title
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: semiBold,
    height: 1.3,
    letterSpacing: 0,
  );
  
  // Dialog title
  static const TextStyle dialogTitle = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: semiBold,
    height: 1.3,
    letterSpacing: 0,
  );
  
  // Snackbar text
  static const TextStyle snackbar = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: regular,
    height: 1.4,
    letterSpacing: 0.25,
  );
  
  // === UTILITY METHODS ===
  
  /// Create a style with specific color
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }
  
  /// Create a style with specific font weight
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
  
  /// Create a style with specific font size
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }
  
  /// Create a style with opacity
  static TextStyle withOpacity(TextStyle style, double opacity) {
    return style.copyWith(color: (style.color ?? Colors.black).withOpacity(opacity));
  }
  
  /// Create a responsive text style based on screen size
  static TextStyle responsive({
    required TextStyle mobile,
    TextStyle? tablet,
    TextStyle? desktop,
    required BuildContext context,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth >= 1200 && desktop != null) {
      return desktop;
    } else if (screenWidth >= 768 && tablet != null) {
      return tablet;
    }
    return mobile;
  }
  
  /// Scale text size for accessibility
  static TextStyle withAccessibilityScale(TextStyle style, double scale) {
    return style.copyWith(fontSize: (style.fontSize ?? 14) * scale);
  }
}
