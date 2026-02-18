import 'package:digital_jeweller/features/admin/data/customers/repositories/customer_repository_impl.dart';
import 'package:get/get.dart';
import '../../../../../../core/base/base_controller.dart';
import '../../../domain/entities/customer.dart';

class AdminCustomerListController
    extends BaseController<CustomerRepositoryImpl> {
  final customers = <Customer>[].obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCustomers();
  }

  Future<void> loadCustomers() async {
    try {
      showLoading();
      error.value = '';
      final result = await repository.getCustomers();
      customers.assignAll(result);
    } catch (e) {
      error.value = 'Failed to load customers';
      showError(error.value);
    } finally {
      hideLoading();
    }
  }
}
