import 'package:flutter/material.dart';

/// Modern spacing constants following 8pt grid system
class AppSpacing {
  AppSpacing._();
  
  // Base spacing unit (8pt grid)
  static const double _base = 8.0;
  
  // Spacing values
  static const double xs = _base * 0.5;   // 4
  static const double sm = _base;         // 8
  static const double md = _base * 2;     // 16
  static const double lg = _base * 3;     // 24
  static const double xl = _base * 4;     // 32
  static const double xxl = _base * 6;    // 48
  static const double xxxl = _base * 8;   // 64
  
  // Page margins
  static const double pageHorizontal = md;
  static const double pageVertical = lg;
  
  // Card spacing
  static const double cardPadding = md;
  static const double cardMargin = sm;
  
  // List spacing
  static const double listItemSpacing = sm;
  static const double listSectionSpacing = lg;
}

/// Modern border radius values
class AppRadius {
  AppRadius._();
  
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  
  // Component specific
  static const double button = md;
  static const double card = lg;
  static const double input = md;
  static const double dialog = xl;
  static const double bottomSheet = xl;
}

/// Modern elevation system
class AppElevation {
  AppElevation._();
  
  static const double none = 0;
  static const double xs = 1;
  static const double sm = 2;
  static const double md = 4;
  static const double lg = 8;
  static const double xl = 12;
  static const double xxl = 16;
  static const double max = 24;
}

/// Animation duration constants
class AppDuration {
  AppDuration._();
  
  static const Duration quick = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 350);
  static const Duration verySlow = Duration(milliseconds: 500);
}

/// Animation curves
class AppCurves {
  AppCurves._();
  
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
  static const Curve bounceIn = Curves.bounceIn;
  static const Curve bounceOut = Curves.bounceOut;
}

/// Modern sizing constants
class AppSizing {
  AppSizing._();
  
  // Icon sizes
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;
  
  // Button sizes
  static const double buttonHeight = 48.0;
  static const double buttonHeightSm = 40.0;
  static const double buttonHeightLg = 56.0;
  
  // Touch targets (following Material guidelines)
  static const double touchTarget = 48.0;
  static const double touchTargetSm = 40.0;
  
  // Avatar sizes
  static const double avatarXs = 24.0;
  static const double avatarSm = 32.0;
  static const double avatarMd = 40.0;
  static const double avatarLg = 56.0;
  static const double avatarXl = 72.0;
  
  // Form elements
  static const double inputHeight = 56.0;
  static const double inputHeightSm = 48.0;
}

/// Common padding/margin shortcuts
class AppPadding {
  AppPadding._();
  
  // All sides
  static const EdgeInsets xs = EdgeInsets.all(AppSpacing.xs);
  static const EdgeInsets sm = EdgeInsets.all(AppSpacing.sm);
  static const EdgeInsets md = EdgeInsets.all(AppSpacing.md);
  static const EdgeInsets lg = EdgeInsets.all(AppSpacing.lg);
  static const EdgeInsets xl = EdgeInsets.all(AppSpacing.xl);
  
  // Horizontal
  static const EdgeInsets horizontalXs = EdgeInsets.symmetric(horizontal: AppSpacing.xs);
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: AppSpacing.sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: AppSpacing.md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: AppSpacing.lg);
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: AppSpacing.xl);
  
  // Vertical
  static const EdgeInsets verticalXs = EdgeInsets.symmetric(vertical: AppSpacing.xs);
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: AppSpacing.sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: AppSpacing.md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: AppSpacing.lg);
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: AppSpacing.xl);
  
  // Page level
  static const EdgeInsets page = EdgeInsets.symmetric(
    horizontal: AppSpacing.pageHorizontal,
    vertical: AppSpacing.pageVertical,
  );
  
  // Button specific
  static const EdgeInsets button = EdgeInsets.symmetric(
    horizontal: AppSpacing.lg,
    vertical: AppSpacing.md,
  );
  
  static const EdgeInsets buttonSm = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: AppSpacing.sm,
  );
}

/// Common border radius shortcuts
class AppBorderRadius {
  AppBorderRadius._();
  
  static BorderRadius get xs => BorderRadius.circular(AppRadius.xs);
  static BorderRadius get sm => BorderRadius.circular(AppRadius.sm);
  static BorderRadius get md => BorderRadius.circular(AppRadius.md);
  static BorderRadius get lg => BorderRadius.circular(AppRadius.lg);
  static BorderRadius get xl => BorderRadius.circular(AppRadius.xl);
  static BorderRadius get xxl => BorderRadius.circular(AppRadius.xxl);
  
  // Specific use cases
  static BorderRadius get button => BorderRadius.circular(AppRadius.button);
  static BorderRadius get card => BorderRadius.circular(AppRadius.card);
  static BorderRadius get input => BorderRadius.circular(AppRadius.input);
  static BorderRadius get dialog => BorderRadius.circular(AppRadius.dialog);
  
  // Directional
  static BorderRadius get topOnly => BorderRadius.only(
    topLeft: Radius.circular(AppRadius.lg),
    topRight: Radius.circular(AppRadius.lg),
  );
  
  static BorderRadius get bottomOnly => BorderRadius.only(
    bottomLeft: Radius.circular(AppRadius.lg),
    bottomRight: Radius.circular(AppRadius.lg),
  );
}

/// Modern shadow definitions
class AppShadows {
  AppShadows._();
  
  static List<BoxShadow> get none => [];
  
  static List<BoxShadow> get xs => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      offset: const Offset(0, 1),
      blurRadius: 2,
    ),
  ];
  
  static List<BoxShadow> get sm => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 2),
      blurRadius: 4,
    ),
  ];
  
  static List<BoxShadow> get md => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 4),
      blurRadius: 8,
    ),
  ];
  
  static List<BoxShadow> get lg => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 8),
      blurRadius: 16,
    ),
  ];
  
  static List<BoxShadow> get xl => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 12),
      blurRadius: 24,
    ),
  ];
}

/// Helper extensions for common UI patterns
extension WidgetExtensions on Widget {
  /// Add padding to a widget
  Widget withPadding(EdgeInsets padding) {
    return Padding(padding: padding, child: this);
  }
  
  /// Add margin to a widget using Container
  Widget withMargin(EdgeInsets margin) {
    return Container(margin: margin, child: this);
  }
  
  /// Add both padding and margin
  Widget withSpacing({EdgeInsets? padding, EdgeInsets? margin}) {
    Widget widget = this;
    if (padding != null) {
      widget = Padding(padding: padding, child: widget);
    }
    if (margin != null) {
      widget = Container(margin: margin, child: widget);
    }
    return widget;
  }
  
  /// Add tap gesture
  Widget onTap(VoidCallback? onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }
  
  /// Add Material InkWell with rounded corners
  Widget withInkWell({
    VoidCallback? onTap,
    BorderRadius? borderRadius,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? AppBorderRadius.md,
        child: this,
      ),
    );
  }
  
  /// Add elevation with shadow
  Widget withElevation(double elevation) {
    return Material(
      elevation: elevation,
      borderRadius: AppBorderRadius.md,
      child: this,
    );
  }
  
  /// Add animated scale on tap
  Widget withScale({VoidCallback? onTap}) {
    return GestureDetector(
      onTapDown: (_) {},
      onTapUp: (_) => onTap?.call(),
      onTapCancel: () {},
      child: AnimatedScale(
        scale: 1.0,
        duration: AppDuration.quick,
        child: this,
      ),
    );
  }
}

/// Responsive breakpoints
class AppBreakpoints {
  AppBreakpoints._();
  
  static const double mobile = 480;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double widescreen = 1440;
}

/// Helper for responsive design
class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppBreakpoints.mobile;
  }
  
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppBreakpoints.mobile && width < AppBreakpoints.desktop;
  }
  
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppBreakpoints.desktop;
  }
  
  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) return desktop;
    if (isTablet(context) && tablet != null) return tablet;
    return mobile;
  }
}
