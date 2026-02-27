import 'package:digital_jeweller/features/master_admin/presentation/controllers/master_admin_controller.dart';
import 'package:get/get.dart';

class MasterAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasterAdminController>(
      () => MasterAdminController(),
    );
  }
}
