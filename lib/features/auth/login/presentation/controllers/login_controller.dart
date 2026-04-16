import 'package:digital_jeweller/core/service_locator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:digital_jeweller/core/constants/app_routes.dart';
import 'package:digital_jeweller/core/base/base_controller.dart';
import 'package:digital_jeweller/features/auth/login/data/models/login_model.dart';
import 'package:digital_jeweller/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:digital_jeweller/features/auth/login/data/repositories/login_repository_impl.dart';

class LoginController extends BaseController<LoginRepositoryImpl>
    with GetTickerProviderStateMixin {
  LoginController() : super();
  LoginUseCase loginUseCase = sl<LoginUseCase>();
  GetStorage storage = sl<GetStorage>();

  final user = Rxn<User>();
  final TextEditingController jewellerCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isPasswordVisible = false.obs;

  late AnimationController fadeController;
  late AnimationController slideController;
  late AnimationController scaleController;
  late AnimationController shimmerController;
  late AnimationController backgroundController;

  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> shimmerAnimation;
  late Animation<double> backgroundAnimation;

  @override
  void onInit() {
    super.onInit();

    fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    backgroundController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: fadeController, curve: Curves.easeIn));

    slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: slideController, curve: Curves.easeOutCubic),
        );

    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: scaleController, curve: Curves.easeOutBack),
    );

    shimmerAnimation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: shimmerController, curve: Curves.linear));

    backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: backgroundController, curve: Curves.easeInOut),
    );

    fadeController.forward();
    slideController.forward();
    scaleController.forward();
  }

  @override
  void onClose() {
    fadeController.dispose();
    slideController.dispose();
    scaleController.dispose();
    shimmerController.dispose();
    backgroundController.dispose();
    jewellerCodeController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
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
    String password, {
    String platform = 'android',
  }) async {
    if (mobile.isEmpty || password.isEmpty) {
      showError('Phone and password are required');
      return;
    }

    if (mobile.length != 10) {
      showError('Mobile number must be 10 digits');
      return;
    }

    try {
      showLoading();
      final response = await loginUseCase.call(
        loginRequest: LoginRequestModel(
          jewellerCode: jewellerCode.isEmpty ? null : jewellerCode,
          phone: mobile,
          password: password,
          fcmToken: 'dummy_token',
          platform: platform,
        ),
      );

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
        Get.offAllNamed(AppRoutes.superAdminWebDashboard);
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
