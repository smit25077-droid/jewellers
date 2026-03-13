import '../../data/models/login_model.dart';

abstract class LoginRepository {
  Future<LoginResponseModel> login({required LoginRequestModel loginRequest});
  Future<void> logout();
}
