import 'package:digital_jeweller/features/admin/data/repositories/admin_customer_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/base/base_controller.dart';
import 'package:digital_jeweller/features/admin/domain/entities/ad_banner.dart';
import 'package:digital_jeweller/features/admin/domain/entities/customer.dart';
import '../../domain/repositories/admin_customer_repository.dart';

class AdminController extends BaseController<AdminCustomerRepositoryImpl> {
  final AdminCustomerRepository customerRepository;

  AdminController({required this.customerRepository});

  /// Remote customers loaded from API
  final customers = <Customer>[].obs;

  final banners = <AdBanner>[].obs;

  final RxnString customersError = RxnString();

  @override
  void onInit() {
    super.onInit();
    // _loadData();
    loadCustomers();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var customerObservable = Rxn<Customer>();
  var isRefreshing = false.obs;

  Future<void> onSave({Customer? customer}) async {
    if (customer == null) return;
    try {
      final updated = await updateCustomer(
        id: customer.id,
        name: nameController.text.trim(),
        mobile: phoneController.text.trim(),
        email: emailController.text.trim(),
      );
      customerObservable.value = updated;
      Get.back();
    } catch (_) {
      // Error snackbar already shown
    }
  }

  Future<void> onDeleteCustomer({required BuildContext context}) async {
    if (customerObservable.value == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Customer'),
          content: const Text('Are you sure you want to delete this customer?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      await deleteCustomer(customerObservable.value!.id);
      Get.back(); // Close details page
      Get.back(); // Close details page
    } catch (_) {
      // Error snackbar already shown
    }
  }

  Future<void> loadLatestDetails(dynamic customer) async {
    isRefreshing.value = true;

    try {
      final fresh = await getCustomerById(customer.id);

      customerObservable.value = fresh;
      nameController.text = fresh.name;
      phoneController.text = fresh.phone;
      emailController.text = fresh.email;
    } catch (_) {
      // Errors are handled by repository/controller where appropriate
    } finally {
      isRefreshing.value = false;
    }
  }

  onTapCreateCustomer() async {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showError('Please fill all required fields');
      return;
    }

    if (phoneController.text.length != 10) {
      showError('Mobile number must be 10 digits');
      return;
    }

    try {
      await createCustomer(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      Get.back();
    } catch (_) {
      // Error is already shown from controller
    }
  }

  // -----------------------------
  // Customer (API) operations
  // -----------------------------

  Future<void> loadCustomers() async {
    try {
      debugPrint('🔄 AdminController: Starting loadCustomers...');
      customers.clear();
      debugPrint('🧹 AdminController: Cleared existing customers');
      showLoading();
      customersError.value = null;
      debugPrint('📡 AdminController: Calling repository.getCustomers()...');
      final result = await customerRepository.getCustomers();
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

  Future<Customer> createCustomer({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      showLoading();
      final created = await customerRepository.createCustomer(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );
      customers.add(created);
      showSuccess('Customer created successfully');
      return created;
    } catch (e) {
      showError('Failed to create customer');
      rethrow;
    } finally {
      hideLoading();
    }
  }

  Future<Customer> updateCustomer({
    required String id,
    required String name,
    required String mobile,
    required String email,
  }) async {
    try {
      showLoading();
      final updated = await customerRepository.updateCustomer(
        id: id,
        name: name,
        mobile: mobile,
        email: email,
      );

      final index = customers.indexWhere((c) => c.id == id);
      if (index != -1) {
        customers[index] = updated;
      }

      showSuccess('Customer updated successfully');
      return updated;
    } catch (e) {
      showError('Failed to update customer');
      rethrow;
    } finally {
      hideLoading();
    }
  }

  Future<void> deleteCustomer(String id) async {
    try {
      showLoading();
      await customerRepository.deleteCustomer(id);
      customers.removeWhere((c) => c.id == id);
      Get.back();
      Future.delayed((Duration(microseconds: 50)), () {
        showSuccess('Customer deleted successfully');
      });
    } catch (e) {
      showError('Failed to delete customer');
      rethrow;
    } finally {
      hideLoading();
    }
  }

  Future<Customer> getCustomerById(String id) async {
    return await customerRepository.getCustomerById(id);
  }

  // -----------------------------
  // Local scheme & banner helpers
  // -----------------------------

  void addBanner(AdBanner banner) {
    banners.add(banner);
  }

  void removeBanner(String id) {
    banners.removeWhere((b) => b.id == id);
    // _saveBanners();
  }
}
