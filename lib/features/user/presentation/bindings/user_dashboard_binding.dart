import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_banners_use_case.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_schemes_usecase.dart';
import 'package:digital_jeweller/features/user/domain/usecases/join_scheme_use_case.dart';
import 'package:digital_jeweller/features/user/domain/usecases/joined_scheme_use_case.dart';
import 'package:digital_jeweller/features/user/presentation/controllers/user_controller.dart';
import 'package:get/get.dart';

class UserDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => UserController(
        getSchemesUseCase: sl<GetSchemesUseCase>(),
        getBannersUseCase: sl<GetBannersUseCase>(),
        joinSchemeUseCase: sl<JoinSchemeUseCase>(),
        joinedSchemeUseCase: sl<JoinedSchemeUseCase>(),
      ),
    );
  }
}
