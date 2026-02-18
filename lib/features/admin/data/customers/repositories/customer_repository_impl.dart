import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../../../domain/customers/repositories/customer_repository.dart';
import '../../datasources/admin_customer_remote_data_source.dart';
import '../models/customer_list_response_model.dart';
import '../models/customer_response_model.dart';
import '../../../../../../core/base/base_repository.dart';
import '../../../../../../core/constants/api_endpoints.dart';
import '../../../domain/entities/customer.dart';

class CustomerRepositoryImpl extends BaseRepository
    implements CustomerRepository {
  final AdminCustomerRemoteDataSource dataSource;
  final Dio dio;
  final GetStorage _storage = GetStorage();

  CustomerRepositoryImpl(this.dio, {required this.dataSource});

  @override
  Future<List<Customer>> getCustomers() async {
    return execute(() async {
      final token = _storage.read('token');
      final response = await dio.get(
        '${ApiEndpoints.baseUrl}/customers',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      final listResponse = CustomerListResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      return listResponse.customers;
    });
  }

  @override
  Future<Customer> getCustomerById(String id) async {
    return await execute(() async {
      final Response response = await dataSource.getCustomerById(id);
      final detailResponse = CustomerResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      return detailResponse.customer;
    });
  }

  @override
  Future<void> addCustomer(Map<String, dynamic> customerData) async {
    await execute(() async {
      await dataSource.createCustomer(
        name: customerData['name'],
        phone: customerData['phone'],
        email: customerData['email'],
        password: customerData['password'],
      );
    });
  }

  @override
  Future<void> updateCustomer(
    String id,
    Map<String, dynamic> customerData,
  ) async {
    await execute(() async {
      await dataSource.updateCustomer(
        id: id,
        name: customerData['name'],
        mobile: customerData['phone'],
        email: customerData['email'],
      );
    });
  }

  @override
  Future<void> deleteCustomer(String id) async {
    await execute(() async {
      await dataSource.deleteCustomer(id);
    });
  }
}
