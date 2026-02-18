import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_schemes_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/create_scheme_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/update_scheme_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/delete_scheme_usecase.dart';
import 'package:digital_jeweller/features/admin/presentation/schemes/controller/scheme_controller.dart';
import 'package:digital_jeweller/features/admin/presentation/schemes/controller/admin_scheme_add_update_controller.dart';
import 'package:get/get.dart';

class SchemeBinding extends Bindings {
  @override
  void dependencies() {
    // SchemeController for listing
    Get.lazyPut<SchemeController>(
      () => SchemeController(
        getSchemesUseCase: sl<GetSchemesUseCase>(),
        createSchemeUseCase: sl<CreateSchemeUseCase>(),
        updateSchemeUseCase: sl<UpdateSchemeUseCase>(),
        deleteSchemeUseCase: sl<DeleteSchemeUseCase>(),
      ),
    );

    // AdminSchemeAddUpdateController for add/update
    Get.lazyPut<AdminSchemeAddUpdateController>(
      () => AdminSchemeAddUpdateController(
        createSchemeUseCase: sl<CreateSchemeUseCase>(),
        updateSchemeUseCase: sl<UpdateSchemeUseCase>(),
        deleteSchemeUseCase: sl<DeleteSchemeUseCase>(),
      ),
    );
  }
}
