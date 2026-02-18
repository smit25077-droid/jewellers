// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../../core/theme/app_colors.dart';
// import '../../../../../core/widgets/common_loading.dart';
// import '../../../../../core/widgets/common_states.dart';
// import '../../../../../core/widgets/classic_card.dart';
// import '../controller/admin_customer_list_controller.dart';
// import 'customer_add_update_page.dart';
//
// class AdminCustomerListPage extends GetView<AdminCustomerListController> {
//   const AdminCustomerListPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.getBackgroundColor(context),
//       body: Obx(() {
//         if (controller.isLoading.value && controller.customers.isEmpty) {
//           return const CommonLoading(message: 'Loading customers...');
//         }
//
//         if (controller.error.isNotEmpty && controller.customers.isEmpty) {
//           // return CommonErrorState(
//           //   title: 'Error Loading Customers',
//           //   message: controller.error.value,
//           //   onRetry: () => controller.loadCustomers(),
//           // );
//         }
//
//         if (controller.customers.isEmpty) {
//           // return CommonEmptyState(
//           //   icon: Icons.people_outline,
//           //   title: 'No customers found',
//           //   message: 'Pull down to refresh or add a new customer.',
//           //   actionText: 'Add Customer',
//           //   onAction: () =>
//           //       Get.to(() => const CustomerAddUpdatePage())?.then((value) {
//           //         controller.loadCustomers();
//           //       }),
//           // );
//         }
//
//         return RefreshIndicator(
//           color: AppColors.primary,
//           onRefresh: () => controller.loadCustomers(),
//           child: ListView.builder(
//             padding: const EdgeInsets.only(top: 10, bottom: 20),
//             itemCount: controller.customers.length,
//             itemBuilder: (context, index) {
//               final customer = controller.customers[index];
//               return ClassicCustomerCard(
//                 name: customer.name,
//                 status: 'Active Member', // You can add status logic later
//                 statusColor: Colors.green,
//                 phone: customer.phone,
//                 email: customer.email,
//                 joinedDate: customer.joinedDate,
//                 onUpdateTap: () {
//                   Get.toNamed(
//                     '/admin-add-user',
//                     arguments: customer,
//                   )?.then((value) => controller.loadCustomers());
//                 },
//               );
//             },
//           ),
//         );
//       }),
//     );
//   }
// }
//
// class ClassicCustomerCard extends StatelessWidget {
//   final String name;
//   final String status;
//   final Color statusColor;
//   final String? email;
//   final String? phone;
//   final String? joinedDate;
//   final VoidCallback? onUpdateTap;
//
//   const ClassicCustomerCard({
//     super.key,
//     required this.name,
//     required this.status,
//     required this.statusColor,
//     this.email,
//     this.phone,
//     this.joinedDate,
//     this.onUpdateTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ClassicCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header: Avatar, Name, Status
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClassicAvatar(name: name),
//               const SizedBox(width: 20),
//               // Name and Status
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w400,
//                         color: ClassicTheme.getTextPrimary(context),
//                         fontFamily: 'Serif',
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     ClassicStatusBadge(text: status, color: statusColor),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//
//           // Contact Info
//           if (phone != null) ...[
//             ClassicInfoRow(icon: Icons.phone_outlined, value: phone!),
//             const SizedBox(height: 14),
//           ],
//           if (email != null && email!.isNotEmpty) ...[
//             ClassicInfoRow(icon: Icons.email_outlined, value: email!),
//             const SizedBox(height: 14),
//           ],
//           // Joined date commented out as per user request in recent change
//           // if (joinedDate != null) ...[
//           //   ClassicInfoRow(
//           //     icon: Icons.calendar_month_outlined,
//           //     value: "Joined:  ${DateFormat('dd MMM yyyy').format(DateTime.parse(joinedDate!))}",
//           //   ),
//           //   const SizedBox(height: 14),
//           // ],
//
//           // Update Profile Button
//           ClassicOutlinedButton(
//             text: "Update Profile",
//             icon: Icons.edit_outlined,
//             onPressed: onUpdateTap,
//           ),
//         ],
//       ),
//     );
//   }
// }
