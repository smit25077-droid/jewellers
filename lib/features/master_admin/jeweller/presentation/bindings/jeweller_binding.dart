import 'package:get/get.dart';
import 'package:digital_jeweller/core/service_locator.dart';

import '../../domain/usecases/get_jewellers_usecase.dart';
import '../../domain/usecases/create_jeweller_usecase.dart';
import '../../domain/usecases/delete_jeweller_usecase.dart';
import '../../domain/usecases/update_jeweller_usecase.dart';
import '../../domain/usecases/update_jeweller_details_usecase.dart';
import '../controllers/jeweller_controller.dart';

class JewellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JewellerController>(
      () => JewellerController(
        getJewellersUseCase: sl<GetJewellersUseCase>(),
        createJewellerUseCase: sl<CreateJewellerUseCase>(),
        deleteJewellerUseCase: sl<DeleteJewellerUseCase>(),
        toggleJewellerStatusUseCase: sl<UpdateJewellerStatusUseCase>(),
        updateJewellerDetailsUseCase: sl<UpdateJewellerDetailsUseCase>(),
      ),
    );
  }
}
