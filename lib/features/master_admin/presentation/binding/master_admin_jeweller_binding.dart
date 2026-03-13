import 'package:get/get.dart';
import 'package:digital_jeweller/core/service_locator.dart';
import '../../jeweller/domain/usecases/get_jewellers_usecase.dart';
import '../../jeweller/domain/usecases/create_jeweller_usecase.dart';
import '../../jeweller/domain/usecases/delete_jeweller_usecase.dart';
import '../../jeweller/domain/usecases/update_jeweller_usecase.dart';
import '../../jeweller/presentation/controllers/jeweller_controller.dart';

class MasterAdminJewellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JewellerController>(
      () => JewellerController(
        getJewellersUseCase: sl<GetJewellersUseCase>(),
        createJewellerUseCase: sl<CreateJewellerUseCase>(),
        deleteJewellerUseCase: sl<DeleteJewellerUseCase>(),
        toggleJewellerStatusUseCase: sl<UpdateJewellerStatusUseCase>(),
      ),
    );
  }
}
