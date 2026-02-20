// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../auth/presentation/controllers/auth_controller.dart';
// import '../../../../core/widgets/common_profile_page.dart';
//
// class AdminProfilePage extends StatelessWidget {
//   const AdminProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final authController = Get.find<AuthController>();
//
//     return Obx(() {
//       final user = authController.user.value;
//       if (user == null) {
//         return Scaffold(
//           backgroundColor: AppColors.getBackgroundColor(context),
//           body: const Center(child: CircularProgressIndicator()),
//         );
//       }
//
//       return CommonProfilePage(
//         // name: user.name,
//         // email: user.email,
//         // phone: user.phone,
//         // role: user.role,
//         // jewellerCode: user.jeweller?.code,
//         // profilePicture: null, // Add profile picture if available in model
//       );
//     });
//   }
// }
