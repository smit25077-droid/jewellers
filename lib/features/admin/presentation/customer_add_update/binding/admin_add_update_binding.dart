import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/admin/presentation/customer_add_update/controller/customer_add_update_controller.dart';
import 'package:get/get.dart';

import '../../../domain/repositories/admin_customer_repository.dart';


class AdminCustomerAddUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerAddUpdateController>(
      () => CustomerAddUpdateController(customerRepository: sl<AdminCustomerRepository>()),
    );
  }
}
