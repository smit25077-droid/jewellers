import 'package:digital_jeweller/core/widgets/common_profile_page.dart';
import 'package:digital_jeweller/features/auth/presentation/controllers/auth_controller.dart';
import 'package:digital_jeweller/features/user/presentation/controllers/customer_home_controller.dart';
import 'package:digital_jeweller/features/user/presentation/pages/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerHomeController());
    final authController = Get.find<AuthController>();

    final List<Widget> pages = [
      const UserDashboard(),
      Obx(() {
        final user = authController.user.value;
        if (user == null)
          return const Center(child: CircularProgressIndicator());
        return CommonProfilePage(
          name: user.name,
          email: user.email,
          phone: user.phone,
          role: user.role,
          jewellerCode: user.jeweller?.code,
        );
      }),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
