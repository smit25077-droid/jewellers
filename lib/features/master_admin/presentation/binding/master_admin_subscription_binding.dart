import 'package:digital_jeweller/features/master_admin/presentation/controllers/master_admin_subsciption_controller.dart';
import 'package:get/get.dart';

class MasterAdminSubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    return Get.lazyPut<MasterAdminSubscriptionController>(
      () => MasterAdminSubscriptionController(),
    );
  }
}