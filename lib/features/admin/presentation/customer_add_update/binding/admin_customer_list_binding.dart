import 'package:get/get.dart';

import '../controller/admin_customer_list_controller.dart';

class AdminCustomerListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCustomerListController>(
      () => AdminCustomerListController(),
    );
  }
}
