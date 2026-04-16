import 'package:get/get.dart';
import 'package:digital_jeweller/features/master_admin/presentation/binding/master_admin_binding.dart';
import 'package:digital_jeweller/features/master_admin/presentation/binding/master_admin_jeweller_binding.dart';
import 'package:digital_jeweller/features/master_admin/presentation/binding/master_admin_subscription_binding.dart';
import 'package:digital_jeweller/features/super_admin/presentation/controllers/super_admin_dashboard_controller.dart';

class SuperAdminDashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Super Admin Main Controller
    Get.lazyPut(() => SuperAdminDashboardController());

    // Master Admin Sub-controllers (used in embedded pages)
    MasterAdminBinding().dependencies();
    MasterAdminJewellerBinding().dependencies();
    MasterAdminSubscriptionBinding().dependencies();
  }
}
