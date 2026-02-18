import 'package:digital_jeweller/features/admin/data/datasources/admin_customer_remote_data_source.dart';
import 'package:get/get.dart';
import '../../../../../../core/network/dio_client.dart';
import '../../../data/customers/repositories/customer_repository_impl.dart';
import '../../../data/customers/sources/customer_remote_source.dart';


class AdminCustomerListBinding extends Bindings {
  @override
  void dependencies() {
    // Data Sources
    Get.lazyPut(() => CustomerRemoteSource());

    // Repositories
    Get.lazyPut(
      () => CustomerRepositoryImpl(
        Get.find<DioClient>().dio,
        dataSource: Get.find<AdminCustomerRemoteDataSource>(),
      ),
    );

    // Use Cases
    // Get.lazyPut(() => GetCustomersUseCase());

    // Controllers
    // Get.lazyPut(() => AdminCustomerListController());
    //
    // Get.lazyPut(() => CustomerAddUpdateController());
  }
}
