import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_banners_use_case.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_schemes_usecase.dart';
import 'package:digital_jeweller/features/user/presentation/controllers/customer_home_controller.dart';
import 'package:digital_jeweller/features/user/presentation/controllers/user_controller.dart';
import 'package:get/get.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerHomeController());
    // Get.lazyPut(
    //   () => UserController(
    //     getSchemesUseCase: sl<GetSchemesUseCase>(),
    //     getBannersUseCase: sl<GetBannersUseCase>(),
    //   ),
    // );
  }
}
