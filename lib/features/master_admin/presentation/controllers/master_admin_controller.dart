import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/master_admin/domain/repositories/master_admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/domain/entities/jeweller.dart';
import 'package:get/get.dart';

class MasterAdminController extends GetxController {
  // final MasterAdminRepository adminRepo;

  MasterAdminController(/*{required this.adminRepo}*/);

  final adminRepo = sl<MasterAdminRepository>();
  final jewellers = <Jeweller>[].obs;

  var selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }

  // Loading and error states for list & create screens
  final isLoadingJewellers = false.obs;
  final isCreatingJeweller = false.obs;
  final errorMessage = RxnString();

  final formKey = GlobalKey<FormState>();

  Future<void> loadJewellers() async {
    try {
      isLoadingJewellers.value = true;
      errorMessage.value = null;
      final response = await adminRepo.getJewellers();
      jewellers.clear();
      jewellers.addAll(response);
    } catch (e) {
      errorMessage.value = 'Failed to load jewellers';
      Get.snackbar(
        'Error',
        errorMessage.value ?? 'Something went wrong while loading jewellers',
      );
    } finally {
      isLoadingJewellers.value = false;
    }
  }

  // final controller = Get.find<MasterAdminController>();
  TextEditingController controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController jewellerCodeController = TextEditingController();

  // Future<void> addJeweller() async {
  //   // Validate form before sending request
  //   if (!(formKey.currentState?.validate() ?? false)) {
  //     return;
  //   }
  //
  //   final newJeweller = Jeweller(
  //     id: DateTime.now().millisecondsSinceEpoch.toString(),
  //     name: nameController.text,
  //     aadhaarNumber: aadharController.text,
  //     address: addressController.text,
  //     panNumber: panController.text,
  //     phone: phoneController.text,
  //     email: emailController.text,
  //     isActive: true,
  //     password: passwordController.text,
  //     jewellerCode: jewellerCodeController.text,
  //     gstNumber: gstController.text,
  //   );
  //
  //   try {
  //     isCreatingJeweller.value = true;
  //     errorMessage.value = null;
  //     // API request to create jeweller
  //     final createdJeweller = await adminRepo.createJeweller(newJeweller);
  //     jewellers.add(createdJeweller);
  //     _clearFormFields();
  //
  //     Get.back();
  //     Get.snackbar('Success', 'Jeweller added successfully');
  //   } on DioException catch (e) {
  //     // Extract error message from API if available
  //     final serverMessage = e.response?.data is Map<String, dynamic>
  //         ? (e.response?.data['responseMessage'] ?? e.response?.data['message'])
  //         : null;
  //     errorMessage.value =
  //         serverMessage?.toString() ?? 'Failed to create jeweller';
  //     Get.snackbar('Error', errorMessage.value!);
  //   } catch (e) {
  //     errorMessage.value = 'Failed to create jeweller';
  //     Get.snackbar('Error', errorMessage.value!);
  //   } finally {
  //     isCreatingJeweller.value = false;
  //   }
  // }

  // void _clearFormFields() {
  //   nameController.clear();
  //   shopNameController.clear();
  //   addressController.clear();
  //   panController.clear();
  //   aadharController.clear();
  //   phoneController.clear();
  //   emailController.clear();
  //   gstController.clear();
  //   passwordController.clear();
  //   jewellerCodeController.clear();
  // }

  Future<void> deleteJeweller(String id) async {
    try {
      await adminRepo.deleteJeweller(id);

      // Update list screen data
      jewellers.removeWhere((j) => j.id == id);

      // Close dialog first
      Get.back();
      // Show success message
      Get.snackbar('Success', 'Jeweller deleted successfully');
      // Navigate back to list screen
      Get.back();
      // Refresh the list
      loadJewellers();
    } catch (e) {
      Get.back(); // Close dialog on error
      Get.snackbar('Error', 'Failed to delete jeweller');
    }
  }

  Future<void> toggleJewellerStatus(String id, bool isActive) async {
    try {
      final updatedJeweller = await adminRepo.toggleJewellerStatus(
        id,
        !isActive,
      );

      // Update the jeweller in the list
      final index = jewellers.indexWhere((j) => j.id == id);
      if (index != -1) {
        jewellers[index] = updatedJeweller;
      }

      // Notify GetBuilder listeners
      update();

      Get.snackbar(
        'Success',
        updatedJeweller.isActive == true
            ? 'Jeweller activated successfully'
            : 'Jeweller deactivated successfully',
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to update jeweller status');
    }
  }
}
