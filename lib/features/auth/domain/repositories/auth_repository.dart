import 'package:digital_jeweller/features/auth/data/models/login_request_model.dart';

import '../../data/models/login_response_model.dart';

abstract class AuthRepository {
  Future<LoginResponseModel> login({required LoginRequestModel loginRequest});

  Future<void> logout();
}
