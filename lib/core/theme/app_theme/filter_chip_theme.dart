// lib/core/theme/app_theme/filter_chip_theme.dart
import 'package:flutter/material.dart';

/// Specialized FilterChip theme configurations for the document list
class FilterChipTheme {
  FilterChipTheme._();

  // Design tokens
  static const double radiusLg = 16.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const String fontFamily = 'PlusJakartaSans';

  /// Enhanced FilterChip theme for document filtering
  static ChipThemeData getFilterChipTheme(ColorScheme colorScheme, bool isDark) {
    return ChipThemeData(
      // Background colors
      backgroundColor: colorScheme.surfaceContainerHighest,
      selectedColor: colorScheme.primaryContainer,
      disabledColor: colorScheme.onSurface.withValues(alpha: 0.12),
      
      // Border
      side: BorderSide.none,
      
      // Shape - more rounded for modern look
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      
      // Typography
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
      
      // Padding
      padding: const EdgeInsets.symmetric(
        horizontal: spaceMd,
        vertical: spaceSm,
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: spaceSm),
      
      // Elevation and interaction
      pressElevation: 1.0,
      elevation: 0,
      
      // Icons
      iconTheme: IconThemeData(
        color: colorScheme.onSurfaceVariant,
        size: 18,
      ),
      deleteIconColor: colorScheme.onSurfaceVariant,
      
      // Selection indicators
      checkmarkColor: colorScheme.onPrimaryContainer,
      selectedShadowColor: colorScheme.primary.withValues(alpha: 0.12),
      showCheckmark: true,
      
      // Brightness adjustments for dark mode
      brightness: isDark ? Brightness.dark : Brightness.light,
    );
  }

  /// Predefined filter chip styles
  static Widget buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onSelected,
    IconData? icon,
    ColorScheme? colorScheme,
  }) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      avatar: icon != null ? Icon(icon, size: 18) : null,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  /// Filter chip with count badge
  static Widget buildFilterChipWithCount({
    required String label,
    required int count,
    required bool isSelected,
    required VoidCallback onSelected,
    IconData? icon,
    ColorScheme? colorScheme,
  }) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: 4),
          ],
          Text(label),
          if (count > 0) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected 
                    ? colorScheme?.onPrimaryContainer.withValues(alpha: 0.2)
                    : colorScheme?.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? colorScheme?.onPrimaryContainer
                      : colorScheme?.primary,
                ),
              ),
            ),
          ],
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
