import 'package:digital_jeweller/features/user/presentation/controllers/customer_home_controller.dart';
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
