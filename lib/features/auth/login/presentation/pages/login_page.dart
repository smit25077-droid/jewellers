import 'dart:ui';
import 'dart:math';
import 'package:digital_jeweller/core/theme/app_colors.dart';
import 'package:digital_jeweller/core/widgets/classic_card.dart';
import 'package:digital_jeweller/core/widgets/common_button.dart';
import 'package:digital_jeweller/core/widgets/common_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';

class LoginPage extends GetWidget<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Base animated gradient background
          AnimatedBuilder(
            animation: controller.backgroundAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            Color.lerp(
                              const Color(0xFF0A0A0A),
                              const Color(0xFF1A1A2E),
                              controller.backgroundAnimation.value,
                            )!,
                            Color.lerp(
                              const Color(0xFF16213E),
                              const Color(0xFF0F3460),
                              controller.backgroundAnimation.value,
                            )!,
                            Color.lerp(
                              const Color(0xFF1A1A2E),
                              const Color(0xFF0A0A0A),
                              controller.backgroundAnimation.value,
                            )!,
                          ]
                        : [
                            Color.lerp(
                              const Color(0xFFF8F9FA),
                              const Color(0xFFE9ECEF),
                              controller.backgroundAnimation.value,
                            )!,
                            Color.lerp(
                              const Color(0xFFFFFFFF),
                              const Color(0xFFF1F3F5),
                              controller.backgroundAnimation.value,
                            )!,
                            Color.lerp(
                              const Color(0xFFE9ECEF),
                              const Color(0xFFF8F9FA),
                              controller.backgroundAnimation.value,
                            )!,
                          ],
                  ),
                ),
              );
            },
          ),

          // Animated mesh gradient overlay
          AnimatedBuilder(
            animation: controller.backgroundAnimation,
            builder: (context, child) {
              return Positioned.fill(
                child: CustomPaint(
                  painter: _MeshGradientPainter(
                    animation: controller.backgroundAnimation.value,
                    isDark: isDark,
                  ),
                ),
              );
            },
          ),

          // Large rotating geometric shapes
          _buildRotatingShape(
            size: 400,
            top: -200,
            right: -200,
            duration: 20,
            isDark: isDark,
            reverse: false,
          ),
          _buildRotatingShape(
            size: 350,
            bottom: -150,
            left: -150,
            duration: 25,
            isDark: isDark,
            reverse: true,
          ),
          _buildRotatingShape(
            size: 250,
            top: size.height * 0.3,
            right: -100,
            duration: 30,
            isDark: isDark,
            reverse: false,
          ),

          // Animated wave patterns
          Positioned.fill(
            child: AnimatedBuilder(
              animation: controller.backgroundAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: _WavePainter(
                    animation: controller.backgroundAnimation.value,
                    isDark: isDark,
                  ),
                );
              },
            ),
          ),

          // Floating orbs with glow
          ...List.generate(
            8,
            (index) =>
                _FloatingOrb(delay: index * 0.5, isDark: isDark, index: index),
          ),

          // Animated grid pattern
          Positioned.fill(
            child: AnimatedBuilder(
              animation: controller.backgroundAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: _GridPainter(
                    animation: controller.backgroundAnimation.value,
                    isDark: isDark,
                  ),
                );
              },
            ),
          ),

          // Floating particles effect
          ...List.generate(
            25,
            (index) => _FloatingParticle(delay: index * 0.3, isDark: isDark),
          ),

          // Animated light rays
          Positioned.fill(
            child: AnimatedBuilder(
              animation: controller.backgroundAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: _LightRaysPainter(
                    animation: controller.backgroundAnimation.value,
                    isDark: isDark,
                  ),
                );
              },
            ),
          ),

          // Main content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: FadeTransition(
                  opacity: controller.fadeAnimation,
                  child: SlideTransition(
                    position: controller.slideAnimation,
                    child: ScaleTransition(
                      scale: controller.scaleAnimation,
                      child: _buildLoginCard(context, isDark),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRotatingShape({
    required double size,
    double? top,
    double? bottom,
    double? left,
    double? right,
    required int duration,
    required bool isDark,
    required bool reverse,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(seconds: duration),
        builder: (context, value, child) {
          return AnimatedBuilder(
            animation: controller.backgroundAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: (reverse ? -value : value) * 6.28 * 2,
                child: Transform.translate(
                  offset: Offset(
                    30 * controller.backgroundAnimation.value,
                    20 * controller.backgroundAnimation.value,
                  ),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primary.withAlpha(15),
                          AppColors.primary.withAlpha(05),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                    child: CustomPaint(
                      painter: _GeometricShapePainter(
                        color: AppColors.primary.withAlpha(1),
                        rotation: value * 6.28,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        onEnd: () {
          // setState(() {});
        },
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context, bool isDark) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 420),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withAlpha(05)
                  : Colors.white.withAlpha(9),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.primary.withAlpha(2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha(15),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
                BoxShadow(
                  color: isDark
                      ? Colors.black.withAlpha(3)
                      : Colors.grey.withAlpha(1),
                  blurRadius: 60,
                  offset: const Offset(0, 30),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated logo
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1500),
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: value * 0.5,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.primary.withAlpha(6),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(4),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.diamond_outlined,
                          size: 56,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),

                // Title with shimmer effect
                Flexible(
                  child: AnimatedBuilder(
                    animation: controller.shimmerAnimation,
                    builder: (context, child) {
                      return ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: [
                              ClassicTheme.getTextPrimary(context),
                              AppColors.primary,
                              ClassicTheme.getTextPrimary(context),
                            ],
                            stops: [
                              (controller.shimmerAnimation.value - 1).clamp(
                                0.0,
                                1.0,
                              ),
                              controller.shimmerAnimation.value.clamp(0.0, 1.0),
                              (controller.shimmerAnimation.value + 1).clamp(
                                0.0,
                                1.0,
                              ),
                            ],
                          ).createShader(bounds);
                        },
                        child: Text(
                          'Digital Jeweller',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Digital Jeweller',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  height: 2,
                  width: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.primary,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 48),

                // Animated text fields
                _buildAnimatedTextField(
                  context,
                  controller: controller.jewellerCodeController,
                  label: 'Jeweller Code',
                  icon: Icons.store_rounded,
                  delay: 200,
                ),
                const SizedBox(height: 24),
                _buildAnimatedTextField(
                  context,
                  controller: controller.phoneController,
                  label: 'Mobile Number',
                  icon: Icons.phone_android_rounded,
                  keyboardType: TextInputType.phone,
                  delay: 400,
                ),
                const SizedBox(height: 24),
                _buildAnimatedTextField(
                  context,
                  controller: controller.passwordController,
                  label: 'Password',
                  icon: Icons.lock_outline_rounded,
                  isPassword: true,
                  delay: 600,
                ),

                const SizedBox(height: 48),

                // Animated login button with GetX
                _buildLoginButton(),

                const SizedBox(height: 32),

                // Version info
                Text(
                  'SYSTEM VERSION 1.0.0',
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: ClassicTheme.getTextSecondary(context),
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, animValue, child) {
        return Transform.scale(
          scale: animValue,
          child: Obx(
            () => CommonButton(
              onPressed: () {
                controller.isLoading.value
                    ? null
                    : controller.login(
                        controller.jewellerCodeController.text.trim(),
                        controller.phoneController.text.trim(),
                        controller.passwordController.text.trim(),
                      );
              },
              child: Center(
                child: controller.isLoading.value
                    ? CommonLoading()
                    : Text(
                        'SIGN IN',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
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
    int delay = 0,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1 * value),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                keyboardType: keyboardType,
                style: TextStyle(
                  color: ClassicTheme.getTextPrimary(context),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: GoogleFonts.outfit(
                    color: ClassicTheme.getTextSecondary(context),
                    fontSize: 14,
                  ),
                  prefixIcon: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: AppColors.primary, size: 20),
                  ),
                  filled: true,
                  fillColor: isDark
                      ? Colors.white.withAlpha(05)
                      : Colors.white.withAlpha(9),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: isDark
                          ? Colors.white.withAlpha(1)
                          : Colors.grey.withAlpha(2),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                ),
              ),
            ),
          ),
        );
      },
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

class _WavePainter extends CustomPainter {
  final double animation;
  final bool isDark;
  _WavePainter({required this.animation, required this.isDark});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = AppColors.primary.withAlpha(isDark ? 1 : 08);
    for (int i = 0; i < 3; i++) {
      final path = Path();
      final waveHeight = 30.0;
      final waveLength = size.width / 2;
      final offset = animation * waveLength + i * 100;
      path.moveTo(0, size.height * 0.5 + i * 50);
      for (double x = 0; x <= size.width; x += 10) {
        final y =
            size.height * 0.5 +
            i * 50 +
            waveHeight * sin((x + offset) * 2 * pi / waveLength);
        path.lineTo(x, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _GridPainter extends CustomPainter {
  final double animation;
  final bool isDark;
  _GridPainter({required this.animation, required this.isDark});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = AppColors.primary.withAlpha(isDark ? 05 : 03);
    final spacing = 50.0;
    final offset = animation * spacing;
    for (double x = -spacing + offset % spacing; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (
      double y = -spacing + offset % spacing;
      y < size.height;
      y += spacing
    ) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _LightRaysPainter extends CustomPainter {
  final double animation;
  final bool isDark;
  _LightRaysPainter({required this.animation, required this.isDark});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primary.withAlpha(isDark ? 05 : 02),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    for (int i = 0; i < 5; i++) {
      final path = Path();
      final startX = size.width * (0.1 + i * 0.2 + animation * 0.05);
      path.moveTo(startX, 0);
      path.lineTo(startX + 100, 0);
      path.lineTo(startX - 100, size.height);
      path.lineTo(startX - 200, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _GeometricShapePainter extends CustomPainter {
  final Color color;
  final double rotation;
  _GeometricShapePainter({required this.color, required this.rotation});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;
    for (int i = 0; i < 6; i++) {
      final angle = i * pi / 3 + rotation;
      canvas.drawCircle(
        Offset(
          center.dx + radius * cos(angle),
          center.dy + radius * sin(angle),
        ),
        radius / 2,
        paint,
      );
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
