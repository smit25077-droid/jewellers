import 'package:digital_jeweller/core/constants/app_design_constants.dart';
import 'package:digital_jeweller/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/classic_card.dart';
import '../../../core/widgets/common_dialogs.dart';
import '../../../core/constants/app_routes.dart';
import 'common_appbar.dart';

/// Common profile page for all user types (Admin, Jeweller, Customer)
class CommonProfilePage extends GetWidget<AuthController> {
  const CommonProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = controller.user.value;

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      // appBar: const CommonAppBar(title: 'Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            // Profile Header Card
            CommonAppBar(title: 'Profile',isLeading: false,),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      // Profile Picture
                      const SizedBox(width: 16),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.getPremiumGradient(context),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 3,
                          ),
                        ),
                        child:
                            // profilePicture != null
                            // ? ClipOval(
                            //     child: Image.network(
                            //       profilePicture!,
                            //       fit: BoxFit.cover,
                            //       errorBuilder:
                            //           (context, error, stackTrace) =>
                            //               _buildInitialsAvatar(),
                            //     ),
                            //   ) :
                            _buildInitialsAvatar(),
                      ),
                      const SizedBox(width: 16),

                      // Name
                      Column(
                        children: [
                          Text(
                            userData?.name ?? '-',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: ClassicTheme.getTextPrimary(context),
                              fontFamily: 'Serif',
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Role Badge
                          ClassicStatusBadge(
                            text: _getRoleDisplayName(userData?.role ?? '-'),
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: AppColors.getDividerColor(context),),
            // const SizedBox(height: 20),

            // Profile Details Card
            ClassicCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: ClassicTheme.getTextPrimary(context),
                      fontFamily: 'Serif',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Phone
                  ClassicInfoRow(
                    icon: Icons.phone_outlined,
                    value: userData?.phone ?? '-',
                  ),
                  const SizedBox(height: 16),

                  // Email
                  ClassicInfoRow(
                    icon: Icons.email_outlined,
                    value: userData?.email ?? '-',
                  ),

                  // Jeweller Code (only for jewellers)
                  if (userData?.jeweller?.code != null) ...[
                    const SizedBox(height: 16),
                    ClassicInfoRow(
                      icon: Icons.qr_code,
                      value: 'Code: ${userData?.jeweller?.code}',
                    ),
                  ],
                ],
              ),
            ),

            // const SizedBox(height: 20),

            // Actions Card
            ClassicCard(
              child: Column(
                children: [
                  // Theme Toggle
                  _buildActionTile(
                    context,
                    icon: Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    title: Get.isDarkMode ? 'Light Mode' : 'Dark Mode',
                    subtitle: 'Switch theme',
                    onTap: () {
                      Get.changeThemeMode(
                        Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                      );
                    },
                  ),

                  const Divider(height: 1),

                  // Edit Profile (if needed)
                  _buildActionTile(
                    context,
                    icon: Icons.edit_outlined,
                    title: 'Edit Profile',
                    subtitle: 'Update your information',
                    onTap: () {
                      // Navigate to edit profile
                      CommonDialogs.showSuccess('Edit profile coming soon');
                    },
                  ),

                  const Divider(height: 1),

                  // Change Password
                  _buildActionTile(
                    context,
                    icon: Icons.lock_outline,
                    title: 'Banner Management',
                    subtitle: 'Add banner in Dashboard',
                    onTap: () {
                      // Navigate to change password
                      Get.toNamed(AppRoutes.adminAddBanner);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Logout Button
            ClassicOutlinedButton(
              margin: AppDesignConstants.paddingHorizontal,
              text: 'Logout',
              icon: Icons.logout,
              // borderColor: AppColors.error,
              // textColor: AppColors.error,
              onPressed: () async {
                final confirmed = await CommonDialogs.showLogoutDialog(context);
                if (confirmed) {
                  controller.logout();
                  Get.offAllNamed(AppRoutes.login);
                }
              },
            ),

            const SizedBox(height: 20),

            // App Version
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 12,
                color: ClassicTheme.getTextSecondary(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialsAvatar() {
    return Center(
      child: Text(
        _getInitials(controller.user.value?.name ?? '-'),
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  String _getInitials(String name) {
    List<String> names = name.split(" ");
    if (names.length >= 2) {
      return "${names[0][0]}${names[1][0]}".toUpperCase();
    } else if (names.isNotEmpty && names[0].isNotEmpty) {
      return names[0][0].toUpperCase();
    }
    return "U";
  }

  String _getRoleDisplayName(String role) {
    switch (role.toLowerCase()) {
      case 'master_admin':
        return 'Master Admin';
      case 'jewellers_admin':
        return 'Jeweller Admin';
      case 'customer':
        return 'Customer';
      default:
        return role;
    }
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'master_admin':
        return AppColors.error;
      case 'jewellers_admin':
        return AppColors.primary;
      case 'customer':
        return AppColors.primary;
      default:
        return AppColors.primary;
    }
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ClassicTheme.getAccentBrown(context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: ClassicTheme.getAccentBrown(context),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ClassicTheme.getTextPrimary(context),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: ClassicTheme.getTextSecondary(context),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: ClassicTheme.getTextSecondary(context),
            ),
          ],
        ),
      ),
    );
  }
}
