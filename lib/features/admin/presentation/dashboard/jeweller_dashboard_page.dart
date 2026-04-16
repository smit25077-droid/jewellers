import 'package:digital_jeweller/features/admin/presentation/dashboard/admin_dashboard_controller.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:get/get.dart';
import 'package:digital_jeweller/core/theme/app_colors.dart';
import 'package:digital_jeweller/core/constants/app_design_constants.dart';

class JewellerDashboardPage extends GetView<AdminDashboardController> {
  const JewellerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: AppDesignConstants.paddingScreen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back',
                              style: AppDesignConstants.bodyMedium(),
                            ),
                            SizedBox(height: AppDesignConstants.spaceXS),
                            Text(
                              'Jeweller Dashboard',
                              style: AppDesignConstants.displayLarge().copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppDesignConstants.paddingHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppDesignConstants.spaceL),
                    Text(
                      'Promotional Banners',
                      style: AppDesignConstants.headlineMedium(),
                    ),
                    SizedBox(height: AppDesignConstants.spaceM),
                  ],
                ),
              ),
            ),
            // Obx(
            //   () => PremiumBannerCarousel(
            //     dashboardBanners: controller.banners,
            //     isLoading: controller.isLoading.value,
            //   ),
            // ),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppDesignConstants.paddingHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppDesignConstants.spaceL),
                    Text(
                      'Quick Stats',
                      style: AppDesignConstants.headlineMedium(),
                    ),
                    SizedBox(height: AppDesignConstants.spaceM),
                  ],
                ),
              ),
            ),
            Obx(() {
              return SliverPadding(
                padding: AppDesignConstants.paddingHorizontal,
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppDesignConstants.spaceM,
                    mainAxisSpacing: AppDesignConstants.spaceM,
                    childAspectRatio: 1.3,
                  ),
                  delegate: SliverChildListDelegate([
                    AnimatedStatsCard(
                      label: 'Total Enrollment',
                      value: controller.totalEnrollments.value.toString(),
                      icon: Icons.people_rounded,
                      color: AppColors.primary,
                    ),
                    AnimatedStatsCard(
                      label: 'Active Schemes',
                      value: controller.totalSchemes.value.toString(),
                      icon: Icons.list_alt_rounded,
                      color: AppColors.info,
                    ),
                    AnimatedStatsCard(
                      label: 'Ad Banners',
                      value: controller.banners.length.toString(),
                      icon: Icons.image_rounded,
                      color: AppColors.warning,
                    ),
                    AnimatedStatsCard(
                      label: 'Total Winners',
                      value: controller.totalWinners.value.toString(),
                      icon: Icons.emoji_events_rounded,
                      color: AppColors.success,
                    ),
                  ]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class AnimatedStatsCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const AnimatedStatsCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDesignConstants.padding,
      decoration: BoxDecoration(
        color: AppColors.getCardColor(context),
        borderRadius: AppDesignConstants.borderRadiusM,
        boxShadow: AppDesignConstants.getShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppDesignConstants.bodyMedium()),
              Icon(icon, color: color, size: AppDesignConstants.iconS),
            ],
          ),
          Text(value, style: AppDesignConstants.displayMedium()),
        ],
      ),
    );
  }
}
