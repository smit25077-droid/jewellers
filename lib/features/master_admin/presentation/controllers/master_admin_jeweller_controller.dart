import 'package:digital_jeweller/core/base/base_controller.dart';
import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/master_admin/domain/repositories/master_admin_repository.dart';
import 'package:digital_jeweller/features/master_admin/domain/usecases/master_admin_jeweller_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:digital_jeweller/features/master_admin/domain/entities/jeweller.dart';
import 'package:get/get.dart';

class MasterAdminJewellerController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final masterAdminJewellerUsecase = sl<MasterAdminJewellerUsecase>();
  final isLoadingJewellers = false.obs;
  final isCreatingJeweller = false.obs;
  final errorMessage = RxnString();
  final adminRepo = sl<MasterAdminRepository>();
  final jewellers = <Jeweller>[].obs;

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

  @override
  void onInit() {
    loadJewellers();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    shopNameController.dispose();
    addressController.dispose();
    panController.dispose();
    aadharController.dispose();
    phoneController.dispose();
    emailController.dispose();
    gstController.dispose();
    passwordController.dispose();
    jewellerCodeController.dispose();
    super.dispose();
  }

  Future<void> loadJewellers() async {
    try {
      isLoadingJewellers.value = true;
      errorMessage.value = null;
      final response = await adminRepo.getJewellers();
      jewellers.clear();
      jewellers.addAll(response);
    } catch (e) {
      errorMessage.value = 'Failed to load jewellers';
      Get.snackbar('Error', errorMessage.value ?? 'Something went wrong while loading jewellers');
    } finally {
      isLoadingJewellers.value = false;
    }
  }

  Future<void> addJeweller() async {
    // Validate form before sending request
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    final newJeweller = Jeweller(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text,
      aadhaarNumber: aadharController.text,
      address: addressController.text,
      panNumber: panController.text,
      phone: phoneController.text,
      email: emailController.text,
      isActive: true,
      password: passwordController.text,
      jewellerCode: jewellerCodeController.text,
      gstNumber: gstController.text,
    );

    try {
      isCreatingJeweller.value = true;
      errorMessage.value = null;
      final createdJeweller = await masterAdminJewellerUsecase.createJeweller(newJeweller);
      jewellers.add(createdJeweller);
      _clearFormFields();

      Get.back();
      Get.snackbar('Success', 'Jeweller added successfully');
    } on DioException catch (e) {
      final serverMessage = e.response?.data is Map<String, dynamic>
          ? (e.response?.data['responseMessage'] ?? e.response?.data['message'])
          : null;
      errorMessage.value = serverMessage?.toString() ?? 'Failed to create jeweller';
      Get.snackbar('Error', errorMessage.value!);
    } catch (e) {
      errorMessage.value = 'Failed to create jeweller';
      Get.snackbar('Error', errorMessage.value!);
    } finally {
      isCreatingJeweller.value = false;
    }
  }

  void _clearFormFields() {
    nameController.clear();
    shopNameController.clear();
    addressController.clear();
    panController.clear();
    aadharController.clear();
    phoneController.clear();
    emailController.clear();
    gstController.clear();
    passwordController.clear();
    jewellerCodeController.clear();
  }

  Future<void> deleteJeweller(String id) async {
    try {
      await adminRepo.deleteJeweller(id);
      jewellers.removeWhere((j) => j.id == id);
      Get.back();
      Get.snackbar('Success', 'Jeweller deleted successfully');
      Get.back();
      loadJewellers();
    } catch (e) {
      Get.back(); // Close dialog on error
      Get.snackbar('Error', 'Failed to delete jeweller');
    }
  }

  Future<void> toggleJewellerStatus({required String id, required bool isActive}) async {
    try {
      final updatedJeweller = await masterAdminJewellerUsecase.toggleJewellerStatus(id: id, isActive: !isActive);
      final index = jewellers.indexWhere((j) => j.id == id);
      if (index != -1) {
        jewellers[index] = updatedJeweller;
      }
      update();
      showSuccess(
        updatedJeweller.isActive == true ? 'Jeweller activated successfully' : 'Jeweller deactivated successfully',
      );
      // Get.snackbar(
      //   'Success',
      //   updatedJeweller.isActive == true ? 'Jeweller activated successfully' : 'Jeweller deactivated successfully',
      // );
    } catch (e) {
      showError('Failed to update jeweller status');
      // Get.snackbar('Error', 'Failed to update jeweller status');
    }
  }
}
