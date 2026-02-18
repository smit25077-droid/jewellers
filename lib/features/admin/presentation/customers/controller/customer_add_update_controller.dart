import 'package:digital_jeweller/features/admin/data/customers/repositories/customer_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/base/base_controller.dart';
import '../../../domain/entities/customer.dart';

class CustomerAddUpdateController
    extends BaseController<CustomerRepositoryImpl> {
  // final CustomerRepository repository;

  CustomerAddUpdateController();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final customer = Rxn<Customer>();
  final customerObservable = Rxn<Customer>();

  void loadLatestDetails(Customer initialCustomer) async {
    try {
      showLoading();
      final fresh = await repository.getCustomerById(initialCustomer.id);
      customerObservable.value = fresh;
      nameController.text = fresh.name;
      phoneController.text = fresh.phone;
      emailController.text = fresh.email;
    } catch (e) {
      showError('Failed to load latest details');
    } finally {
      hideLoading();
    }
  }

  Future<void> saveCustomer() async {
    if (nameController.text.isEmpty || phoneController.text.isEmpty) {
      showError('Name and Phone are required');
      return;
    }

    try {
      showLoading();
      if (customer.value == null) {
        // Create
        await repository.addCustomer({
          'name': nameController.text.trim(),
          'phone': phoneController.text.trim(),
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        });
        showSuccess('Customer created successfully');
      } else {
        // Update
        await repository.updateCustomer(customer.value!.id, {
          'name': nameController.text.trim(),
          'phone': phoneController.text.trim(),
          'email': emailController.text.trim(),
        });
        showSuccess('Customer updated successfully');
      }
      Get.back(result: true);
    } catch (e) {
      showError('Failed to save customer');
    } finally {
      hideLoading();
    }
  }

  Future<void> deleteCustomer() async {
    final confirm = await Get.dialog(
      AlertDialog(
        title: const Text('Delete Customer'),
        content: const Text('Are you sure you want to delete this customer?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        showLoading();
        await repository.deleteCustomer(customer.value!.id);
        showSuccess('Customer deleted successfully');
        Get.back(result: true);
      } catch (e) {
        showError('Failed to delete customer');
      } finally {
        hideLoading();
      }
    }
  }
}
