import 'package:digital_jeweller/core/widgets/classic_card.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_colors.dart';
import '../constants/app_design_constants.dart';

/// Premium animated banner widget with glassmorphism effect
/// Supports both light and dark themes with smooth animations
class PremiumAnimatedBanner extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Color>? gradientColors;
  final double height;
  final VoidCallback? onTap;
  final Widget? child;

  const PremiumAnimatedBanner({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.gradientColors,
    this.height = 180,
    this.onTap,
    this.child,
  });

  @override
  State<PremiumAnimatedBanner> createState() => _PremiumAnimatedBannerState();
}

class _PremiumAnimatedBannerState extends State<PremiumAnimatedBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _scaleAnimation = Tween<double>(
      begin: 0.98,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _shimmerAnimation = Tween<double>(
      begin: -2,
      end: 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors =
        widget.gradientColors ??
        (isDark
            ? [AppColors.primaryDark, AppColors.primary, AppColors.primaryLight]
            : [AppColors.primaryLight, AppColors.primary, AppColors.jewelGold]);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              height: widget.height,
              margin: AppDesignConstants.marginCard,
              decoration: BoxDecoration(
                borderRadius: AppDesignConstants.borderRadius,
                boxShadow: AppDesignConstants.getShadow(size: 'L'),
              ),
              child: ClipRRect(
                borderRadius: AppDesignConstants.borderRadius,
                child: Stack(
                  children: [
                    // Gradient Background
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),

                    // Animated shimmer effect
                    Positioned.fill(
                      child: Transform.translate(
                        offset: Offset(_shimmerAnimation.value * 200, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.white.withAlpha(2),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Rotating accent circles
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Transform.rotate(
                        angle: _rotationAnimation.value,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withAlpha(1),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: -30,
                      bottom: -30,
                      child: Transform.rotate(
                        angle: -_rotationAnimation.value,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withAlpha(08),
                          ),
                        ),
                      ),
                    ),

                    // Glassmorphism overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withAlpha(1),
                            Colors.white.withAlpha(05),
                          ],
                        ),
                      ),
                    ),

                    // Content
                    Padding(
                      padding: AppDesignConstants.padding,
                      child:
                          widget.child ??
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.icon != null)
                                Icon(
                                  widget.icon,
                                  size: AppDesignConstants.iconXL,
                                  color: Colors.black.withAlpha(7),
                                ),
                              if (widget.icon != null)
                                SizedBox(height: AppDesignConstants.spaceS),
                              Text(
                                widget.title,
                                style: AppDesignConstants.displayMedium()
                                    .copyWith(
                                      color: Colors.black87,
                                      shadows: [
                                        Shadow(
                                          color: Colors.white.withAlpha(5),
                                          offset: const Offset(1, 1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                              ),
                              if (widget.subtitle != null) ...[
                                SizedBox(height: AppDesignConstants.spaceXS),
                                Expanded(
                                  child: Text(
                                    widget.subtitle!,
                                    style: AppDesignConstants.bodyLarge()
                                        .copyWith(
                                          color: Colors.black54,
                                          shadows: [
                                            Shadow(
                                              color: Colors.white.withAlpha(3),
                                              offset: const Offset(1, 1),
                                              blurRadius: 1,
                                            ),
                                          ],
                                        ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Stats card widget with animation
class AnimatedStatsCard extends StatefulWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  const AnimatedStatsCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  State<AnimatedStatsCard> createState() => _AnimatedStatsCardState();
}

class _AnimatedStatsCardState extends State<AnimatedStatsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDesignConstants.duration,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.primary;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: ClassicCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: AppDesignConstants.paddingM,
                decoration: BoxDecoration(
                  color: color.withAlpha(1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  size: AppDesignConstants.icon,
                  color: color,
                ),
              ),
            ),
            // SizedBox(height: AppDesignConstants.spaceS),
            Text(
              widget.value,
              style: AppDesignConstants.headlineMedium().copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDesignConstants.spaceXS),
            Text(
              widget.label,
              style: AppDesignConstants.bodySmall(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Gradient banner with particles effect
class GradientParticleBanner extends StatefulWidget {
  final String title;
  final String? subtitle;
  final double height;
  final Widget? trailing;

  const GradientParticleBanner({
    super.key,
    required this.title,
    this.subtitle,
    this.height = 200,
    this.trailing,
  });

  @override
  State<GradientParticleBanner> createState() => _GradientParticleBannerState();
}

class _GradientParticleBannerState extends State<GradientParticleBanner>
    with TickerProviderStateMixin {
  late List<AnimationController> _particleControllers;
  late List<Animation<Offset>> _particleAnimations;
  final int particleCount = 15;

  @override
  void initState() {
    super.initState();
    _initializeParticles();
  }

  void _initializeParticles() {
    _particleControllers = List.generate(
      particleCount,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 3000 + (index * 200)),
      )..repeat(),
    );

    _particleAnimations = _particleControllers.map((controller) {
      final random = math.Random();
      return Tween<Offset>(
        begin: Offset(random.nextDouble() * 2 - 1, 1.5),
        end: Offset(random.nextDouble() * 2 - 1, -1.5),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _particleControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: AppDesignConstants.marginCard,
      decoration: BoxDecoration(
        borderRadius: AppDesignConstants.borderRadius,
        gradient: AppColors.getPremiumGradient(context),
        boxShadow: AppDesignConstants.getShadow(size: 'XL'),
      ),
      child: ClipRRect(
        borderRadius: AppDesignConstants.borderRadius,
        child: Stack(
          children: [
            // Animated particles
            ...List.generate(particleCount, (index) {
              return AnimatedBuilder(
                animation: _particleAnimations[index],
                builder: (context, child) {
                  return Positioned(
                    left:
                        (MediaQuery.of(context).size.width * 0.5) +
                        (_particleAnimations[index].value.dx * 100),
                    top:
                        widget.height * 0.5 +
                        (_particleAnimations[index].value.dy * 100),
                    child: Container(
                      width: 4 + (index % 3) * 2,
                      height: 4 + (index % 3) * 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withAlpha(3),
                      ),
                    ),
                  );
                },
              );
            }),

            // Content
            Padding(
              padding: AppDesignConstants.padding,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: AppDesignConstants.displayMedium().copyWith(
                            color: Colors.black87,
                          ),
                        ),
                        if (widget.subtitle != null) ...[
                          SizedBox(height: AppDesignConstants.spaceS),
                          Text(
                            widget.subtitle!,
                            style: AppDesignConstants.bodyLarge().copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (widget.trailing != null) widget.trailing!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
