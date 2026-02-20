import 'package:digital_jeweller/features/auth/domain/usecases/login_usecase.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:digital_jeweller/core/constants/app_routes.dart';
import 'package:digital_jeweller/core/base/base_controller.dart';
import 'package:digital_jeweller/features/auth/data/repositories/auth_repository_impl.dart';
import '../../data/models/login_response_model.dart';

class AuthController extends BaseController<AuthRepositoryImpl> {
  final LoginUseCase loginUseCase;
  final GetStorage storage = GetStorage();

  AuthController({required this.loginUseCase});

  final user = Rxn<User>();

  final TextEditingController jewellerCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  @override
  void onClose() {
    jewellerCodeController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _loadUser() {
    final userData = storage.read('user');
    if (userData != null) {
      user.value = User.fromJson(userData);
    }
  }

  void checkLoginStatus() {
    final token = storage.read('token');
    final role = storage.read('role');

    if (token != null && role != null) {
      Future.delayed(Duration.zero, () {
        _navigateBasedOnRole(role);
      });
    }
  }

  Future<void> login(
    String jewellerCode,
    String mobile,
    String password,
  ) async {
    if (jewellerCode.isEmpty || mobile.isEmpty || password.isEmpty) {
      showError('All fields are required');
      return;
    }

    try {
      showLoading();
      final response = await loginUseCase(mobile, password, jewellerCode);

      if (response.responseStatus == 200 && response.responseData != null) {
        final data = response.responseData!;

        // Save session
        await storage.write('token', data.token);
        await storage.write('user_id', data.user.id);
        await storage.write('role', data.user.role);
        await storage.write(
          'jeweller_code',
          data.user.jeweller?.code ?? 'super_admin',
        );
        await storage.write('user', data.user.toJson());
        user.value = data.user;

        showSuccess('Login successful');
        _navigateBasedOnRole(data.user.role);
      } else {
        showError(response.responseMessage);
      }
    } catch (e) {
      showError('Login failed. Please check your connection.');
      debugPrint("Login Error: $e");
    } finally {
      hideLoading();
    }
  }

  void _navigateBasedOnRole(String role) {
    switch (role) {
      case 'jewellers_admin':
        Get.offAllNamed(AppRoutes.jewellerHome);
        break;
      case 'super_admin':
        Get.offAllNamed(AppRoutes.masterAdminDashboard);
        break;
      case 'customer':
        Get.offAllNamed(AppRoutes.userHomeScreen);
        break;
      default:
        Get.offAllNamed(AppRoutes.login);
        break;
    }
  }

  Future<void> logout() async {
    try {
      showLoading();
      storage.erase();
      Get.offAllNamed(AppRoutes.login);
    } finally {
      hideLoading();
    }
  }
}
