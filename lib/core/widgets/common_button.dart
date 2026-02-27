import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart' as nm;

class CommonButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  CommonButton({
    material.Key? key,
    required this.child,
    required this.onPressed,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.backgroundColor,
  }) : super(key: key);

  final ValueNotifier<bool> _isPressed = ValueNotifier<bool>(false);

  void _onTapDown(material.TapDownDetails details) {
    _isPressed.value = true;
  }

  void _onTapUp(material.TapUpDetails details) async {
    onPressed();
    // Keep the pressed state for a split second so the animation is visible
    await Future.delayed(const Duration(milliseconds: 100));
    _isPressed.value = false;
  }

  void _onTapCancel() {
    _isPressed.value = false;
  }

  @override
  Widget build(material.BuildContext context) {
    final bgColor = backgroundColor ?? nm.NeumorphicTheme.baseColor(context);

    return material.GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isPressed,
        builder: (context, isPressed, _) {
          return material.AnimatedScale(
            scale: isPressed ? 0.95 : 1.0,
            duration: const Duration(milliseconds: 150),
            curve: material.Curves.easeOutCubic,
            child: nm.Neumorphic(
              duration: const Duration(milliseconds: 150),
              curve: material.Curves.easeOutCubic,
              style: nm.NeumorphicStyle(
                depth: isPressed ? -6 : 6,
                intensity: 0.8,
                boxShape: nm.NeumorphicBoxShape.roundRect(
                  material.BorderRadius.circular(borderRadius),
                ),
                color: bgColor,
                lightSource: nm.LightSource.topLeft,
              ),
              padding: padding as EdgeInsets,
              child: material.DefaultTextStyle(
                style: material.TextStyle(
                  color: isPressed
                      ? material.Colors.grey[700]
                      : material.Colors.grey[900],
                  fontWeight: material.FontWeight.w600,
                ),
                child: material.Center(child: child),
              ),
            ),
          );
        },
      ),
    );
  }
}
