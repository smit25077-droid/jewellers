import 'package:get/get.dart';
import '../../../../../core/service_locator.dart';
import '../controllers/banner_controller.dart';
import '../../domain/usecases/get_banners_usecase.dart';

class BannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BannerController>(
      () => BannerController(getBannersUseCase: sl<GetBannersUseCase>()),
    );
  }
}
