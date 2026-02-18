import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/auth/domain/usecases/login_usecase.dart';
import 'package:digital_jeweller/features/auth/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(loginUseCase: sl<LoginUseCase>()),
    );
  }
}
