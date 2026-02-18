import 'package:dio/dio.dart';
import '../../../../../../core/base/base_service.dart';
import '../../../../../../core/constants/api_endpoints.dart';

class CustomerRemoteSource extends BaseService {
  CustomerRemoteSource();

  Future<Response> getCustomers() async {
    return await get(ApiEndpoints.customers);
  }

  Future<Response> getCustomerById(String id) async {
    return await get(ApiEndpoints.withId(ApiEndpoints.customers, id));
  }

  Future<Response> createCustomer({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    return await post(
      ApiEndpoints.customers,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      },
    );
  }

  Future<Response> updateCustomer({
    required String id,
    required String name,
    required String mobile,
    required String email,
  }) async {
    return await put(
      ApiEndpoints.withId(ApiEndpoints.customers, id),
      data: {'name': name, 'mobile': mobile, 'email': email},
    );
  }

  Future<Response> deleteCustomer(String id) async {
    return await delete(ApiEndpoints.withId(ApiEndpoints.customers, id));
  }
}
