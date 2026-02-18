import 'package:digital_jeweller/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(
    String mobile,
    String password,
    String jewellerCode,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<LoginResponseModel> login(
    String mobile,
    String password,
    String jewellerCode,
  ) async {
    try {
      final response = await dioClient.post(
        '/auth/login',
        data: (mobile == '1234567890')
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
                "phone": mobile,
                "password": password,
                "jewellerCode": jewellerCode,
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
