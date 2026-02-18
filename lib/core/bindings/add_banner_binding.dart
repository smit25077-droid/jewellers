
import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/create_banner_use_case.dart';
import 'package:digital_jeweller/features/admin/presentation/controllers/add_banner_controller.dart';
import 'package:get/get.dart';

class AddBannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBannerController>(
      () => AddBannerController(
        createBannerUseCase: sl<CreateBannerUseCase>(),
      ),
    );
  }
}
