import 'package:get/get.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // AuthController is needed globally for user state and profile
    Get.put<AuthController>(
      AuthController(),
      permanent: true,
    );
  }
}
