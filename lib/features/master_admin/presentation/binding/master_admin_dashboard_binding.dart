import 'package:digital_jeweller/features/master_admin/presentation/controllers/master_admin_dashboard_controller.dart';
import 'package:get/get.dart';

class MasterAdminDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasterAdminDashboardController>(
          () => MasterAdminDashboardController(),
    );
  }
}
