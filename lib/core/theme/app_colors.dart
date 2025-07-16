import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  
  // === MODERN MINIMAL PALETTE ===
  
  // Primary Brand Colors (Blue-based, modern and professional)
  static const Color primary = Color(0xFF2563EB);      // Modern blue
  static const Color primaryLight = Color(0xFF3B82F6); // Lighter blue
  static const Color primaryDark = Color(0xFF1D4ED8);  // Darker blue
  static const Color primaryContainer = Color(0xFFEBF2FF); // Very light blue
  
  // Secondary Colors (Green-based for success/positive actions)
  static const Color secondary = Color(0xFF10B981);      // Modern emerald
  static const Color secondaryLight = Color(0xFF34D399); // Light emerald
  static const Color secondaryDark = Color(0xFF059669);  // Dark emerald
  static const Color secondaryContainer = Color(0xFFECFDF5); // Very light green
  
  // Tertiary Colors (Purple-based for accent/creative elements)
  static const Color tertiary = Color(0xFF8B5CF6);      // Modern purple
  static const Color tertiaryLight = Color(0xFFA78BFA); // Light purple
  static const Color tertiaryDark = Color(0xFF7C3AED);  // Dark purple
  static const Color tertiaryContainer = Color(0xFFF3F0FF); // Very light purple
  
  // === NEUTRAL COLORS (Modern gray scale) ===
  
  // Background Colors
  static const Color background = Color(0xFFFAFAFA);    // Off-white for less eye strain
  static const Color surface = Color(0xFFFFFFFF);       // Pure white for cards/surfaces
  static const Color surfaceVariant = Color(0xFFF8FAFC); // Slightly tinted surface
  static const Color card = Color(0xFFFFFFFF);          // Card background
  
  // Text Colors (High contrast, accessible)
  static const Color textPrimary = Color(0xFF0F172A);   // Almost black (better than pure black)
  static const Color textSecondary = Color(0xFF475569); // Medium gray
  static const Color textTertiary = Color(0xFF94A3B8);  // Light gray
  static const Color textDisabled = Color(0xFFCBD5E1); // Very light gray
  
  // === STATUS COLORS ===
  
  // Success (Green family)
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF6EE7B7);
  static const Color successDark = Color(0xFF047857);
  static const Color successContainer = Color(0xFFECFDF5);
  
  // Warning (Amber family)
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);
  static const Color warningContainer = Color(0xFFFEF3C7);
  
  // Error (Red family)
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color errorContainer = Color(0xFFFEF2F2);
  
  // Info (Blue family)
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);
  static const Color infoContainer = Color(0xFFEBF2FF);
  
  // === BORDER COLORS ===
  
  static const Color border = Color(0xFFE2E8F0);       // Light border
  static const Color borderLight = Color(0xFFF1F5F9);  // Very light border
  static const Color borderFocus = primary;             // Focus state border
  static const Color borderError = error;               // Error state border
  
  // === SHADOW COLORS ===
  
  static const Color shadow = Color(0x0F000000);        // 6% opacity black
  static const Color shadowLight = Color(0x08000000);   // 3% opacity black
  static const Color shadowDark = Color(0x1A000000);    // 10% opacity black
  
  // === ON-COLORS (Text/Icons that appear on colored backgrounds) ===
  
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF1E40AF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF065F46);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFF5B21B6);
  static const Color onSurface = textPrimary;
  static const Color onSurfaceVariant = textSecondary;
  static const Color onBackground = textPrimary;
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF991B1B);
  
  // === DOCUMENT TYPE COLORS (Semantic, colorful for categories) ===
  
  static const Color documentKtp = Color(0xFF3B82F6);    // Blue
  static const Color documentSim = Color(0xFF10B981);    // Green
  static const Color documentIjazah = Color(0xFFF59E0B); // Amber
  static const Color documentPaspor = Color(0xFF8B5CF6); // Purple
  static const Color documentStnk = Color(0xFFEF4444);   // Red
  static const Color documentBpjs = Color(0xFF06B6D4);   // Cyan
  static const Color documentNpwp = Color(0xFF84CC16);   // Lime
  static const Color documentIelts = Color(0xFFEC4899);  // Pink
  static const Color documentOther = Color(0xFF6B7280);  // Gray
  
  // === GRADIENT DEFINITIONS ===
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient tertiaryGradient = LinearGradient(
    colors: [tertiary, tertiaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [surface, surfaceVariant],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // === UTILITY METHODS ===
  
  /// Get document type color by name
  static Color getDocumentTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'ktp':
        return documentKtp;
      case 'sim':
        return documentSim;
      case 'ijazah':
        return documentIjazah;
      case 'paspor':
      case 'passport':
        return documentPaspor;
      case 'stnk':
        return documentStnk;
      case 'bpjs':
        return documentBpjs;
      case 'npwp':
        return documentNpwp;
      case 'ielts':
        return documentIelts;
      default:
        return documentOther;
    }
  }
  
  /// Get status color by type
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
      case 'complete':
      case 'active':
        return success;
      case 'warning':
      case 'pending':
        return warning;
      case 'error':
      case 'failed':
      case 'expired':
        return error;
      case 'info':
      case 'draft':
        return info;
      default:
        return textSecondary;
    }
  }
  
  /// Create a color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
  
  /// Create lighter version of a color
  static Color lighten(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
  
  /// Create darker version of a color
  static Color darken(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
}
