import 'package:flutter/material.dart';

import 'classic_card.dart';

class CommonTextFields extends StatelessWidget {
  final TextEditingController? controller;

  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final bool filled = true;
  final String? labelText;
  final int? maxLines;


  const CommonTextFields({
    super.key,
    this.keyboardType,
    this.prefixIcon,
    this.labelText,
    this.maxLines,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? Colors.white.withAlpha(2)
        : Colors.grey.shade300;
    final fillColor = isDark
        ? const Color(0xFF3A3A3A)
        : const Color(0xFFF5F5F5);
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: ClassicTheme.getTextPrimary(context),
        fontFamily: 'Serif',
      ),
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: labelText,
        labelStyle: TextStyle(color: ClassicTheme.getTextSecondary(context)),
        prefixIcon: prefixIcon,
        filled: filled,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: ClassicTheme.getAccentBrown(context),
            width: 1.5,
          ),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
