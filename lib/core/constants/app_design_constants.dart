import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design constants for consistent spacing, padding, margins, and text styles
/// throughout the application. Use these values to ensure symmetrical design.
class AppDesignConstants {
  // ==================== SPACING ====================
  /// Extra small spacing (4px)
  static const double spaceXS = 4.0;

  /// Small spacing (8px)
  static const double spaceS = 8.0;

  /// Medium spacing (12px)
  static const double spaceM = 12.0;

  /// Default spacing (16px) - Most commonly used
  static const double space = 16.0;

  /// Large spacing (24px)
  static const double spaceL = 24.0;

  /// Extra large spacing (32px)
  static const double spaceXL = 32.0;

  /// Extra extra large spacing (48px)
  static const double spaceXXL = 48.0;

  // ==================== PADDING ====================
  /// Extra small padding
  static const EdgeInsets paddingXS = EdgeInsets.all(spaceXS);

  /// Small padding
  static const EdgeInsets paddingS = EdgeInsets.all(spaceS);

  /// Medium padding
  static const EdgeInsets paddingM = EdgeInsets.all(spaceM);

  /// Default padding
  static const EdgeInsets padding = EdgeInsets.all(space);

  /// Large padding
  static const EdgeInsets paddingL = EdgeInsets.all(spaceL);

  /// Extra large padding
  static const EdgeInsets paddingXL = EdgeInsets.all(spaceXL);

  /// Horizontal padding (default)
  static const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(
    horizontal: space,
  );

  /// Vertical padding (default)
  static const EdgeInsets paddingVertical = EdgeInsets.symmetric(
    vertical: space,
  );

  /// Screen padding (horizontal + vertical)
  static const EdgeInsets paddingScreen = EdgeInsets.symmetric(
    horizontal: space,
    vertical: spaceM,
  );

  /// Card padding
  static const EdgeInsets paddingCard = EdgeInsets.all(space);

  /// List item padding
  static const EdgeInsets paddingListItem = EdgeInsets.symmetric(
    horizontal: space,
    vertical: spaceM,
  );

  // ==================== MARGINS ====================
  /// Extra small margin
  static const EdgeInsets marginXS = EdgeInsets.all(spaceXS);

  /// Small margin
  static const EdgeInsets marginS = EdgeInsets.all(spaceS);

  /// Medium margin
  static const EdgeInsets marginM = EdgeInsets.all(spaceM);

  /// Default margin
  static const EdgeInsets margin = EdgeInsets.all(space);

  /// Large margin
  static const EdgeInsets marginL = EdgeInsets.all(spaceL);

  /// Card margin (horizontal + vertical)
  static const EdgeInsets marginCard = EdgeInsets.symmetric(
    horizontal: space,
    vertical: spaceS,
  );

  // ==================== BORDER RADIUS ====================
  /// Extra small border radius (4px)
  static const double radiusXS = 4.0;

  /// Small border radius (8px)
  static const double radiusS = 8.0;

  /// Medium border radius (12px)
  static const double radiusM = 12.0;

  /// Default border radius (16px)
  static const double radius = 16.0;

  /// Large border radius (20px)
  static const double radiusL = 20.0;

  /// Extra large border radius (24px)
  static const double radiusXL = 24.0;

  /// Circular border radius (999px)
  static const double radiusCircular = 999.0;

  // BorderRadius objects
  static BorderRadius get borderRadiusXS => BorderRadius.circular(radiusXS);
  static BorderRadius get borderRadiusS => BorderRadius.circular(radiusS);
  static BorderRadius get borderRadiusM => BorderRadius.circular(radiusM);
  static BorderRadius get borderRadius => BorderRadius.circular(radius);
  static BorderRadius get borderRadiusL => BorderRadius.circular(radiusL);
  static BorderRadius get borderRadiusXL => BorderRadius.circular(radiusXL);
  static BorderRadius get borderRadiusCircular =>
      BorderRadius.circular(radiusCircular);

  // ==================== ELEVATION ====================
  static const double elevationNone = 0.0;
  static const double elevationXS = 1.0;
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevation = 6.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 12.0;
  static const double elevationXXL = 16.0;

  // ==================== ICON SIZES ====================
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double icon = 28.0;
  static const double iconL = 32.0;
  static const double iconXL = 40.0;
  static const double iconXXL = 48.0;

  // ==================== ANIMATION DURATIONS ====================
  static const Duration durationFast = Duration(milliseconds: 200);
  static const Duration duration = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);
  static const Duration durationVerySlow = Duration(milliseconds: 800);

  // ==================== BUTTON SIZES ====================
  static const double buttonHeightS = 40.0;
  static const double buttonHeight = 50.0;
  static const double buttonHeightL = 56.0;
  static const double buttonHeightXL = 64.0;

  static const Size buttonSizeS = Size(double.infinity, buttonHeightS);
  static const Size buttonSize = Size(double.infinity, buttonHeight);
  static const Size buttonSizeL = Size(double.infinity, buttonHeightL);
  static const Size buttonSizeXL = Size(double.infinity, buttonHeightXL);

  // ==================== TEXT STYLES ====================
  /// Display text styles (for large headings)
  static TextStyle displayLarge(BuildContext context) =>
      GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black87,
      );

  static TextStyle displayMedium(BuildContext context) =>
      GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black87,
      );

  static TextStyle displaySmall(BuildContext context) =>
      GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black87,
      );

  /// Headline text styles (for section headers)
  static TextStyle headlineLarge(BuildContext context) => GoogleFonts.outfit(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87,
  );

  static TextStyle headlineMedium(BuildContext context) => GoogleFonts.outfit(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87,
  );

  static TextStyle headlineSmall(BuildContext context) => GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87,
  );

  /// Title text styles (for card titles, list items)
  static TextStyle titleLarge(BuildContext context) => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87,
  );

  static TextStyle titleMedium(BuildContext context) => GoogleFonts.outfit(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87,
  );

  static TextStyle titleSmall(BuildContext context) => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87,
  );

  /// Body text styles (for regular content)
  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : Colors.black87,
  );

  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : Colors.black87,
  );

  static TextStyle bodySmall(BuildContext context) => GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white60
        : Colors.black54,
  );

  /// Label text styles (for input labels, captions)
  static TextStyle labelLarge(BuildContext context) => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white60
        : Colors.black54,
  );

  static TextStyle labelMedium(BuildContext context) => GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white54
        : Colors.black45,
  );

  static TextStyle labelSmall(BuildContext context) => GoogleFonts.outfit(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white38
        : Colors.black38,
  );

  // ==================== CUSTOM TEXT STYLES ====================
  /// Button text style
  static TextStyle buttonText(BuildContext context) => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );

  /// Input text style
  static TextStyle inputText(BuildContext context) => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87,
  );

  /// Error text style
  static TextStyle errorText(BuildContext context) => GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.error,
  );

  // ==================== BOX SHADOWS ====================
  static List<BoxShadow> get shadowS => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get shadowM => [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get shadowL => [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 12,
      offset: const Offset(0, 6),
    ),
  ];

  static List<BoxShadow> get shadowXL => [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];

  // Dark theme shadows
  static List<BoxShadow> get shadowDarkS => [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get shadowDarkM => [
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get shadowDarkL => [
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      blurRadius: 12,
      offset: const Offset(0, 6),
    ),
  ];

  /// Get appropriate shadow based on theme
  static List<BoxShadow> getShadow(BuildContext context, {String size = 'M'}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (size) {
      case 'S':
        return isDark ? shadowDarkS : shadowS;
      case 'L':
        return isDark ? shadowDarkL : shadowL;
      case 'XL':
        return isDark ? shadowDarkL : shadowXL;
      default:
        return isDark ? shadowDarkM : shadowM;
    }
  }
}
