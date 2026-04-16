import 'package:get/get.dart';
import 'package:digital_jeweller/core/constants/app_routes.dart';

class SuperAdminDashboardController extends GetxController {
  final selectedIndex = 0.obs;

  void changeTab(int index) {
    if (index == 4) {
      // Logout logic instead of changing tab
      _logout();
      return;
    }
    selectedIndex.value = index;
  }

  void _logout() {
    // In a real implementation, you would clear storage/tokens here
    // Example: sl<GetStorage>().erase();
    Get.offAllNamed(AppRoutes.login);
  }
}
