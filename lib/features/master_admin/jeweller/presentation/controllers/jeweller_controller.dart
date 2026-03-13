import 'package:digital_jeweller/core/base/base_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/jeweller.dart';
import '../../domain/usecases/get_jewellers_usecase.dart';
import '../../domain/usecases/create_jeweller_usecase.dart';
import '../../domain/usecases/delete_jeweller_usecase.dart';
import '../../domain/usecases/update_jeweller_usecase.dart';

class JewellerController extends BaseController {
  final GetJewellersUseCase getJewellersUseCase;
  final CreateJewellerUseCase createJewellerUseCase;
  final DeleteJewellerUseCase deleteJewellerUseCase;
  final UpdateJewellerStatusUseCase toggleJewellerStatusUseCase;

  JewellerController({
    required this.getJewellersUseCase,
    required this.createJewellerUseCase,
    required this.deleteJewellerUseCase,
    required this.toggleJewellerStatusUseCase,
  });

  // Form key
  final formKey = GlobalKey<FormState>();

  // Observable states
  final isLoadingJewellers = false.obs;
  final isCreatingJeweller = false.obs;
  final isDeletingJeweller = false.obs;
  final isTogglingStatus = false.obs;
  final errorMessage = RxnString();
  final jewellers = <Jeweller>[].obs;

  // Form controllers
  final nameController = TextEditingController();
  final shopNameController = TextEditingController();
  final addressController = TextEditingController();
  final panController = TextEditingController();
  final aadharController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final gstController = TextEditingController();
  final passwordController = TextEditingController();
  final jewellerCodeController = TextEditingController();
  
  // Logo management
  final selectedLogoPath = RxnString();
  final isEditMode = false.obs;
  final editingJewellerId = RxnString();

  @override
  void onInit() {
    super.onInit();
    loadJewellers();
  }

  @override
  void onClose() {
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
    super.onClose();
  }

  /// Load all jewellers
  Future<void> loadJewellers() async {
    try {
      isLoadingJewellers.value = true;
      errorMessage.value = null;

      final response = await getJewellersUseCase.call();
      jewellers.clear();
      jewellers.addAll(response);

      showSuccess('Jewellers loaded successfully');
    } on DioException catch (e) {
      final serverMessage = _extractErrorMessage(e);
      errorMessage.value = serverMessage;
      showError(serverMessage);
    } catch (e) {
      errorMessage.value = 'Failed to load jewellers: $e';
      showError(errorMessage.value!);
    } finally {
      isLoadingJewellers.value = false;
    }
  }

  /// Create a new jeweller
  Future<void> addJeweller() async {
    // Validate form
    if (!(formKey.currentState?.validate() ?? false)) {
      showError('Please fill all required fields correctly');
      return;
    }

    final newJeweller = Jeweller(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text.trim(),
      aadhaarNumber: aadharController.text.trim(),
      address: addressController.text.trim(),
      panNumber: panController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      isActive: true,
      password: passwordController.text,
      jewellerCode: jewellerCodeController.text.trim(),
      gstNumber: gstController.text.trim(),
      logo: selectedLogoPath.value,
    );

    try {
      isCreatingJeweller.value = true;
      errorMessage.value = null;

      final createdJeweller = await createJewellerUseCase.call(newJeweller);
      jewellers.add(createdJeweller);
      _clearFormFields();

      Get.back();
      showSuccess('Jeweller added successfully');
      
      // Refresh the list
      await loadJewellers();
    } on DioException catch (e) {
      final serverMessage = _extractErrorMessage(e);
      errorMessage.value = serverMessage;
      showError(serverMessage);
    } catch (e) {
      errorMessage.value = 'Failed to create jeweller: $e';
      showError(errorMessage.value!);
    } finally {
      isCreatingJeweller.value = false;
    }
  }

  /// Update an existing jeweller
  Future<void> updateJeweller() async {
    // Validate form
    if (!(formKey.currentState?.validate() ?? false)) {
      showError('Please fill all required fields correctly');
      return;
    }

    if (editingJewellerId.value == null) {
      showError('No jeweller selected for update');
      return;
    }

    final updatedJeweller = Jeweller(
      id: editingJewellerId.value!,
      name: nameController.text.trim(),
      aadhaarNumber: aadharController.text.trim(),
      address: addressController.text.trim(),
      panNumber: panController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      isActive: true,
      jewellerCode: jewellerCodeController.text.trim(),
      gstNumber: gstController.text.trim(),
      logo: selectedLogoPath.value,
      password: passwordController.text.isNotEmpty ? passwordController.text : null,
    );

    try {
      isCreatingJeweller.value = true;
      errorMessage.value = null;

      final result = await toggleJewellerStatusUseCase.call(
        updatedJeweller.id,
        updatedJeweller.isActive ?? true,
      );

      // Update in list
      final index = jewellers.indexWhere((j) => j.id == updatedJeweller.id);
      if (index != -1) {
        jewellers[index] = result;
      }

      _clearFormFields();
      Get.back();
      showSuccess('Jeweller updated successfully');
      
      // Refresh the list and details
      await loadJewellers();
      update();
    } on DioException catch (e) {
      final serverMessage = _extractErrorMessage(e);
      errorMessage.value = serverMessage;
      showError(serverMessage);
    } catch (e) {
      errorMessage.value = 'Failed to update jeweller: $e';
      showError(errorMessage.value!);
    } finally {
      isCreatingJeweller.value = false;
    }
  }

  /// Load jeweller data for editing
  void loadJewellerForEdit(Jeweller jeweller) {
    isEditMode.value = true;
    editingJewellerId.value = jeweller.id;
    
    nameController.text = jeweller.name;
    addressController.text = jeweller.address;
    phoneController.text = jeweller.phone;
    emailController.text = jeweller.email;
    jewellerCodeController.text = jeweller.jewellerCode;
    panController.text = jeweller.panNumber;
    aadharController.text = jeweller.aadhaarNumber;
    gstController.text = jeweller.gstNumber;
    selectedLogoPath.value = jeweller.logo;
    // Don't load password for security
  }

  /// Pick logo image
  void pickLogo() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null) {
        selectedLogoPath.value = image.path;
        showSuccess('Logo selected successfully');
      }
    } catch (e) {
      showError('Failed to pick image: $e');
    }
  }

  /// Remove selected logo
  void removeLogo() {
    selectedLogoPath.value = null;
  }

  /// Delete a jeweller
  Future<void> deleteJeweller(String id) async {
    try {
      isDeletingJeweller.value = true;

      final message = await deleteJewellerUseCase.call(id);
      jewellers.removeWhere((j) => j.id == id);

      Get.back(); // Close confirmation dialog
      Get.back(); // Go back to list screen
      showSuccess(message);

      // Reload list to ensure consistency
      await loadJewellers();
    } on DioException catch (e) {
      final serverMessage = _extractErrorMessage(e);
      Get.back(); // Close dialog on error
      showError(serverMessage);
    } catch (e) {
      Get.back(); // Close dialog on error
      showError('Failed to delete jeweller: $e');
    } finally {
      isDeletingJeweller.value = false;
    }
  }

  /// Toggle jeweller active status
  Future<void> toggleJewellerStatus({
    required String id,
    required bool currentStatus,
  }) async {
    try {
      isTogglingStatus.value = true;

      final updatedJeweller = await toggleJewellerStatusUseCase.call(
        id,
        !currentStatus,
      );

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
    } on DioException catch (e) {
      final serverMessage = _extractErrorMessage(e);
      showError(serverMessage);
    } catch (e) {
      showError('Failed to update jeweller status: $e');
    } finally {
      isTogglingStatus.value = false;
    }
  }

  /// Clear all form fields
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
    isEditMode.value = false;
    editingJewellerId.value = null;
  }

  /// Extract error message from DioException
  String _extractErrorMessage(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final data = e.response!.data as Map<String, dynamic>;
      return data['responseMessage']?.toString() ??
          data['message']?.toString() ??
          'An error occurred';
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        return 'Server error: ${e.response?.statusCode ?? 'Unknown'}';
      case DioExceptionType.cancel:
        return 'Request was cancelled';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return 'An unexpected error occurred';
    }
  }
}
