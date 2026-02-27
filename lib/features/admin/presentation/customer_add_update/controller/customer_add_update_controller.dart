import 'package:digital_jeweller/core/base/base_controller.dart';
import 'package:digital_jeweller/features/admin/domain/entities/customer.dart';
import 'package:digital_jeweller/features/admin/domain/repositories/admin_customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerAddUpdateController extends BaseController {
  final AdminCustomerRepository customerRepository;

  CustomerAddUpdateController({required this.customerRepository});

  /// Remote customers loaded from API
  final customersList = <Customer>[].obs;
  final customer = Rxn<Customer>();

  // final RxnString customersError = RxnString();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var customerObservable = Rxn<Customer>();
  var isRefreshing = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   nameController.text = customer.value?.name ?? '';
  //   phoneController.text = customer.value?.phone ?? '';
  //   emailController.text = customer.value?.email ?? '';
  // }

  Future<void> onSave({required Customer customer}) async {
    // if (customer == null) return;
    try {
      final updated = await updateCustomer();
      customerObservable.value = updated;
      // Get.back();
    } catch (_) {
      // Error snackbar already shown
    }
  }

  Future<void> onDeleteCustomer({required BuildContext context}) async {
    if (customer.value == null) return;

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
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await deleteCustomer(customer.value!.id);
      } catch (_) {
        // Error snackbar already shown
      }
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
      Get.snackbar('Error', 'Please fill all required fields');
      return;
    }

    try {
      await createCustomer();
      Get.back();
    } catch (_) {
      // Error is already shown from controller
    }
  }

  // -----------------------------
  // Customer (API) operations
  // -----------------------------

  // Future<void> loadCustomers() async {
  //   try {
  //     debugPrint('🔄 AdminController: Starting loadCustomers...');
  //     customers.clear();
  //     debugPrint('🧹 AdminController: Cleared existing customers');
  //     showLoading();
  //     customersError.value = null;
  //     debugPrint('📡 AdminController: Calling repository.getCustomers()...');
  //     final result = await customerRepository.getCustomers();
  //     debugPrint(
  //       '✅ AdminController: Received ${result.length} customers from repository',
  //     );
  //     debugPrint('📋 AdminController: Customers data: $result');
  //     customers.assignAll(result);
  //     debugPrint(
  //       '✅ AdminController: Assigned customers to observable list. Current count: ${customers.length}',
  //     );
  //   } catch (e, stackTrace) {
  //     debugPrint('❌ AdminController: Error loading customers: $e');
  //     debugPrint('📚 AdminController: Stack trace: $stackTrace');
  //     customersError.value = 'Failed to load customers';
  //     showError(customersError.value!);
  //   } finally {
  //     hideLoading();
  //     debugPrint(
  //       '🏁 AdminController: loadCustomers completed. Final count: ${customers.length}',
  //     );
  //   }
  // }

  Future<Customer> createCustomer() async {
    try {
      showLoading();
      final created = await customerRepository.createCustomer(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      customersList.add(created);
      Get.back();
      showSuccess('Customer created successfully');
      return created;
    } catch (e) {
      showError('Failed to create customer');
      rethrow;
    } finally {
      hideLoading();
    }
  }

  Future<Customer> updateCustomer() async {
    try {
      showLoading();
      final updated = await customerRepository.updateCustomer(
        id: customer.value?.id ?? '',
        name: nameController.text,
        mobile: customer.value?.phone ?? '',
        email: emailController.text ,
      );

      final index = customersList.indexWhere((c) => c.id == customer.value?.id);
      if (index != -1) {
        customersList[index] = updated;
      }
      hideLoading();
      showSuccess('Customer updated successfully');
      return updated;
    } catch (e) {
      hideLoading();
      showError('Failed to update customer');
      rethrow;
    }
  }

  Future<void> deleteCustomer(String id) async {
    try {
      showLoading();
      await customerRepository.deleteCustomer(id);
      customersList.removeWhere((c) => c.id == id);
      hideLoading();
      // Navigate back after showing success message
      Get.back();
      Get.back();

      // When popping from detail screen
      Get.back(result: true);
      await Future.delayed(const Duration(milliseconds: 100));
      showSuccess('Customer deleted successfully');
    } catch (e) {
      hideLoading();
      showError('Failed to delete customer');
      rethrow;
    }
  }

  Future<Customer> getCustomerById(String id) async {
    return await customerRepository.getCustomerById(id);
  }
}
