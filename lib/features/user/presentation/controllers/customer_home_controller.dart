import 'package:digital_jeweller/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerHomeController extends GetxController {
  final currentIndex = 0.obs;
  // Use a unique GlobalKey for this controller instance
  final GlobalKey<NavigatorState> customerNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'CustomerHomeNavigator',
  );

  @override
  void onInit() {
    super.onInit();
    Get.keys[1] = customerNavigatorKey;
  }

  @override
  void onClose() {
    // Clean up when the controller is disposed
    if (Get.keys[1] == customerNavigatorKey) {
      Get.keys.remove(1);
    }
    super.onClose();
  }

  void changeIndex(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
    if (index == 0) {
      Get.offNamed(AppRoutes.userDashboardHome, id: 1);
    } else {
      Get.offNamed(AppRoutes.profile, id: 1);
    }
  }
}
