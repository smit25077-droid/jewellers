import 'package:get/get.dart';
import 'package:digital_jeweller/features/auth/login/presentation/controllers/login_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // LoginController is needed globally for user state and profile
    Get.put<LoginController>(LoginController(), permanent: true);
  }
}
