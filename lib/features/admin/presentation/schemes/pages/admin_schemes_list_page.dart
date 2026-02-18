// import '../../../../../core/theme/app_colors.dart';
// import '../../../../../core/widgets/common_loading.dart';
// import '../../../../../core/widgets/common_states.dart';
// import '../../../../../core/widgets/classic_card.dart';
// import '../../../../../core/widgets/common_dialogs.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controller/scheme_controller.dart';
//
// class AdminSchemesListPage extends GetView<SchemeController> {
//   const AdminSchemesListPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.getBackgroundColor(context),
//
//       body: Obx(() {
//         if (controller.isLoading.value && controller.schemes.isEmpty) {
//           return const CommonLoading(message: 'Loading schemes...');
//         }
//
//         if (controller.schemes.isEmpty) {
//           // return CommonEmptyState(
//           //   icon: Icons.list_alt_rounded,
//           //   title: 'No Schemes Found',
//           //   message: 'Create a new scheme to get started.',
//           //   actionText: 'Add Scheme',
//           //   onAction: () {
//           //     // Navigate to add scheme
//           //     CommonDialogs.showSuccess('Add scheme coming soon');
//           //   },
//           // );
//         }
//
//         return RefreshIndicator(
//           color: AppColors.primary,
//           onRefresh: () => controller.loadSchemes(),
//           child: ListView.builder(
//             padding: const EdgeInsets.only(top: 10, bottom: 20),
//             itemCount: controller.schemes.length,
//             itemBuilder: (context, index) {
//               final scheme = controller.schemes[index];
//               return ClassicSchemeCard(
//                 title: scheme.name,
//                 description: scheme.description,
//                 emi: '${scheme.totalAmount} - ${scheme.emiAmount}',
//                 duration: '${scheme.durationMonths} Months',
//                 total: scheme.totalAmount.toString(),
//                 status: 'Active',
//                 onTap: () {
//                   // Navigate to update scheme
//                   CommonDialogs.showSuccess('Update scheme coming soon');
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
// class ClassicSchemeCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String emi;
//   final String duration;
//   final String total;
//   final String status;
//   final VoidCallback? onTap;
//
//   const ClassicSchemeCard({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.emi,
//     required this.duration,
//     required this.total,
//     required this.status,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ClassicCard(
//       onTap: onTap,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w400,
//                   color: ClassicTheme.getTextPrimary(context),
//                   fontFamily: 'Serif',
//                 ),
//               ),
//               ClassicStatusBadge(text: status, color: AppColors.primary),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             description,
//             style: TextStyle(
//               fontSize: 14,
//               color: ClassicTheme.getTextSecondary(context),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               _buildInfoColumn(context, 'EMI RANGE', emi),
//               const Spacer(),
//               _buildInfoColumn(context, 'DURATION', duration),
//               const Spacer(),
//               _buildInfoColumn(context, 'TOTAL', '₹$total'),
//             ],
//           ),
//           const SizedBox(height: 20),
//           ClassicOutlinedButton(
//             text: 'View Details',
//             icon: Icons.visibility_outlined,
//             onPressed: onTap,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoColumn(BuildContext context, String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 10,
//             fontWeight: FontWeight.bold,
//             color: ClassicTheme.getTextSecondary(context).withOpacity(0.6),
//             letterSpacing: 1,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: ClassicTheme.getTextPrimary(context),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:digital_jeweller/core/constants/app_routes.dart';
import 'package:digital_jeweller/core/theme/app_colors.dart';

import 'package:digital_jeweller/core/widgets/classic_card.dart';
import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';
import 'package:digital_jeweller/features/admin/presentation/schemes/controller/scheme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminSchemesListPage extends GetView<SchemeController> {
  const AdminSchemesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        title: Text(
          'Schemes',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: AppColors.error),
                const SizedBox(height: 16),
                Text(
                  'Error: ${controller.error.value}',
                  style: TextStyle(color: ClassicTheme.getTextPrimary(context)),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () => controller.loadSchemes(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.schemes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list_alt_rounded, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'No schemes available',
                  style: TextStyle(
                    color: ClassicTheme.getTextSecondary(context),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => controller.refreshSchemes(),
          child: ListView.builder(
            itemCount: controller.schemes.length,
            itemBuilder: (context, index) {
              final scheme = controller.schemes[index];
              return ClassicSchemeCard(
                scheme: scheme,
                onTap: () => Get.toNamed(
                  AppRoutes.adminAddUpdateScheme,
                  arguments: controller.schemes[index],
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        heroTag: 'uniqueTag1',
        onPressed: () => Get.toNamed(AppRoutes.adminAddUpdateScheme),
        child: const Icon(Icons.add_business_rounded),
      ),
    );
  }
}

/// Classic scheme card with theme-aware design
class ClassicSchemeCard extends StatelessWidget {
  final Scheme scheme;
  final VoidCallback? onTap;

  const ClassicSchemeCard({super.key, required this.scheme, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClassicCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Name and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  scheme.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: ClassicTheme.getTextPrimary(context),
                    fontFamily: 'Serif',
                  ),
                ),
              ),
              ClassicStatusBadge(
                text: scheme.isActive ? 'Active' : 'Inactive',
                color: scheme.isActive ? AppColors.success : AppColors.error,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            scheme.description,
            style: TextStyle(
              fontSize: 16,
              color: ClassicTheme.getTextSecondary(context),
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Scheme Details
          Row(
            children: [
              Expanded(
                child: _buildDetailColumn(
                  context,
                  'EMI Amount',
                  '₹${scheme.emiAmount.toStringAsFixed(0)}',
                ),
              ),
              Expanded(
                child: _buildDetailColumn(
                  context,
                  'Duration',
                  '${scheme.durationMonths} Months',
                ),
              ),
              Expanded(
                child: _buildDetailColumn(
                  context,
                  'Total',
                  '₹${scheme.totalAmount.toStringAsFixed(0)}',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          ClassicInfoRow(icon: Icons.store, value: scheme.jewellerName),
        ],
      ),
    );
  }

  Widget _buildDetailColumn(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: ClassicTheme.getTextSecondary(context),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ClassicTheme.getAccentBrown(context),
          ),
        ),
      ],
    );
  }
}
