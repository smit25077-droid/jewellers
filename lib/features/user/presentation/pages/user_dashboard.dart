import 'package:digital_jeweller/core/constants/app_design_constants.dart';
import 'package:digital_jeweller/core/theme/app_colors.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:get/get.dart';
import 'package:digital_jeweller/core/widgets/premium_banner_carousel.dart';
import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/user_controller.dart';

class UserDashboard extends GetWidget<UserController> {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            controller.fetchBanners();
            controller.joinedScheme();
            return controller.fetchSchemes();
          },

          child: SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () {
                controller.fetchBanners();
                controller.joinedScheme();
                return controller.fetchSchemes();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome To,', style: AppDesignConstants.displaySmall()),
                  Text(
                    'Digital Jeweller',
                    style: AppDesignConstants.displayLarge(),
                  ),

                  const SizedBox(height: 16),
                  // Promotional Banner Carousel
                  // Obx(
                  //   () => PremiumBannerCarousel(
                  //     banners: controller.banners,
                  //     isLoading: controller.isLoadingBanners.value,
                  //   ),
                  // ),

                  const SizedBox(height: 8),
                  // Stats Grid
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Obx(
                      () => GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.5,
                        children: [
                          _buildStatTile(
                            context,
                            'Total Savings',
                            '₹${controller.totalAmount.value}',
                            Icons.account_balance_wallet,
                          ),
                          _buildStatTile(
                            context,
                            'Paid EMIs',
                            '${controller.totalEmiPaid.value}',
                            Icons.check_circle,
                          ),
                          _buildStatTile(
                            context,
                            'Active Schemes',
                            '${controller.userSchemes.length}',
                            Icons.list_alt,
                          ),
                          _buildStatTile(
                            context,
                            'Jeweller',
                            'ABC Shop',
                            Icons.store,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Horizontal Available Schemes
                  Obx(() {
                    if (controller.isLoading.value) {
                      return SizedBox(
                        height: 180,
                        child: ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 200,
                              width: 280,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    if (controller.schemes.isNotEmpty) {
                      final isDark =
                          Theme.of(context).brightness == Brightness.dark;
                      final cardBackground = isDark
                          ? const Color(0xFF2C2C2C)
                          : Colors.white;
                      final borderColor = isDark
                          ? Colors.white.withAlpha(1)
                          : Colors.grey.shade200;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Featured Schemes',
                              style: AppDesignConstants.displayMedium(
                                primaryColor: true,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTapDown: (_) => controller.isPressed.value = true,
                            onTapUp: (_) => controller.isPressed.value = false,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              transform: Matrix4.identity()
                                ..scale(
                                  controller.isPressed.value ? 0.95 : 1.0,
                                ),
                              child: SizedBox(
                                height: 180,
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.schemes.length,
                                  itemBuilder: (context, index) {
                                    final scheme = controller.schemes[index];
                                    return GestureDetector(
                                      onTap: () {
                                        _showJoinSchemeDialog(
                                          context,
                                          controller,
                                          scheme,
                                        );
                                      },
                                      child: Stack(
                                        children: [
                                          Shimmer.fromColors(
                                            highlightColor: AppColors.primary
                                                .withAlpha(3),
                                            baseColor: Colors.transparent,
                                            child: Container(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width -
                                                  70,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: cardBackground,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: isDark
                                                        ? Colors.black
                                                              .withAlpha(4)
                                                        : Colors.black
                                                              .withAlpha(05),
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ],
                                                border: Border.all(
                                                  color: borderColor,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Container(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width -
                                                70,
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: isDark
                                                      ? Colors.black.withAlpha(
                                                          4,
                                                        )
                                                      : Colors.black.withAlpha(
                                                          05,
                                                        ),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                              border: Border.all(
                                                color: borderColor,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsGeometry.all(
                                                12,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    scheme.name,
                                                    style:
                                                        AppDesignConstants.displaySmall(),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      _buildSchemeInfoMini(
                                                        'EMI',
                                                        '₹${scheme.emiAmount}',
                                                      ),

                                                      _buildSchemeInfoMini(
                                                        'DURATION',
                                                        '${scheme.durationMonths} Months',
                                                      ),
                                                      _buildSchemeInfoMini(
                                                        'TOTAL',
                                                        '₹${scheme.totalAmount}',
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 12),
                                                  GestureDetector(
                                                    onTap: () =>
                                                        _showJoinSchemeDialog(
                                                          context,
                                                          controller,
                                                          scheme,
                                                        ),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            vertical: 4,
                                                            horizontal: 12,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        // color: Colors.white.withAlpha(2),
                                                        color:
                                                            AppColors.getSurfaceColor(
                                                              context,
                                                            ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        'Join Plan',
                                                        style:
                                                            AppDesignConstants.bodyMedium(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),

                  const SizedBox(height: 24),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'My Active Schemes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  _buildActiveSchemesList(controller),

                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: () => _showPaymentDialog(context, controller),
                      icon: const Icon(Icons.payment),
                      label: const Text('PAY EMI / REQUEST CASH PICKUP'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimary,
                        minimumSize: const Size(double.infinity, 54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          Get.snackbar('Info', 'Browse new schemes logic here'),
                      icon: const Icon(Icons.add_circle_outline),
                      label: const Text('JOIN NEW SCHEME'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSchemeInfoMini(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: AppDesignConstants.bodyLarge()),
        Text(value, style: AppDesignConstants.bodyMedium()),
      ],
    );
  }

  Widget _buildStatTile(context, String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.getCardColor(navigatorKey.currentContext!),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.getCardShadowColor(navigatorKey.currentContext!),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.amber.shade800, size: 24),
          const SizedBox(height: 8),
          Text(value, style: AppDesignConstants.bodyMedium()),
          Text(label, style: AppDesignConstants.bodyMedium()),
        ],
      ),
    );
  }

  Widget _buildActiveSchemesList(UserController controller) {
    return Obx(() {
      if (controller.userSchemes.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('You haven\'t joined any schemes yet.'),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.userSchemes.length,
        itemBuilder: (context, index) {
          final scheme = controller.userSchemes[index].scheme;
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                scheme.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '₹${scheme.emiAmount}/month for ${scheme.durationMonths} months',
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      );
    });
  }

  void _showPaymentDialog(BuildContext context, UserController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose Payment Method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.account_balance, color: Colors.blue),
              title: const Text('Online Payment'),
              subtitle: const Text('Instant confirmation via UPI / Bank'),
              onTap: () {
                Get.back();
                controller.requestEmiPayment(500, true);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.money, color: Colors.green),
              title: const Text('Cash at Shop'),
              subtitle: const Text('Request jeweller to accept cash'),
              onTap: () {
                Get.back();
                controller.requestEmiPayment(500, false);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showJoinSchemeDialog(
    BuildContext context,
    UserController controller,
    Scheme scheme,
  ) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Text(
            'Join ${scheme.name}',
            style: AppDesignConstants.displaySmall(),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(scheme.description, style: AppDesignConstants.bodyMedium()),
            const SizedBox(height: 20),
            _buildDetailRow('Monthly EMI', '₹ ${scheme.emiAmount}'),
            _buildDetailRow('Duration', '${scheme.durationMonths} Months'),
            _buildDetailRow('Total Amount', '₹ ${scheme.totalAmount}'),
            _buildDetailRow('Jeweller', scheme.jewellerName),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              'By joining this scheme, you agree to pay the monthly EMI on time.',
              style: AppDesignConstants.bodyMedium(),
            ),
          ],
        ),

        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.joinScheme(scheme.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Confirm & Join'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppDesignConstants.bodyLarge()),
          Text(value, style: AppDesignConstants.bodyLarge()),
        ],
      ),
    );
  }
}
