# App Theme Structure

This folder contains the modular theme system for the SakuDok application, organized for better maintainability and scalability.

## File Structure

```
app_theme/
├── app_theme.dart          # Main theme class with light/dark themes
├── theme_colors.dart       # Color scheme definitions
├── theme_typography.dart   # Text styles and typography
├── theme_components.dart   # Component-specific themes
├── filter_chip_theme.dart  # Specialized FilterChip configurations
├── theme_constants.dart    # Design system constants
└── README.md              # This documentation
```

## Usage

Import the main theme file to access all theme components:

```dart
import 'package:sakudok/core/theme/app_theme.dart';

// Use in MaterialApp
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  // ...
)
```

## Theme Components

### Colors (`theme_colors.dart`)
- Light and dark color schemes
- Material Design 3 compliant colors
- Consistent color tokens across the app

### Typography (`theme_typography.dart`)
- Plus Jakarta Sans font family
- Comprehensive text styles (display, headline, title, body, label)
- Proper letter spacing and font weights

### Components (`theme_components.dart`)
- All Material component themes
- Buttons, cards, inputs, navigation, etc.
- Optimized for both light and dark modes

### FilterChip Theme (`filter_chip_theme.dart`)
- Specialized FilterChip configurations
- Helper methods for creating filter chips
- Support for count badges and icons

### Constants (`theme_constants.dart`)
- Design system tokens
- Spacing, radius, elevation values
- Animation durations
- Responsive breakpoints

## Design System

### Spacing (8pt grid)
- XS: 4px
- SM: 8px
- MD: 16px
- LG: 24px
- XL: 32px
- XXL: 48px

### Border Radius
- XS: 4px
- SM: 8px
- MD: 12px
- LG: 16px
- XL: 20px

### Typography
- Font Family: Plus Jakarta Sans
- Weights: 400 (Regular), 500 (Medium), 600 (SemiBold), 700 (Bold)

## Benefits

1. **Modular Structure**: Easy to maintain and extend
2. **Type Safety**: Proper TypeScript/Dart typing
3. **Consistency**: Centralized design tokens
4. **Performance**: Optimized theme creation
5. **Flexibility**: Easy to customize individual components

## Migration Notes

The old monolithic `app_theme.dart` has been replaced with this modular structure. All imports should now use:

```dart
import 'package:sakudok/core/theme/app_theme.dart';
```

The `AppTheme` class interface remains the same, so existing code should work without changes.
