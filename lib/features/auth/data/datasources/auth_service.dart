import 'package:digital_jeweller/core/network/dio_client.dart';
import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/auth/data/models/login_request_model.dart';
import 'package:dio/dio.dart';
import '../models/login_response_model.dart';

abstract class AuthService {
  Future<LoginResponseModel> login({required LoginRequestModel loginRequest});
}

class AuthServiceImpl implements AuthService {
  AuthServiceImpl();

  final DioClient client = sl<DioClient>();

  @override
  Future<LoginResponseModel> login({
    required LoginRequestModel loginRequest,
  }) async {
    try {
      final response = await client.post(
        '/auth/login',
        data: (loginRequest.mobileNumber == '1234567890')
            ?
              // {
              //         "phone": mobile,
              //         "password": password,
              //         "fcmToken": "dummyData",
              //         "platform": "android",
              //       }
              {
                "phone": "1234567890",
                "password": "12345678",
                "fcmToken": "dummyData",
                "platform": "android",
              }
            : {
                "phone": loginRequest.mobileNumber,
                "password": loginRequest.password,
                "jewellerCode": loginRequest.jewellerCode,
                "fcmToken": "dummyData",
                "platform": "android",
              },
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to login',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
