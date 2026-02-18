import 'package:digital_jeweller/features/admin/domain/entities/banner.dart'
    as entity;
import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_banners_use_case.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_schemes_usecase.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final GetSchemesUseCase _getSchemesUseCase;
  final GetBannersUseCase _getBannersUseCase;

  UserController({
    required GetSchemesUseCase getSchemesUseCase,
    required GetBannersUseCase getBannersUseCase,
  }) : _getSchemesUseCase = getSchemesUseCase,
       _getBannersUseCase = getBannersUseCase;

  // State
  final schemes = <Scheme>[].obs;
  final banners = <entity.Banner>[].obs;
  final isLoading = true.obs;
  final isLoadingBanners = true.obs;
  final userSchemes = <Scheme>[].obs;

  // Added properties to match UI requirements in UserDashboard
  final totalAmount = 0.0.obs;
  final totalEmiPaid = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSchemes();
    fetchBanners();
    _loadUserMockData();
  }

  void _loadUserMockData() {
    // Mock data for user's active schemes
    userSchemes.assignAll([
      Scheme(
        id: 'mock1',
        name: 'My Personal Gold Plan',
        description: 'Saving for a special occasion.',
        totalAmount: 24000,
        emiAmount: 2000,
        durationMonths: 12,
        jewellerName: 'Local Jewellers',
        isActive: true,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365)),
      ),
    ]);
    totalAmount.value = 4000.0;
    totalEmiPaid.value = 2;
  }

  void requestEmiPayment(double amount, bool isOnline) {
    Get.snackbar(
      'Payment Requested',
      isOnline
          ? 'Redirecting to payment gateway...'
          : 'Cash pickup request sent to jeweller.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> fetchSchemes() async {
    try {
      isLoading.value = true;
      final result = await _getSchemesUseCase.call();
      schemes.value = result;
    } catch (e) {
      Get.snackbar('Error loading schemes', e.toString());
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
          Get.snackbar('Error loading banners', failure.message);
          banners.clear();
        },
        (bannerList) {
          banners.value = bannerList;
        },
      );
    } catch (e) {
      Get.snackbar('Error loading banners', e.toString());
      banners.clear();
    } finally {
      isLoadingBanners.value = false;
    }
  }
}
