
import 'package:digital_jeweller/core/constants/app_routes.dart';
import 'package:digital_jeweller/core/theme/app_colors.dart';
import 'package:digital_jeweller/core/widgets/common_profile_page.dart';
import 'package:digital_jeweller/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Obx(() {
      final user = authController.user.value;
      if (user == null) {
        return Scaffold(
          backgroundColor: AppColors.getBackgroundColor(context),
          body: const Center(child: CircularProgressIndicator()),
        );
      }

      return Scaffold(
        body: CommonProfilePage(
          name: user.name,
          email: user.email,
          phone: user.phone,
          role: user.role,
          jewellerCode: user.jeweller?.code ?? '',
          profilePicture: null,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.adminAddBanner);
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
