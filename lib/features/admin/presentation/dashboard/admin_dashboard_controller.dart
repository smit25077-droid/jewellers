import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:digital_jeweller/features/admin/domain/entities/banner.dart';
import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_banners_use_case.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_schemes_usecase.dart';
import 'package:get/get.dart';

class AdminDashboardController extends GetxController {
  final GetBannersUseCase _getBannersUseCase;
  final GetSchemesUseCase _getSchemesUseCase;

  AdminDashboardController({
    required GetBannersUseCase getBannersUseCase,
    required GetSchemesUseCase getSchemesUseCase,
  }) : _getBannersUseCase = getBannersUseCase,
       _getSchemesUseCase = getSchemesUseCase;

  // State
  final banners = <Banner>[].obs;
  final schemes = <Scheme>[].obs;
  final isLoading = true.obs;
  final currentBannerIndex = 0.obs;
  final carouselController = carousel.CarouselSliderController();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      await Future.wait([_fetchBanners(), _fetchSchemes()]);
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

  void onBannerChanged(int index) {
    currentBannerIndex.value = index;
  }
}
