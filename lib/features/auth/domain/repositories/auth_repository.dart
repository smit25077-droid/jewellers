import '../../data/models/login_response_model.dart';

abstract class AuthRepository {
  Future<LoginResponseModel> login(
    String mobile,
    String password,
    String jewellerCode,
  );

  Future<void> logout();
}
