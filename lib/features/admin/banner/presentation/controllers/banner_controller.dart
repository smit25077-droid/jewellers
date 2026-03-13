import 'package:digital_jeweller/features/admin/banner/domain/entities/banner.dart';
import 'package:digital_jeweller/features/admin/banner/domain/usecases/get_banners_usecase.dart';
import 'package:get/get.dart';


class BannerController extends GetxController {
  final GetBannersUseCase _getBannersUseCase;

  BannerController({required GetBannersUseCase getBannersUseCase})
    : _getBannersUseCase = getBannersUseCase;

  // State
  final banners = <Banner>[].obs;
  final isLoading = true.obs;
  final errorMessage = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;
      final result = await _getBannersUseCase.call();

      result.fold(
        (failure) {
          errorMessage.value = failure.message;
          Get.snackbar('Error', failure.message);
        },
        (bannerList) {
          banners.assignAll(bannerList);
        },
      );
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
      Get.snackbar('Error', 'Failed to fetch banners');
    } finally {
      isLoading.value = false;
    }
  }
}
