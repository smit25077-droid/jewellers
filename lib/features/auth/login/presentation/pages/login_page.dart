import 'dart:ui';
import 'dart:math';
import 'package:digital_jeweller/core/theme/app_colors.dart';
import 'package:digital_jeweller/core/widgets/common_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digital_jeweller/core/utils/input_formatters.dart';
import 'package:flutter/services.dart';
import '../controllers/login_controller.dart';

class LoginPage extends GetWidget<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return _buildWebLogin(context, isDark);
          } else {
            return _buildMobileLogin(context, isDark);
          }
        },
      ),
    );
  }

  Widget _buildMobileLogin(BuildContext context, bool isDark) {
    return Stack(
      children: [
        // Background Hero Image
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/luxury_jewelry_mobile_login_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Animated mesh gradient for depth
        AnimatedBuilder(
          animation: controller.backgroundAnimation,
          builder: (context, child) {
            return Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: CustomPaint(
                  painter: _MeshGradientPainter(
                    animation: controller.backgroundAnimation.value,
                    isDark: true,
                  ),
                ),
              ),
            );
          },
        ),

        // // Floating orbs (reduced count for better aesthetics)
        // ...List.generate(
        //   5,
        //   (index) =>
        //       _FloatingOrb(delay: index * 0.8, isDark: isDark, index: index),
        // ),
        //
        // // Floating particles
        // ...List.generate(
        //   15,
        //   (index) => _FloatingParticle(delay: index * 0.4, isDark: isDark),
        // ),

        // Main content
        Positioned.fill(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Center(
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: controller.fadeAnimation,
                      child: SlideTransition(
                        position: controller.slideAnimation,
                        child: _buildLoginCard(context, isDark),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWebLogin(BuildContext context, bool isDark) {
    return Stack(
      children: [
        Row(
          children: [
            // Left side: Premium Hero Section
            Expanded(
              flex: 10,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/web_login_bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.2),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 60,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeTransition(
                        opacity: controller.fadeAnimation,
                        child: Text(
                          'PREMIUM QUALITY',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            color: AppColors.gold,
                            letterSpacing: 4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeTransition(
                        opacity: controller.fadeAnimation,
                        child: Text(
                          GetPlatform.isWeb
                              ? 'MASTER\nADMINISTRATION'
                              : 'JEWELLER\nADMINISTRATION',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 84,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.0,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      FadeTransition(
                        opacity: controller.fadeAnimation,
                        child: Container(
                          height: 4,
                          width: 100,
                          color: AppColors.gold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      FadeTransition(
                        opacity: controller.fadeAnimation,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: Text(
                            'Control and manage your digital jewellery ecosystem with our state-of-the-art administrative portal.',
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              color: Colors.white70,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Right side: Elegant Login Form
            Expanded(
              flex: 10,
              child: Container(
                color: isDark ? const Color(0xFF0F0F0F) : Colors.white,
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 60,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            GetPlatform.isWeb
                                ? 'SECURE ADMIN LOGIN'
                                : 'SECURE JEWELLER LOGIN',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.gold,
                              letterSpacing: 3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Welcome back to your dashboard',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 60),

                          if (!GetPlatform.isWeb) ...[
                            _buildAnimatedTextField(
                              context,
                              controller: controller.jewellerCodeController,
                              label: 'Jeweller Code',
                              icon: Icons.qr_code_rounded,
                              inputFormatters: [AppInputFormatters.uppercase],
                              textCapitalization: TextCapitalization.characters,
                              delay: 50,
                            ),
                            const SizedBox(height: 32),
                          ],

                          _buildAnimatedTextField(
                            context,
                            controller: controller.phoneController,
                            label: 'Mobile Number',
                            icon: Icons.phone_android_rounded,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              AppInputFormatters.phone,
                              AppInputFormatters.digitsOnly,
                            ],
                            delay: 100,
                          ),
                          const SizedBox(height: 32),
                          _buildAnimatedTextField(
                            context,
                            controller: controller.passwordController,
                            label: 'Password',
                            icon: Icons.lock_outline_rounded,
                            isPassword: true,
                            delay: 200,
                          ),
                          const SizedBox(height: 60),

                          SizedBox(
                            width: double.infinity,
                            height: 65,
                            child: _buildLoginButton(isWeb: true),
                          ),

                          const SizedBox(height: 48),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '© 2026 DIGITAL JEWELLER',
                                style: GoogleFonts.outfit(
                                  fontSize: 11,
                                  color: Colors.grey.withOpacity(0.6),
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                width: 1,
                                height: 10,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                'V1.0.4',
                                style: GoogleFonts.outfit(
                                  fontSize: 11,
                                  color: Colors.grey.withOpacity(0.6),
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Glassmorphic Top Bar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 80,
                color: Colors.black.withOpacity(0.1),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    const Icon(
                      Icons.diamond_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'DIGITAL JEWELLER',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    const Spacer(),
                    _buildNavButton('Support'),
                    const SizedBox(width: 30),
                    _buildNavButton('Contact'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavButton(String title) {
    return TextButton(
      onPressed: () {},
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 14,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          decoration: BoxDecoration(
            color: isDark ? Colors.black.withOpacity(0.4) : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.gold.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WELCOME',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Digital Jeweller',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: !isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                GetPlatform.isWeb ? 'ADMIN PORTAL' : 'JEWELLER',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  color: AppColors.gold.withOpacity(0.95),
                  letterSpacing: 4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                height: 1,
                width: 60,
                color: AppColors.gold.withOpacity(0.5),
              ),
              const SizedBox(height: 40),

              if (!GetPlatform.isWeb) ...[
                _buildAnimatedTextField(
                  context,
                  controller: controller.jewellerCodeController,
                  label: 'Jeweller Code',
                  icon: Icons.qr_code_rounded,
                  inputFormatters: [AppInputFormatters.uppercase],
                  textCapitalization: TextCapitalization.characters,
                  delay: 200,
                ),
                const SizedBox(height: 20),
              ],

              _buildAnimatedTextField(
                context,
                controller: controller.phoneController,
                label: 'Mobile Number',
                icon: Icons.phone_android_rounded,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  AppInputFormatters.phone,
                  AppInputFormatters.digitsOnly,
                ],
                delay: 400,
              ),
              const SizedBox(height: 20),
              _buildAnimatedTextField(
                context,
                controller: controller.passwordController,
                label: 'Password',
                icon: Icons.lock_outline_rounded,
                isPassword: true,
                delay: 600,
              ),

              const SizedBox(height: 48),

              // Animated login button
              _buildLoginButton(),

              const SizedBox(height: 32),

              // Version info
              Center(
                child: Text(
                  'SYSTEM VERSION 1.0.0',
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    color: !isDark ? Colors.white : Colors.black,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildLoginButton({bool isWeb = false}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, animValue, child) {
        return Transform.scale(
          scale: animValue,
          child: Obx(
            () => Container(
              decoration: BoxDecoration(
                gradient: AppColors.goldGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  controller.isLoading.value
                      ? null
                      : controller.login(
                          controller.jewellerCodeController.text.trim(),
                          controller.phoneController.text.trim(),
                          controller.passwordController.text.trim(),
                          platform: GetPlatform.isWeb ? 'web' : 'android',
                        );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: controller.isLoading.value
                    ? const CommonLoading()
                    : Text(
                        'LOGIN',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 3,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    int delay = 0,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800 + delay),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: isPassword
                ? Obx(
                    () => _buildTextField(
                      context,
                      controller,
                      label,
                      icon,
                      isPassword,
                      keyboardType,
                      inputFormatters,
                      textCapitalization,
                    ),
                  )
                : _buildTextField(
                    context,
                    controller,
                    label,
                    icon,
                    isPassword,
                    keyboardType,
                    inputFormatters,
                    textCapitalization,
                  ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(
    BuildContext context,
    TextEditingController controller,
    String label,
    IconData icon,
    bool isPassword,
    TextInputType keyboardType,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loginController = Get.find<LoginController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.black.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !loginController.isPasswordVisible.value,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        style: GoogleFonts.outfit(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.outfit(
            color: AppColors.primary.withOpacity(0.7),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(icon, color: AppColors.primary, size: 22),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    loginController.isPasswordVisible.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.primary.withOpacity(0.5),
                    size: 20,
                  ),
                  onPressed: () => loginController.isPasswordVisible.toggle(),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }
}

// Custom painters and helper widgets (copied from previous login_screen.dart)
class _MeshGradientPainter extends CustomPainter {
  final double animation;
  final bool isDark;
  _MeshGradientPainter({required this.animation, required this.isDark});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (int i = 0; i < 5; i++) {
      final offset = Offset(
        size.width * (0.2 + i * 0.2 + animation * 0.1),
        size.height * (0.3 + (i % 2) * 0.4 + animation * 0.1),
      );
      paint.shader = RadialGradient(
        colors: [
          AppColors.primary.withAlpha(isDark ? 08 : 05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: offset, radius: 200));
      canvas.drawCircle(offset, 200, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}





class _FloatingOrb extends StatefulWidget {
  final double delay;
  final bool isDark;
  final int index;
  const _FloatingOrb({
    required this.delay,
    required this.isDark,
    required this.index,
  });
  @override
  State<_FloatingOrb> createState() => _FloatingOrbState();
}

class _FloatingOrbState extends State<_FloatingOrb>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 4 + widget.index),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: 50 + 100 * sin(widget.delay + _controller.value * 2 * pi),
          top: 100 + 100 * cos(widget.delay + _controller.value * 2 * pi),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha(10),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FloatingParticle extends StatefulWidget {
  final double delay;
  final bool isDark;
  const _FloatingParticle({required this.delay, required this.isDark});
  @override
  State<_FloatingParticle> createState() => _FloatingParticleState();
}

class _FloatingParticleState extends State<_FloatingParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3 + widget.delay.toInt()),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 100 * widget.delay % MediaQuery.of(context).size.width,
      bottom: 0,
      child: FadeTransition(
        opacity: _controller,
        child: Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
