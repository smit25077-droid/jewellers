import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_banners_use_case.dart';
import 'package:digital_jeweller/features/admin/presentation/dashboard/admin_dashboard_controller.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_schemes_usecase.dart';
import 'package:get/get.dart';

class AdminDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDashboardController>(
      () => AdminDashboardController(
        getBannersUseCase: sl<GetBannersUseCase>(),
        getSchemesUseCase: sl<GetSchemesUseCase>(),
      ),
    );
  }
}
