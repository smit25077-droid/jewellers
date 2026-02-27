import 'package:digital_jeweller/core/base/base_repository.dart';
import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/auth/data/models/login_request_model.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../data/models/login_response_model.dart';
import '../../data/datasources/auth_service.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  // final AuthService authService;

  AuthRepositoryImpl();

  @override
  Future<LoginResponseModel> login({required LoginRequestModel loginRequest}
  ) async {
    return await sl<AuthService>().login(loginRequest: loginRequest);
  }

  @override
  Future<void> logout() async {
    // Perform any local logout logic if needed (e.g. clear cache)
  }
}
