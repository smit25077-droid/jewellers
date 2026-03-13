import 'package:digital_jeweller/core/base/base_controller.dart';
import 'package:digital_jeweller/features/admin/domain/entities/customer.dart';
import 'package:digital_jeweller/features/admin/domain/repositories/admin_customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  /// Path of the locally selected profile photo (null = no photo chosen)
  final selectedImagePath = RxnString();

  final _imagePicker = ImagePicker();

  /// Opens a bottom sheet to pick a photo from gallery or camera
  Future<void> pickImage(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take a Photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            if (selectedImagePath.value != null)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text(
                  'Remove Photo',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  selectedImagePath.value = null;
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
    if (source != null) {
      final picked = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 800,
      );
      if (picked != null) selectedImagePath.value = picked.path;
    }
  }

  var customerObservable = Rxn<Customer>();
  var isRefreshing = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    customer.value = (args is Customer) ? args : null;
    if (customer.value != null) {
      loadLatestDetails(customer.value!);
    }
  }

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
      barrierDismissible: false, // User must tap a button
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: const [
              Icon(Icons.delete_forever, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete Customer'),
            ],
          ),
          content: const Text(
            'Are you sure you want to delete this customer? This action cannot be undone.',
            style: TextStyle(fontSize: 16),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[700],
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await deleteCustomer(customer.value!.id);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Customer deleted successfully')),
        // );
      } catch (e) {
        showError('Failed to delete customer');
      }
    }
  }

  Future<void> loadLatestDetails(dynamic customer) async {
    isRefreshing.value = true;

    try {
      final fresh = await getCustomerById(customer.id);

      this.customer.value = fresh;
      customerObservable.value = fresh;
      nameController.text = fresh.name;
      phoneController.text = fresh.phone;
      emailController.text = fresh.email;
      selectedImagePath.value = null; // Clear any previously picked image
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
        photoPath: selectedImagePath.value,
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
        email: emailController.text,
        photoPath: selectedImagePath.value,
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
