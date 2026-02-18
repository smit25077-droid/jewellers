// import 'package:digital_jeweller/core/widgets/common_text_fields.dart';
// import 'package:digital_jeweller/features/admin/domain/entities/customer.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../../core/theme/app_colors.dart';
// import '../../../../../core/widgets/common_loading.dart';
// import '../../../../../core/widgets/common_states.dart';
// import '../../../../../core/widgets/classic_card.dart';
// import '../../../data/models/customer_model.dart';
// import '../controller/customer_add_update_controller.dart';
//
// class CustomerAddUpdatePage extends StatefulWidget {
//   final Customer? customer;
//
//   const CustomerAddUpdatePage({super.key, this.customer});
//
//   @override
//   State<CustomerAddUpdatePage> createState() => _CustomerAddUpdatePageState();
// }
//
// class _CustomerAddUpdatePageState extends State<CustomerAddUpdatePage> {
//   CustomerAddUpdateController get controller =>
//       Get.find<CustomerAddUpdateController>();
//
//   @override
//   void initState() {
//     super.initState();
//     // Handle arguments - ensure it's a Customer or null
//     final args = widget.customer;
//     controller.customer.value = (args is Customer) ? args : null;
//
//     if (controller.customer.value != null) {
//       controller.loadLatestDetails(controller.customer.value!);
//     }
//     controller.nameController.text = controller.customer.value?.name ?? '';
//     controller.phoneController.text = controller.customer.value?.phone ?? '';
//     controller.emailController.text = controller.customer.value?.email ?? '';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       backgroundColor: AppColors.getBackgroundColor(context),
//       appBar: AppBar(
//         title: Text(
//           widget.customer != null ? 'Update Customer' : 'Create Customer',
//           style: GoogleFonts.playfairDisplay(
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black87),
//           onPressed: () => Get.back(),
//         ),
//       ),
//
//       body: Obx(() {
//         // Show global loading overlay if needed
//         if (controller.isLoading.value &&
//             controller.customerObservable.value == null) {
//           return const CommonLoading(message: 'Loading customer...');
//         }
//
//         return Stack(
//           children: [
//             SingleChildScrollView(
//               padding: const EdgeInsets.all(0.0),
//               child: Column(
//                 children: [
//                   // Customer Header (Edit Mode)
//                   if (widget.customer != null) ...{
//                     ClassicCard(
//                       child: Row(
//                         children: [
//                           ClassicAvatar(
//                             name: controller.nameController.text,
//                             size: 56,
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   controller.nameController.text,
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w400,
//                                     color: ClassicTheme.getTextPrimary(context),
//                                     fontFamily: 'Serif',
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 ClassicStatusBadge(
//                                   text: 'Active Customer',
//                                   color: Colors.green,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                   },
//
//                   // Form Fields in a Classic Card
//                   ClassicCard(
//                     // padding: const EdgeInsets.symmetric(
//                     //   horizontal: 20,
//                     //   vertical: 32,
//                     // ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Personal Details',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w400,
//                             color: ClassicTheme.getTextPrimary(context),
//                             fontFamily: 'Serif',
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//
//                         _buildLabel('Full Name'),
//                         CommonTextFields(
//                           controller: controller.nameController,
//                           labelText: 'Enter customer name',
//                           prefixIcon: Icon(Icons.person_outline),
//                         ),
//                         const SizedBox(height: 24),
//
//                         _buildLabel('Mobile Number'),
//                         _buildTextField(
//                           controller: controller.phoneController,
//                           hint: 'Enter mobile number',
//                           icon: Icons.phone_android_outlined,
//                           keyboardType: TextInputType.phone,
//                         ),
//                         const SizedBox(height: 24),
//
//                         _buildLabel('Email Address'),
//                         _buildTextField(
//                           controller: controller.emailController,
//                           hint: 'Enter email (optional)',
//                           icon: Icons.email_outlined,
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//
//                         if (widget.customer == null) ...[
//                           const SizedBox(height: 24),
//                           _buildLabel('Initial Password'),
//                           _buildTextField(
//                             controller: controller.passwordController,
//                             hint: 'Create temporary password',
//                             icon: Icons.lock_outline,
//                             isPassword: true,
//                           ),
//                         ],
//
//                         const SizedBox(height: 40),
//
//                         // Action Buttons
//                         SizedBox(
//                           width: double.infinity,
//                           height: 54,
//                           child: OutlinedButton(
//                             onPressed: controller.isLoading.value
//                                 ? null
//                                 : () => controller.saveCustomer(),
//                             style: OutlinedButton.styleFrom(
//                               backgroundColor: AppColors.primary,
//                               side: const BorderSide(color: AppColors.primary),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                             ),
//                             child: controller.isLoading.value
//                                 ? const SizedBox(
//                                     height: 20,
//                                     width: 20,
//                                     child: CircularProgressIndicator(
//                                       color: Colors.white,
//                                       strokeWidth: 2,
//                                     ),
//                                   )
//                                 : Text(
//                                     widget.customer != null
//                                         ? 'UPDATE CUSTOMER'
//                                         : 'CREATE CUSTOMER',
//                                     style: GoogleFonts.outfit(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                       letterSpacing: 1.5,
//                                     ),
//                                   ),
//                           ),
//                         ),
//
//                         if (widget.customer != null) ...[
//                           const SizedBox(height: 16),
//                           SizedBox(
//                             width: double.infinity,
//                             child: TextButton(
//                               onPressed: controller.isLoading.value
//                                   ? null
//                                   : () => controller.deleteCustomer(),
//                               child: Text(
//                                 'DELETE CUSTOMER',
//                                 style: GoogleFonts.outfit(
//                                   color: AppColors.error,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 13,
//                                   letterSpacing: 1,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (controller.isLoading.value)
//               const LinearProgressIndicator(
//                 backgroundColor: Colors.transparent,
//                 valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
//               ),
//           ],
//         );
//       }),
//     );
//   }
//
//   Widget _buildLabel(String label) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0, left: 4),
//       child: Text(
//         label.toUpperCase(),
//         style: GoogleFonts.outfit(
//           fontSize: 11,
//           fontWeight: FontWeight.bold,
//           color: ClassicTheme.getTextSecondary(context),
//           letterSpacing: 1,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hint,
//     required IconData icon,
//     bool isPassword = false,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return TextField(
//       controller: controller,
//       obscureText: isPassword,
//       keyboardType: keyboardType,
//       style: TextStyle(
//         color: ClassicTheme.getTextPrimary(context),
//         fontSize: 16,
//       ),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: TextStyle(
//           color: ClassicTheme.getTextSecondary(context).withOpacity(0.5),
//           fontSize: 14,
//         ),
//         prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
//         filled: true,
//         fillColor: isDark ? const Color(0xFF333333) : const Color(0xFFF9F9F9),
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 16,
//           horizontal: 16,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(4),
//           borderSide: BorderSide(
//             color: isDark ? Colors.white12 : Colors.grey.shade200,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(4),
//           borderSide: BorderSide(
//             color: isDark ? Colors.white12 : Colors.grey.shade200,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(4),
//           borderSide: const BorderSide(color: AppColors.primary, width: 1),
//         ),
//       ),
//     );
//   }
// }
