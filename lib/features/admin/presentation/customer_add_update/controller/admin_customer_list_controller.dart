import 'package:digital_jeweller/features/admin/data/repositories/admin_customer_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/base/base_controller.dart';
import '../../../domain/entities/customer.dart';

class AdminCustomerListController
    extends BaseController<AdminCustomerRepositoryImpl> {
  // final AdminCustomerRepository customerRepository;

  AdminCustomerListController();

  /// Remote customers loaded from API
  final customers = <Customer>[].obs;

  final RxnString customersError = RxnString();

  @override
  void onInit() {
    super.onInit();
    loadCustomers();
  }

  // This will be called automatically when navigating back to this screen
  void refreshCustomers() {
    loadCustomers();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loadCustomers() async {
    try {
      debugPrint('🔄 AdminController: Starting loadCustomers...');
      customers.clear();
      debugPrint('🧹 AdminController: Cleared existing customers');
      showLoading();
      customersError.value = null;
      debugPrint('📡 AdminController: Calling repository.getCustomers()...');
      final result = await repository.getCustomers();
      debugPrint(
        '✅ AdminController: Received ${result.length} customers from repository',
      );
      debugPrint('📋 AdminController: Customers data: $result');
      customers.assignAll(result);
      debugPrint(
        '✅ AdminController: Assigned customers to observable list. Current count: ${customers.length}',
      );
    } catch (e, stackTrace) {
      debugPrint('❌ AdminController: Error loading customers: $e');
      debugPrint('📚 AdminController: Stack trace: $stackTrace');
      customersError.value = 'Failed to load customers';
      showError(customersError.value!);
    } finally {
      hideLoading();
      debugPrint(
        '🏁 AdminController: loadCustomers completed. Final count: ${customers.length}',
      );
    }
  }

  Future<Customer> getCustomerById(String id) async {
    return await repository.getCustomerById(id);
  }
}
