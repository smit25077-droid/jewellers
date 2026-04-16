import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';

import '../../../../core/base/base_service.dart';
import '../../../../core/constants/api_endpoints.dart';

/// Remote data source for admin customer management
class AdminCustomerRemoteDataSource extends BaseService {
  AdminCustomerRemoteDataSource();

  /// GET /customers - list all customers for current jeweller
  Future<Response> getCustomers() async {
    return await get(ApiEndpoints.customers);
  }

  /// GET /customers/{id} - get customer details
  Future<Response> getCustomerById(String id) async {
    return await get(ApiEndpoints.withId(ApiEndpoints.customers, id));
  }

  /// POST /customers - create customer (multipart/form-data)
  Future<Response> createCustomer({
    required String name,
    required String phone,
    required String email,
    required String password,
    String? photoPath,
    String fcmToken = 'dummy_token',
    String platform = 'android',
  }) async {
    final fields = <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'fcmToken': fcmToken,
      'platform': platform,
    };

    if (photoPath != null && photoPath.isNotEmpty) {
      if (kIsWeb) {
        final XFile file = XFile(photoPath);
        fields['photo'] = MultipartFile.fromBytes(
          await file.readAsBytes(),
          filename: file.name,
        );
      } else {
        fields['photo'] = await MultipartFile.fromFile(
          photoPath,
          filename: photoPath.split('/').last,
        );
      }
    }

    return await post(ApiEndpoints.customers, data: FormData.fromMap(fields));
  }

  /// PUT /customers/{id} - update customer
  ///
  /// Note: API expects `mobile` field for updating phone number.
  Future<Response> updateCustomer({
    required String id,
    required String name,
    required String mobile,
    required String email,
    String? photoPath,
  }) async {
    FormData formData = FormData.fromMap({
      'name': name,
      'mobile': mobile,
      'email': email,
      if (photoPath != null)
        'photo': kIsWeb
          ? MultipartFile.fromBytes(
              await (await XFile(photoPath)).readAsBytes(),
              filename: 'photo.png',
            )
          : await MultipartFile.fromFile(
              photoPath,
              filename: photoPath.split('/').last,
            ),
    });

    return await put(
      ApiEndpoints.withId(ApiEndpoints.customers, id),
      data: formData,
    );
  }

  /// DELETE /customers/{id} - delete customer
  Future<Response> deleteCustomer(String id) async {
    return await delete(ApiEndpoints.withId(ApiEndpoints.customers, id));
  }
}
