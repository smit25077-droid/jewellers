import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Common Loading Widget
class CommonLoading extends StatelessWidget {
  final String? message;
  final Color? color;
  final double size;

  const CommonLoading({super.key, this.message, this.color, this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   width: size,
            //   height: size,
            //   child: Image.asset('assets/loading/load.gif'),
            // ),
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(),
            ),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Small Loading Indicator
class SmallLoading extends StatelessWidget {
  final Color? color;
  final double size;

  const SmallLoading({super.key, this.color, this.size = 20.0});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500), // smooth half-second transition
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
          strokeWidth: 2,
        ),
      ),
    );
  }
}

/// Loading Button Widget
class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;

  const LoadingButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: textColor ?? Colors.black,
          disabledBackgroundColor: (backgroundColor ?? AppColors.primary)
              .withOpacity(0.6),
        ),
        child: isLoading
            ? const SmallLoading(color: Colors.black)
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? Colors.black,
                ),
              ),
      ),
    );
  }
}
