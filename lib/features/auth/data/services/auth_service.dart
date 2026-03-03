import 'package:dio/dio.dart';
import 'package:digital_jeweller/core/network/dio_client.dart';
import 'package:get_storage/get_storage.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

abstract class AuthService {
  Future<LoginResponseModel> login(LoginRequestModel request);

  Future<void> logout();
}

class AuthServiceImpl implements AuthService {
  final DioClient dioClient;
  final GetStorage storage;

  AuthServiceImpl({required this.dioClient, required this.storage});

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await dioClient.post(
        '/auth/login',
        data: request,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginResponse = LoginResponseModel.fromJson(response.data);
        // Save token and user data
        await storage.write('token', loginResponse.responseData?.token);
        await storage.write('role', loginResponse.responseData?.user.role);
        await storage.write('userId', loginResponse.responseData?.user.id);

        return loginResponse;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Login failed',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/login'),
        error: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await storage.remove('token');
      await storage.remove('role');
      await storage.remove('userId');
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }
}
