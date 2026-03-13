import 'package:dio/dio.dart';

import '../../../../core/base/base_repository.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/admin_customer_repository.dart';
import '../datasources/admin_customer_remote_data_source.dart';
import '../models/customer_list_response_model.dart';
import '../models/customer_response_model.dart';

class AdminCustomerRepositoryImpl extends BaseRepository
    implements AdminCustomerRepository {
  final AdminCustomerRemoteDataSource dataSource;

  AdminCustomerRepositoryImpl({required this.dataSource});

  @override
  Future<List<Customer>> getCustomers() async {
    return execute(() async {
      final response = await dataSource.getCustomers();
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
  Future<Customer> createCustomer({
    required String name,
    required String phone,
    required String email,
    required String password,
    String? photoPath,
  }) async {
    return await execute(() async {
      final Response response = await dataSource.createCustomer(
        name: name,
        phone: phone,
        email: email,
        password: password,
        photoPath: photoPath,
      );
      final createResponse = CustomerResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      return createResponse.customer;
    });
  }

  @override
  Future<Customer> updateCustomer({
    required String id,
    required String name,
    required String mobile,
    required String email,
    String? photoPath,
  }) async {
    return await execute(() async {
      final Response response = await dataSource.updateCustomer(
        id: id,
        name: name,
        mobile: mobile,
        email: email,
        photoPath: photoPath,
      );
      final updateResponse = CustomerResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      return updateResponse.customer;
    });
  }

  @override
  Future<void> deleteCustomer(String id) async {
    await execute(() async {
      await dataSource.deleteCustomer(id);
      return;
    });
  }
}
