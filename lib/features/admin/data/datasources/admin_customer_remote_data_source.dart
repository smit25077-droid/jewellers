import 'package:dio/dio.dart';

import '../../../../core/base/base_service.dart';
import '../../../../core/constants/api_endpoints.dart';

/// Remote data source for admin customer management
class AdminCustomerRemoteDataSource extends BaseService {
  AdminCustomerRemoteDataSource();



  /// GET /customers - list all customers for current jeweller
  Future<Response> getCustomers() async {
    return await get(
      ApiEndpoints.customers,
    );
  }

  /// GET /customers/{id} - get customer details
  Future<Response> getCustomerById(String id) async {
    return await get(
      ApiEndpoints.withId(ApiEndpoints.customers, id),
    );
  }

  /// POST /customers - create customer
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

  /// PUT /customers/{id} - update customer
  ///
  /// Note: API expects `mobile` field for updating phone number.
  Future<Response> updateCustomer({
    required String id,
    required String name,
    required String mobile,
    required String email,
  }) async {
    return await put(
      ApiEndpoints.withId(ApiEndpoints.customers, id),
      data: {
        'name': name,
        'mobile': mobile,
        'email': email,
      },
    );
  }

  /// DELETE /customers/{id} - delete customer
  Future<Response> deleteCustomer(String id) async {
    return await delete(
      ApiEndpoints.withId(ApiEndpoints.customers, id),
    );
  }
}

