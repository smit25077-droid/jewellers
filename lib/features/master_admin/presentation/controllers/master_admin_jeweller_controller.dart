import 'package:digital_jeweller/core/base/base_controller.dart';
import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/master_admin/domain/repositories/master_admin_repository.dart';
import 'package:digital_jeweller/features/master_admin/domain/usecases/master_admin_jeweller_usecase.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/domain/repositories/jeweller_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:digital_jeweller/features/master_admin/jeweller/domain/entities/jeweller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MasterAdminJewellerController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final masterAdminJewellerUsecase = sl<MasterAdminJewellerUsecase>();
  final isLoadingJewellers = false.obs;
  final isCreatingJeweller = false.obs;
  final errorMessage = RxnString();
  final adminRepo = sl<MasterAdminRepository>();
  final jewellers = <Jeweller>[].obs;

  final selectedLogoPath = RxnString();
  final isActive = true.obs;
  final _imagePicker = ImagePicker();

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

  Future<void> pickLogo(BuildContext context) async {
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
            if (selectedLogoPath.value != null)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text(
                  'Remove Logo',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  selectedLogoPath.value = null;
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
      if (picked != null) selectedLogoPath.value = picked.path;
    }
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
      Get.snackbar(
        'Error',
        errorMessage.value ?? 'Something went wrong while loading jewellers',
      );
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
      isActive: isActive.value,
      logo: selectedLogoPath.value,
      password: passwordController.text,
      jewellerCode: jewellerCodeController.text,
      gstNumber: gstController.text,
    );

    try {
      isCreatingJeweller.value = true;
      errorMessage.value = null;
      final createdJeweller = await masterAdminJewellerUsecase.createJeweller(
        newJeweller,
      );
      jewellers.add(createdJeweller);
      _clearFormFields();

      Get.back();
      Get.snackbar('Success', 'Jeweller added successfully');
    } on DioException catch (e) {
      final serverMessage = e.response?.data is Map<String, dynamic>
          ? (e.response?.data['responseMessage'] ?? e.response?.data['message'])
          : null;
      errorMessage.value =
          serverMessage?.toString() ?? 'Failed to create jeweller';
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
    selectedLogoPath.value = null;
    isActive.value = true;
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

  Future<void> updateJeweller(String id) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    final updatedJeweller = Jeweller(
      id: id,
      name: nameController.text,
      aadhaarNumber: aadharController.text,
      address: addressController.text,
      panNumber: panController.text,
      phone: phoneController.text,
      email: emailController.text,
      isActive: isActive.value,
      logo: selectedLogoPath.value,
      jewellerCode: jewellerCodeController.text,
      gstNumber: gstController.text,
    );

    try {
      isCreatingJeweller.value = true;
      errorMessage.value = null;

      // Note: We need to use sl<JewellerRepository>().updateJeweller here
      // because MasterAdminJewellerUsecase might not have it yet.
      final result = await sl<JewellerRepository>().updateJeweller(
        updatedJeweller,
      );

      final index = jewellers.indexWhere((j) => j.id == id);
      if (index != -1) {
        jewellers[index] = result;
      }

      _clearFormFields();
      Get.back();
      showSuccess('Jeweller updated successfully');
    } catch (e) {
      errorMessage.value = 'Failed to update jeweller';
      showError(errorMessage.value!);
    } finally {
      isCreatingJeweller.value = false;
    }
  }

  void setJewellerForEdit(Jeweller j) {
    nameController.text = j.name;
    addressController.text = j.address;
    panController.text = j.panNumber;
    aadharController.text = j.aadhaarNumber;
    phoneController.text = j.phone;
    emailController.text = j.email;
    gstController.text = j.gstNumber;
    jewellerCodeController.text = j.jewellerCode;
    isActive.value = j.isActive ?? true;
    selectedLogoPath.value = null; // Don't put URL into path
  }

  Future<void> toggleJewellerStatus(String id, bool isActive) async {
    try {
      final updatedJeweller = await sl<JewellerRepository>()
          .toggleJewellerStatus(id, !isActive);
      final index = jewellers.indexWhere((j) => j.id == id);
      if (index != -1) {
        jewellers[index] = updatedJeweller;
      }
      update();
      showSuccess(
        updatedJeweller.isActive == true
            ? 'Jeweller activated successfully'
            : 'Jeweller deactivated successfully',
      );
    } catch (e) {
      showError('Failed to update jeweller status');
    }
  }
}
