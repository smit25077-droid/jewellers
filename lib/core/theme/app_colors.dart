import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class AppColors {
  // ==================== PRIMARY COLORS ====================
  /// Premium Jewellery Gold Palette
  static const Color primary = Color(0xFFCFB53B); // Old Gold
  static const Color primaryDark = Color(0xFFAA8A2C); // Dark Gold
  static const Color primaryLight = Color(0xFFE6D27E); // Light Gold
  static const Color jewelGold = Color(0xFFD4AF37); // Classic Metallic Gold

  // ==================== SECONDARY / ACCENT ====================
  static const Color secondary = Color(0xFF0D47A1); // Deep Blue
  static const Color accent = Color(0xFFFFD54F); // Amber 300
  static const Color accentDark = Color(0xFFFFC107); // Amber 500

  // ==================== BACKGROUNDS - LIGHT THEME ====================
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color surfaceLight = Colors.white;
  static const Color cardLight = Colors.white;
  static const Color overlayLight = Color(0xFFF5F5F5);
  static const Color dividerLight = Color(0xFFE0E0E0);

  // ==================== BACKGROUNDS - DARK THEME ====================
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF2C2C2C);
  static const Color overlayDark = Color(0xFF2A2A2A);
  static const Color dividerDark = Color(0xFF424242);

  // ==================== TEXT - LIGHT THEME ====================
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textBodyLight = Color(0xFF424242);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textDisabledLight = Color(0xFFBDBDBD);

  // ==================== TEXT - DARK THEME ====================
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textBodyDark = Color(0xFFE0E0E0);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color textDisabledDark = Color(0xFF616161);

  // ==================== STATUS COLORS ====================
  static const Color success = Color(0xFF4CAF50);
  static const Color successDark = Color(0xFF388E3C);
  static const Color error = Color(0xFFE53935);
  static const Color errorDark = Color(0xFFC62828);
  static const Color warning = Color(0xFFFB8C00);
  static const Color warningDark = Color(0xFFE65100);
  static const Color info = Color(0xFF1E88E5);
  static const Color infoDark = Color(0xFF1565C0);

  // ==================== PREMIUM JEWELLERY SPECIFIC ====================
  static const Color gold = Color(0xFFD4AF37);
  static const Color silver = Color(0xFFC0C0C0);
  static const Color platinum = Color(0xFFE5E4E2);
  static const Color diamond = Color(0xFFB9F2FF);
  static const Color ruby = Color(0xFFE0115F);
  static const Color emerald = Color(0xFF50C878);
  static const Color sapphire = Color(0xFF0F52BA);

  // ==================== GRADIENT COLORS ====================
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFCFB53B), Color(0xFFAA8A2C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGoldGradient = LinearGradient(
    colors: [Color(0xFFAA8A2C), Color(0xFF8B7323), Color(0xFF6B5A1C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumGradientLight = LinearGradient(
    colors: [Color(0xFFFFD54F), Color(0xFFCFB53B), Color(0xFFD4AF37)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumGradientDark = LinearGradient(
    colors: [Color(0xFFCFB53B), Color(0xFFAA8A2C), Color(0xFF8B7323)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ==================== SHADOW COLORS ====================
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x80000000);

  // ==================== HELPER METHODS ====================
  /// Get text color based on theme brightness
  static Color getTextColor(BuildContext context, {bool secondary = false}) {
    final isDark = Theme.of(navigatorKey.currentContext!).brightness == Brightness.dark;
    if (secondary) {
      return isDark ? textSecondaryDark : textSecondaryLight;
    }
    return isDark ? textBodyDark : textBodyLight;
  }

  /// Get background color based on theme brightness
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(navigatorKey.currentContext!).brightness == Brightness.dark
        ? backgroundDark
        : backgroundLight;
  }

  /// Get card color based on theme brightness
  static Color getCardColor(BuildContext context) {
    return Theme.of(navigatorKey.currentContext!).brightness == Brightness.dark
        ? cardDark
        : cardLight;
  }

  /// Get surface color based on theme brightness
  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(navigatorKey.currentContext!).brightness == Brightness.dark
        ? surfaceDark
        : surfaceLight;
  }

  /// Get divider color based on theme brightness
  static Color getDividerColor(BuildContext context) {
    return Theme.of(navigatorKey.currentContext!).brightness == Brightness.dark
        ? dividerDark
        : dividerLight;
  }

  /// Get premium gradient based on theme brightness
  static LinearGradient getPremiumGradient(BuildContext context) {
    return Theme.of(navigatorKey.currentContext!).brightness == Brightness.dark
        ? premiumGradientDark
        : premiumGradientLight;
  }
  /// Get card shadow color based on theme brightness
  static Color getCardShadowColor(BuildContext context) {
    return Theme.of(navigatorKey.currentContext!).brightness == Brightness.dark
        ? shadowDark
        : shadowLight;
  }

}
