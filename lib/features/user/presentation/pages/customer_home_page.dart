import 'package:digital_jeweller/core/constants/app_routes.dart';
import 'package:digital_jeweller/core/routes/app_pages.dart';
import 'package:digital_jeweller/features/user/presentation/controllers/customer_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerHomePage extends GetWidget<CustomerHomeController> {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: controller.customerNavigatorKey,
        initialRoute: AppRoutes.userDashboardHome,
        onGenerateRoute: (settings) {
          final route = AppPages.routes.firstWhereOrNull(
            (r) => r.name == settings.name,
          );
          if (route != null) {
            return GetPageRoute(
              page: route.page,
              binding: route.binding,
              bindings: route.bindings,
              settings: settings,
              transition: route.transition,
              transitionDuration:
                  route.transitionDuration ?? const Duration(milliseconds: 300),
            );
          }
          return null;
        },
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (value) => controller.changeIndex(value),
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
