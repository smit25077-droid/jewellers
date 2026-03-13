import 'package:flutter/material.dart';

/// Common classic card widget with theme-aware design
/// Used across admin features for consistent look and feel
class ClassicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? width;
  final Color? color;

  const ClassicCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBackground = color ?? (isDark ? const Color(0xFF2C2C2C) : Colors.white);
    final borderColor = isDark
        ? Colors.white.withAlpha(20)
        : Colors.grey.shade200;

    Widget cardContent = Container(
      width: width,
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withAlpha(20)
                : Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: borderColor),
      ),
      child: child,
    );

    if (onTap != null) {
      cardContent = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: cardContent,
      );
    }

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: cardContent,
    );
  }
}

/// Classic info row with icon
class ClassicInfoRow extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color? iconColor;
  final Color? textColor;

  const ClassicInfoRow({
    super.key,
    required this.icon,
    required this.value,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentBrown = isDark
        ? const Color(0xFFB8956A)
        : const Color(0xFF8B6B4E);
    final textSecondary = isDark
        ? const Color(0xFFB0B0B0)
        : const Color(0xFF6B7280);

    return Row(
      children: [
        Icon(icon, size: 20, color: (iconColor ?? accentBrown).withAlpha(150)),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: textColor ?? textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

/// Classic avatar widget
class ClassicAvatar extends StatelessWidget {
  final String name;
  final String? profileImageUrl;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;

  const ClassicAvatar({
    super.key,
    required this.name,
    this.profileImageUrl,
    this.size = 60,
    this.backgroundColor,
    this.textColor,
  });

  String _getInitials(String name) {
    List<String> names = name.split(" ");
    if (names.length >= 2) {
      return "${names[0][0]}${names[1][0]}".toUpperCase();
    } else if (names.isNotEmpty && names[0].isNotEmpty) {
      return names[0][0].toUpperCase();
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentBrown = isDark
        ? const Color(0xFFB8956A)
        : const Color(0xFF8B6B4E);
    final avatarBg = isDark ? const Color(0xFF3A3A3A) : const Color(0xFFF5F5F5);
    final borderColor = isDark
        ? Colors.white.withAlpha(20)
        : Colors.grey.shade200;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? avatarBg,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1),
        image: profileImageUrl != null && profileImageUrl!.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(profileImageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: profileImageUrl == null || profileImageUrl!.isEmpty
          ? Center(
              child: Text(
                _getInitials(name),
                style: TextStyle(
                  fontSize: size * 0.33,
                  fontWeight: FontWeight.w400,
                  color: textColor ?? accentBrown,
                  fontFamily: 'Serif',
                ),
              ),
            )
          : null,
    );
  }
}

/// Classic status badge
class ClassicStatusBadge extends StatelessWidget {
  final String text;
  final Color color;
  final Color? backgroundColor;

  const ClassicStatusBadge({
    super.key,
    required this.text,
    required this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? color.withAlpha(20),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

/// Classic outlined button
class ClassicOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;
  final EdgeInsetsGeometry? margin;

  const ClassicOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.borderColor,
    this.textColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentBrown = isDark
        ? const Color(0xFFB8956A)
        : const Color(0xFF8B6B4E);
    final buttonBorder = isDark
        ? const Color(0xFFB8956A).withAlpha(50)
        : const Color(0xFFD4C4B5);

    return Container(
      margin: margin,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor ?? buttonBorder, width: 1),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: textColor ?? accentBrown),
              const SizedBox(width: 10),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: textColor ?? accentBrown,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper functions for theme-aware colors
class ClassicTheme {
  static Color getAccentBrown(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFFB8956A) : const Color(0xFF8B6B4E);
  }

  static Color getTextPrimary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFFE0E0E0) : const Color(0xFF1A1A1A);
  }

  static Color getTextSecondary(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFFB0B0B0) : const Color(0xFF6B7280);
  }

  static Color getCardBackground(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF2C2C2C) : Colors.white;
  }

  static Color getBorderColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white.withAlpha(1) : Colors.grey.shade200;
  }

  static Color getAvatarBackground(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF3A3A3A) : const Color(0xFFF5F5F5);
  }
}
