import 'package:digital_jeweller/core/constants/app_routes.dart';
import 'package:digital_jeweller/features/admin/presentation/customer_add_update/controller/admin_customer_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_loading.dart';
import '../../../../core/widgets/common_states.dart';
import '../../../../core/widgets/classic_card.dart';

class AdminCustomerListPage extends GetWidget<AdminCustomerListController> {
  const AdminCustomerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        title: Text(
          'Customers',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: AppColors.backgroundDark,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   AppBarActionButton(
        //     icon: Icons.person_add_outlined,
        //     onPressed: () {
        //       Get.toNamed(AppRoutes.adminAddUser)?.then((value) {
        //         controller.loadCustomers();
        //       });
        //     },
        //   ),
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.adminAddUser)?.then((value) {
            controller.loadCustomers();
          });
        },
        child: const Icon(Icons.person_add_outlined),
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          await controller.loadCustomers();
        },
        child: Obx(() {
          if (controller.isLoading.value && controller.customers.isEmpty) {
            return CommonLoading(message: 'Loading customers...');
          }
          if (controller.customers.isEmpty) {
            return EmptyState(
              icon: Icons.people_outline,
              title: 'No customers found',
              message: 'Pull down to refresh or add a new customer.',
              actionText: 'Add Customer',
              onAction: () =>
                  Get.toNamed(AppRoutes.adminAddUser)?.then((value) {
                    controller.loadCustomers();
                  }),
            );
          }
          return ListView.builder(
            itemCount: controller.customers.length,
            itemBuilder: (context, index) {
              final customer = controller.customers[index];
              return ClassicCustomerCard(
                name: customer.name,
                profileImageUrl: customer.profileImage,
                status: customer.role ?? '',
                statusColor: AppColors.primary,
                email: customer.email,
                joinedDate: customer.createdAt.toString(),
                phone: customer.phone,
                onUpdateTap: () {
                  Get.toNamed(
                    AppRoutes.adminAddUser,
                    arguments: customer,
                  )?.then((value) {
                    controller.loadCustomers();
                  });
                },
              );
            },
          );
        }),
      ),
    );
  }
}

/// Classic customer card using common components
class ClassicCustomerCard extends StatelessWidget {
  final String name;
  final String? profileImageUrl;
  final String status;
  final Color statusColor;
  final String? email;
  final String? phone;
  final String? joinedDate;
  final VoidCallback? onUpdateTap;

  const ClassicCustomerCard({
    super.key,
    required this.name,
    this.profileImageUrl,
    required this.status,
    required this.statusColor,
    this.email,
    this.phone,
    this.joinedDate,
    this.onUpdateTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClassicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar, Name, Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClassicAvatar(name: name, profileImageUrl: profileImageUrl),
              const SizedBox(width: 20),
              // Name and Status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: ClassicTheme.getTextPrimary(context),
                        fontFamily: 'Serif',
                      ),
                    ),
                    const SizedBox(height: 6),
                    ClassicStatusBadge(text: status, color: statusColor),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Contact Info
          if (phone != null) ...[
            ClassicInfoRow(icon: Icons.phone_outlined, value: phone!),
            const SizedBox(height: 14),
          ],
          if (email != null && email!.isNotEmpty) ...[
            ClassicInfoRow(icon: Icons.email_outlined, value: email!),
            const SizedBox(height: 14),
          ],
          // if (joinedDate != null) ...[
          //   ClassicInfoRow(
          //     icon: Icons.calendar_month_outlined,
          //     value:
          //         "Joined:  ${DateFormat('dd MMM yyyy').format(DateTime.parse(joinedDate!))}",
          //   ),
          //   const SizedBox(height: 14),
          // ],

          // Update Profile Button
          ClassicOutlinedButton(
            text: "Update Profile",
            icon: Icons.edit_outlined,
            onPressed: onUpdateTap,
          ),
        ],
      ),
    );
  }
}
