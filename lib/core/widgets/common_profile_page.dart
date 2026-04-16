import 'dart:math' as math;

import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/classic_card.dart';
import '../../../core/widgets/common_dialogs.dart';
import '../../../core/constants/app_routes.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  Wave clipper for the hero header bottom edge
// ─────────────────────────────────────────────────────────────────────────────
class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height - 20,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 40,
      size.width,
      size.height - 10,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_WaveClipper oldClipper) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
//  Main Page  (StatefulWidget for animations)
// ─────────────────────────────────────────────────────────────────────────────
class CommonProfilePage extends StatefulWidget {
  const CommonProfilePage({super.key});

  @override
  State<CommonProfilePage> createState() => _CommonProfilePageState();
}

class _CommonProfilePageState extends State<CommonProfilePage>
    with TickerProviderStateMixin {
  late AnimationController _entryCtrl;
  late AnimationController _pulseCtrl;

  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _scaleAnim;
  late Animation<double> _pulseAnim;
  // final _auth = Get.put(AuthController());
  // AuthController get _auth => Get.put(AuthController());

  final _auth = sl<AuthController>();


  @override
  void initState() {
    super.initState();

    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    if (!Get.testMode) {
      _pulseCtrl.repeat(reverse: true);
    }

    _fadeAnim = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic));
    _scaleAnim = Tween<double>(
      begin: 0.80,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.elasticOut));
    _pulseAnim = Tween<double>(
      begin: 0.9,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _entryCtrl.forward();
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = _auth.user.value;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0E0E0E)
          : const Color(0xFFF4F0E8),
      body: SingleChildScrollView(
        // physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // ── HERO ─────────────────────────────────────────────────────
            _buildHero(context, userData, isDark, screenSize),

            // ── BODY ─────────────────────────────────────────────────────
            FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                  child: Column(
                    children: [
                      // Name + Badge (below hero overlap)
                      const SizedBox(height: 72),
                      _buildNameSection(context, userData, isDark),
                      const SizedBox(height: 28),

                      // Info Card
                      _buildInfoCard(context, userData, isDark),
                      const SizedBox(height: 20),

                      // Preferences Card
                      _buildPrefsCard(context, isDark),
                      const SizedBox(height: 20),

                      // Account Card (Banner Mgmt)
                      _buildAccountCard(context, isDark),
                      const SizedBox(height: 28),

                      // Logout
                      _buildLogoutButton(context, isDark),
                      const SizedBox(height: 20),

                      // Footer
                      _buildFooter(context, isDark),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  HERO
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildHero(
    BuildContext context,
    dynamic userData,
    bool isDark,
    Size screenSize,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ── Gradient + Wave background ──────────────────────────────────
        ClipPath(
          clipper: _WaveClipper(),
          child: Container(
            height: 260,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        const Color(0xFF1C1400),
                        const Color(0xFF3E2D00),
                        const Color(0xFF7A5C0A),
                      ]
                    : [
                        const Color(0xFF6B4E00),
                        const Color(0xFFB8920A),
                        const Color(0xFFE8C935),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Diamond lattice decoration
                ..._buildDiamondPattern(screenSize),

                // Top bar
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Back
                        // _glassButton(
                        //   icon: Icons.arrow_back_ios_new_rounded,
                        //   onTap: () => Get.back(),
                        // ),
                        // Title
                        Text(
                          'Profile',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        // Placeholder to centre the title
                        // const SizedBox(width: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Pulsing glow ring + Avatar ──────────────────────────────────
        Positioned(
          bottom: -66,
          left: 0,
          right: 0,
          child: Center(
            child: ScaleTransition(
              scale: _scaleAnim,
              child: _buildAvatar(context, userData, isDark),
            ),
          ),
        ),
      ],
    );
  }

  // Diamond lattice scattered in the hero background
  List<Widget> _buildDiamondPattern(Size screen) {
    const positions = [
      Offset(0.08, 0.15),
      Offset(0.22, 0.55),
      Offset(0.72, 0.10),
      Offset(0.88, 0.55),
      Offset(0.50, 0.30),
      Offset(0.35, 0.75),
      Offset(0.65, 0.70),
    ];
    return positions.map((rel) {
      final size = 8.0 + (rel.dx * 16);
      return Positioned(
        left: rel.dx * screen.width,
        top: rel.dy * 260,
        child: Transform.rotate(
          angle: math.pi / 4,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
                width: 1.2,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  AVATAR with multi-ring glow
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildAvatar(BuildContext context, dynamic userData, bool isDark) {
    final initials = _getInitials(userData?.name ?? '-');
    return AnimatedBuilder(
      animation: _pulseAnim,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow ring (pulsing)
            Transform.scale(
              scale: _pulseAnim.value,
              child: Container(
                width: 136,
                height: 136,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.35),
                      AppColors.primary.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            // Mid ring
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.5),
                  width: 2,
                ),
              ),
            ),
            // Inner avatar
            Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFE566),
                    Color(0xFFD4AF37),
                    Color(0xFFAA8A2C),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF1C1C1C)
                      : const Color(0xFFF4F0E8),
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.6),
                    blurRadius: 28,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  initials,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  NAME + ROLE SECTION
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildNameSection(
    BuildContext context,
    dynamic userData,
    bool isDark,
  ) {
    final role = userData?.role ?? '-';
    final roleColor = _getRoleColor(role);

    return Column(
      children: [
        // Name with subtle shimmer underline
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFD4AF37), Color(0xFFFFE566), Color(0xFFAA8A2C)],
          ).createShader(bounds),
          child: Text(
            userData?.name ?? '-',
            style: GoogleFonts.playfairDisplay(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white, // masked by shader
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Role pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                roleColor.withValues(alpha: 0.18),
                roleColor.withValues(alpha: 0.10),
              ],
            ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: roleColor.withValues(alpha: 0.5),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: roleColor.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_getRoleIcon(role), size: 13, color: roleColor),
              const SizedBox(width: 6),
              Text(
                _getRoleDisplayName(role).toUpperCase(),
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: roleColor,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  INFO CARD  (glassmorphism style)
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildInfoCard(BuildContext context, dynamic userData, bool isDark) {
    return _premiumCard(
      context,
      isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader(
            context,
            isDark,
            icon: Icons.person_outline,
            label: 'Personal Info',
          ),
          const SizedBox(height: 18),
          _infoRow(
            context,
            isDark,
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: userData?.phone ?? '-',
            accent: const Color(0xFF34C759),
          ),
          _infoDivider(isDark),
          _infoRow(
            context,
            isDark,
            icon: Icons.email_outlined,
            label: 'Email',
            value: userData?.email ?? '-',
            accent: const Color(0xFF007AFF),
          ),
          if (userData?.jeweller?.code != null) ...[
            _infoDivider(isDark),
            _infoRow(
              context,
              isDark,
              icon: Icons.qr_code_2_outlined,
              label: 'Jeweller Code',
              value: userData?.jeweller?.code ?? '-',
              accent: AppColors.primary,
            ),
          ],
          if (userData?.jeweller?.name != null) ...[
            _infoDivider(isDark),
            _infoRow(
              context,
              isDark,
              icon: Icons.storefront_outlined,
              label: 'Store Name',
              value: userData?.jeweller?.name ?? '-',
              accent: const Color(0xFFFF9500),
            ),
          ],
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  PREFERENCES CARD
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildPrefsCard(BuildContext context, bool isDark) {
    return _premiumCard(
      context,
      isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader(
            context,
            isDark,
            icon: Icons.tune_outlined,
            label: 'Preferences',
          ),
          const SizedBox(height: 6),
          _menuTile(
            context,
            isDark,
            icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            label: isDark ? 'Light Mode' : 'Dark Mode',
            sublabel: 'Switch app appearance',
            gradientColors: const [Color(0xFF7C5CBF), Color(0xFF9C7CDF)],
            isFirst: true,
            isLast: false,
            onTap: () => Get.changeThemeMode(
              Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
            ),
          ),
          _menuTile(
            context,
            isDark,
            icon: Icons.edit_note_rounded,
            label: 'Edit Profile',
            sublabel: 'Update your information',
            gradientColors: const [Color(0xFF007AFF), Color(0xFF34AADC)],
            isFirst: false,
            isLast: true,
            onTap: () => CommonDialogs.showSuccess('Edit profile coming soon'),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  ACCOUNT CARD
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildAccountCard(BuildContext context, bool isDark) {
    return _premiumCard(
      context,
      isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader(
            context,
            isDark,
            icon: Icons.manage_accounts_outlined,
            label: 'Account',
          ),
          const SizedBox(height: 6),
          _menuTile(
            context,
            isDark,
            icon: Icons.photo_library_outlined,
            label: 'Banner Management',
            sublabel: 'Manage dashboard banners',
            gradientColors: const [Color(0xFFFF6B35), Color(0xFFFF9500)],
            isFirst: true,
            isLast: true,
            onTap: () => Get.toNamed(AppRoutes.adminAddBanner),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  LOGOUT  (gradient filled button)
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildLogoutButton(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () async {
        final confirmed = await CommonDialogs.showLogoutDialog(context);
        if (confirmed) {
          _auth.logout();
          Get.offAllNamed(AppRoutes.login);
        }
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [Color(0xFFE53935), Color(0xFFC62828)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.error.withValues(alpha: 0.40),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              'Sign Out',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  FOOTER
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildFooter(BuildContext context, bool isDark) {
    return Column(
      children: [
        // Gem divider
        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppColors.primary.withValues(alpha: 0.25),
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.diamond_outlined,
                color: AppColors.primary.withValues(alpha: 0.5),
                size: 16,
              ),
            ),
            Expanded(
              child: Divider(
                color: AppColors.primary.withValues(alpha: 0.25),
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Digital Jeweller  •  v1.0.0',
          style: GoogleFonts.outfit(
            fontSize: 12,
            color: ClassicTheme.getTextSecondary(
              context,
            ).withValues(alpha: 0.55),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  SHARED COMPONENT: Premium Card wrapper
  // ─────────────────────────────────────────────────────────────────────────
  Widget _premiumCard(
    BuildContext context,
    bool isDark, {
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1C1C1C).withValues(alpha: 0.95)
            : Colors.white.withValues(alpha: 0.97),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: isDark
              ? AppColors.primary.withValues(alpha: 0.15)
              : AppColors.primary.withValues(alpha: 0.12),
          width: 1.5,
        ),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.07),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
      ),
      child: child,
    );
  }

  // Card header row
  Widget _cardHeader(
    BuildContext context,
    bool isDark, {
    required IconData icon,
    required String label,
  }) {
    return Row(
      children: [
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [Color(0xFFD4AF37), Color(0xFFFFE566)],
          ).createShader(b),
          child: Icon(icon, size: 18, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Text(
          label.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            letterSpacing: 1.4,
          ),
        ),
      ],
    );
  }

  // Info row (phone, email …)
  Widget _infoRow(
    BuildContext context,
    bool isDark, {
    required IconData icon,
    required String label,
    required String value,
    required Color accent,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: isDark ? 0.18 : 0.10),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: accent.withValues(alpha: 0.25),
                width: 1,
              ),
            ),
            child: Icon(icon, size: 20, color: accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: ClassicTheme.getTextSecondary(context),
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ClassicTheme.getTextPrimary(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      color: isDark
          ? Colors.white.withValues(alpha: 0.06)
          : Colors.black.withValues(alpha: 0.05),
    );
  }

  // Menu tile (settings style)
  Widget _menuTile(
    BuildContext context,
    bool isDark, {
    required IconData icon,
    required String label,
    required String sublabel,
    required List<Color> gradientColors,
    required bool isFirst,
    required bool isLast,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(12) : Radius.zero,
          bottom: isLast ? const Radius.circular(12) : Radius.zero,
        ),
        splashColor: gradientColors[0].withValues(alpha: 0.08),
        highlightColor: gradientColors[0].withValues(alpha: 0.04),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 2),
          child: Row(
            children: [
              // Gradient icon box
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[0].withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              // Labels
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: ClassicTheme.getTextPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      sublabel,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: ClassicTheme.getTextSecondary(context),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow with gradient tint
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: gradientColors[0].withValues(
                    alpha: isDark ? 0.15 : 0.08,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: gradientColors[0],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  HELPERS
  // ─────────────────────────────────────────────────────────────────────────
  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return 'U';
  }

  String _getRoleDisplayName(String role) {
    switch (role.toLowerCase()) {
      case 'master_admin':
        return 'Master Admin';
      case 'jewellers_admin':
        return 'Jeweller Admin';
      case 'customer':
        return 'Customer';
      default:
        return role;
    }
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'master_admin':
        return const Color(0xFFE53935);
      case 'jewellers_admin':
        return AppColors.primary;
      case 'customer':
        return const Color(0xFF34C759);
      default:
        return AppColors.primary;
    }
  }

  IconData _getRoleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'master_admin':
        return Icons.admin_panel_settings_rounded;
      case 'jewellers_admin':
        return Icons.storefront_rounded;
      case 'customer':
        return Icons.person_rounded;
      default:
        return Icons.badge_rounded;
    }
  }
}
