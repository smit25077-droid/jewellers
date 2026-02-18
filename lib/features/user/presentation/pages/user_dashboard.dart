import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/core/theme/app_colors.dart';
import 'package:digital_jeweller/core/widgets/premium_banner_carousel.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_banners_use_case.dart';
import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_schemes_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(
      UserController(
        getSchemesUseCase: sl<GetSchemesUseCase>(),
        getBannersUseCase: sl<GetBannersUseCase>(),
      ),
    );
    // final adminController = Get.find<AdminController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Digital Jeweller')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Promotional Banner Carousel
            Obx(
              () => PremiumBannerCarousel(
                banners: userController.banners,
                isLoading: userController.isLoadingBanners.value,
              ),
            ),

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
                      'Total Savings',
                      '₹${userController.totalAmount.value}',
                      Icons.account_balance_wallet,
                    ),
                    _buildStatTile(
                      'Paid EMIs',
                      '${userController.totalEmiPaid.value}',
                      Icons.check_circle,
                    ),
                    _buildStatTile(
                      'Active Schemes',
                      '${userController.userSchemes.length}',
                      Icons.list_alt,
                    ),
                    _buildStatTile('Jeweller', 'ABC Shop', Icons.store),
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Featured Schemes',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 12),

            // Horizontal Available Schemes
            SizedBox(
              height: 180,
              child: Obx(() {
                if (userController.isLoading.value &&
                    userController.schemes.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (userController.schemes.isEmpty) {
                  return const Center(
                    child: Text('No featured schemes available'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: userController.schemes.length,
                  itemBuilder: (context, index) {
                    final scheme = userController.schemes[index];
                    return Container(
                      width: 280,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.primaryDark
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              scheme.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSchemeInfoMini(
                                  'EMI',
                                  '₹${scheme.emiAmount}',
                                ),
                                _buildSchemeInfoMini(
                                  'DUR',
                                  '${scheme.durationMonths}m',
                                ),
                                _buildSchemeInfoMini(
                                  'TOTAL',
                                  '₹${scheme.totalAmount}',
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Join Plan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'My Active Schemes',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),

            _buildActiveSchemesList(userController),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                onPressed: () => _showPaymentDialog(context, userController),
                icon: const Icon(Icons.payment),
                label: const Text('PAY EMI / REQUEST CASH PICKUP'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
    );
  }

  Widget _buildSchemeInfoMini(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStatTile(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.amber.shade800, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
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
          final scheme = controller.userSchemes[index];
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
}
