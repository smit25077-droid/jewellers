import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/admin/banner/domain/entities/banner.dart'
    as entity;
import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';
import 'package:digital_jeweller/features/admin/banner/domain/usecases/get_banners_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_schemes_usecase.dart';
import 'package:digital_jeweller/features/user/domain/entities/customer_dashboard.dart';
import 'package:digital_jeweller/features/user/domain/entities/joined_scheme.dart';
import 'package:digital_jeweller/features/user/domain/usecases/get_customer_dashboard_usecase.dart';
import 'package:digital_jeweller/features/user/domain/usecases/join_scheme_use_case.dart';
import 'package:digital_jeweller/features/user/domain/usecases/joined_scheme_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digital_jeweller/core/utils/snackbar_utils.dart';

class UserController extends GetxController {
  final GetSchemesUseCase _getSchemesUseCase;
  final GetBannersUseCase _getBannersUseCase;
  final JoinSchemeUseCase _joinSchemeUseCase;
  final JoinedSchemeUseCase _joinedSchemeUseCase;

  UserController({
    required GetSchemesUseCase getSchemesUseCase,
    required GetBannersUseCase getBannersUseCase,
    required JoinSchemeUseCase joinSchemeUseCase,
    required JoinedSchemeUseCase joinedSchemeUseCase,
  }) : _getSchemesUseCase = getSchemesUseCase,
       _getBannersUseCase = getBannersUseCase,
       _joinSchemeUseCase = joinSchemeUseCase,
       _joinedSchemeUseCase = joinedSchemeUseCase;

  // State
  final schemes = <Scheme>[].obs;
  final banners = <entity.Banner>[].obs;
  final isLoading = true.obs;
  final isLoadingBanners = true.obs;
  final userSchemes = <JoinedScheme>[].obs;

  final dashboardData = Rx<CustomerDashboard?>(null);

  // Added properties to match UI requirements in UserDashboard
  final totalAmount = 0.0.obs;
  final totalEmiPaid = 0.obs;

  RxBool isPressed = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSchemes();
    fetchBanners();
    joinedScheme();
  }

  // void _loadUserMockData() {
  //   // Mock data for user's active schemes
  //   userSchemes.assignAll([
  //     Scheme(
  //       id: 'mock1',
  //       name: 'My Personal Gold Plan',
  //       description: 'Saving for a special occasion.',
  //       totalAmount: 24000,
  //       emiAmount: 2000,
  //       durationMonths: 12,
  //       jewellerName: 'Local Jewellers',
  //       isActive: true,
  //       startDate: DateTime.now(),
  //       endDate: DateTime.now().add(const Duration(days: 365)),
  //     ),
  //   ]);
  //   totalAmount.value = 4000.0;
  //   totalEmiPaid.value = 2;
  // }

  void requestEmiPayment(double amount, bool isOnline) {
    debugPrint('Payment Requested: ${isOnline ? 'Online' : 'Cash'}');
  }

  Future<void> fetchSchemes() async {
    try {
      isLoading.value = true;
      final result = await _getSchemesUseCase.call();
      schemes.value = result;
    } catch (e) {
      SnackBarUtils.showError(e.toString());
      schemes.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBanners() async {
    try {
      isLoadingBanners.value = true;
      final result = await _getBannersUseCase.call();
      result.fold(
        (failure) {
          SnackBarUtils.showError(failure.message);
          banners.clear();
        },
        (bannerList) {
          banners.value = bannerList;
        },
      );
    } catch (e) {
      SnackBarUtils.showError(e.toString());
      banners.clear();
    } finally {
      isLoadingBanners.value = false;
    }
  }

  Future<void> joinScheme(String schemeId) async {
    try {
      isLoading.value = true;
      await _joinSchemeUseCase.call(schemeId);
      debugPrint('Success: Joined scheme successfully');
      joinedScheme();
      // Refresh user schemes or dashboard data if needed
      // _loadUserMockData();
    } catch (e) {
      SnackBarUtils.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> joinedScheme() async {
    try {
      isLoading.value = true;
      final response = await _joinedSchemeUseCase.call();
      userSchemes.value = response;
    } catch (e) {
      SnackBarUtils.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  final dashboardUseCase = sl<GetCustomerDashboardUseCase>();

  List<CustomerDashboardScheme> jewellerSchemes =
      <CustomerDashboardScheme>[].obs;

   List<PaymentStat> paymentStats = <PaymentStat>[].obs;

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final response = await dashboardUseCase.call();
      dashboardData.value = response;
      jewellerSchemes = dashboardData.value?.jewellerSchemes ?? [];
      paymentStats = dashboardData.value?.paymentStats ?? [];
    } catch (e) {
      SnackBarUtils.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
