import 'package:digital_jeweller/features/master_admin/presentation/controllers/master_admin_jeweller_controller.dart';
import 'package:get/get.dart';

class MasterAdminJewellerBinding extends Bindings{
  @override
  void dependencies() {
    return Get.lazyPut<MasterAdminJewellerController>(
      () => MasterAdminJewellerController(),
    );
  }

}