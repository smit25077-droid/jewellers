import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:digital_jeweller/features/admin/banner/domain/entities/banner.dart';
import 'package:digital_jeweller/features/admin/domain/entities/jeweller_dashboard.dart';
import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';
import 'package:digital_jeweller/features/admin/banner/domain/usecases/get_banners_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_jeweller_dashboard_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_schemes_usecase.dart';
import 'package:get/get.dart';

class AdminDashboardController extends GetxController {
  final GetBannersUseCase _getBannersUseCase;
  final GetSchemesUseCase _getSchemesUseCase;
  final GetJewellerDashboardUseCase _getJewellerDashboardUseCase;

  AdminDashboardController({
    required GetBannersUseCase getBannersUseCase,
    required GetSchemesUseCase getSchemesUseCase,
    required GetJewellerDashboardUseCase getJewellerDashboardUseCase,
  }) : _getBannersUseCase = getBannersUseCase,
       _getSchemesUseCase = getSchemesUseCase,
       _getJewellerDashboardUseCase = getJewellerDashboardUseCase;

  // State
  final banners = <Banner>[].obs;
  final schemes = <Scheme>[].obs;
  final isLoading = true.obs;
  final currentBannerIndex = 0.obs;
  final carouselController = carousel.CarouselSliderController();

  // Jeweller Dashboard Stats
  final Rx<JewellerDashboard?> dashboardStats = Rx<JewellerDashboard?>(null);
  final totalSchemes = 0.obs;
  final totalEnrollments = 0.obs;
  final totalWinners = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      await Future.wait([
        _fetchBanners(),
        _fetchSchemes(),
        _fetchDashboardStats(),
      ]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchBanners() async {
    final result = await _getBannersUseCase.call();
    result.fold((failure) {
      Get.snackbar('Error loading banners', failure.message);
      banners.clear();
    }, (bannerList) => banners.value = bannerList);
  }

  Future<void> _fetchSchemes() async {
    try {
      final result = await _getSchemesUseCase.execute();
      schemes.value = result;
    } catch (e) {
      Get.snackbar('Error loading schemes', e.toString());
      schemes.clear();
    }
  }

  Future<void> _fetchDashboardStats() async {
    try {
      final result = await _getJewellerDashboardUseCase.call();
      dashboardStats.value = result;
      totalSchemes.value = result.totalSchemes;
      totalEnrollments.value = result.totalEnrollments;
      totalWinners.value = result.totalWinners;
    } catch (e) {
      // Non-fatal: dashboard stats failure should not break the page
    }
  }

  void onBannerChanged(int index) {
    currentBannerIndex.value = index;
  }
}
