import 'package:get/get.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../service_locator.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // AuthController is needed globally for user state and profile
    Get.put<AuthController>(
      AuthController(loginUseCase: sl<LoginUseCase>()),
      permanent: true,
    );
  }
}
