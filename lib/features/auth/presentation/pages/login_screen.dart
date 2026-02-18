import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/classic_card.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends GetWidget<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo/Icon section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.diamond_outlined,
                    size: 50,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  'Digital Jeweller',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: ClassicTheme.getTextPrimary(context),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),

                Container(height: 1, width: 60, color: AppColors.primary),

                const SizedBox(height: 40),

                // Inputs
                _buildTextField(
                  context,
                  controller: controller.jewellerCodeController,
                  label: 'JEWELLER CODE',
                  icon: Icons.store_rounded,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  context,
                  controller: controller.phoneController,
                  label: 'MOBILE NUMBER',
                  icon: Icons.phone_android_rounded,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  context,
                  controller: controller.passwordController,
                  label: 'PASSWORD',
                  icon: Icons.lock_outline_rounded,
                  isPassword: true,
                ),

                const SizedBox(height: 40),

                // Login Button
                Obx(
                      () => SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                        controller.login(
                          controller.jewellerCodeController.text.trim(),
                          controller.phoneController.text.trim(),
                          controller.passwordController.text.trim(),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        elevation: 5,
                        shadowColor: AppColors.primary.withOpacity(0.4),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : Text(
                        'SIGN IN',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2.5,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Version info
                Text(
                  'SYSTEM VERSION 1.0.0',
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    color: ClassicTheme.getTextSecondary(context),
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // body: Stack(
      //   children: [
      //     // Background with Premium Image or Gradient
      //     Positioned.fill(
      //       child: Container(
      //         decoration: const BoxDecoration(
      //           gradient: LinearGradient(
      //             begin: Alignment.topLeft,
      //             end: Alignment.bottomRight,
      //             colors: [
      //               Color(0xFF1A1A1A),
      //               Color(0xFF2C2C2C),
      //               Color(0xFF1A1A1A),
      //             ],
      //           ),
      //         ),
      //         child: Opacity(
      //           opacity: 0.2,
      //           child: Image.asset(
      //             'assets/images/background.jpg',
      //             fit: BoxFit.cover,
      //             errorBuilder: (context, error, stackTrace) => Container(),
      //           ),
      //         ),
      //       ),
      //     ),
      //
      //     // Central Login Card
      //     SafeArea(
      //       child: Center(
      //         child: SingleChildScrollView(
      //           padding: const EdgeInsets.all(24.0),
      //           child: _buildClassicLoginCard(context),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget _buildClassicLoginCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo/Icon section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withOpacity(0.1),
            ),
            child: const Icon(
              Icons.diamond_outlined,
              size: 50,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            'Digital Jeweller',
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: ClassicTheme.getTextPrimary(context),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),

          Container(height: 1, width: 60, color: AppColors.primary),

          const SizedBox(height: 40),

          // Inputs
          _buildTextField(
            context,
            controller: controller.jewellerCodeController,
            label: 'JEWELLER CODE',
            icon: Icons.store_rounded,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            context,
            controller: controller.phoneController,
            label: 'MOBILE NUMBER',
            icon: Icons.phone_android_rounded,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            context,
            controller: controller.passwordController,
            label: 'PASSWORD',
            icon: Icons.lock_outline_rounded,
            isPassword: true,
          ),

          const SizedBox(height: 40),

          // Login Button
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        controller.login(
                          controller.jewellerCodeController.text.trim(),
                          controller.phoneController.text.trim(),
                          controller.passwordController.text.trim(),
                        );
                      },
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 5,
                  shadowColor: AppColors.primary.withOpacity(0.4),
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'SIGN IN',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2.5,
                        ),
                      ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Version info
          Text(
            'SYSTEM VERSION 1.0.0',
            style: GoogleFonts.outfit(
              fontSize: 10,
              color: ClassicTheme.getTextSecondary(context),
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: ClassicTheme.getTextSecondary(context),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          style: TextStyle(
            color: ClassicTheme.getTextPrimary(context),
            fontSize: 15,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
            filled: true,
            fillColor: isDark
                ? const Color(0xFF2C2C2C)
                : const Color(0xFFF9F9F9),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.grey.shade200,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.grey.shade200,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
