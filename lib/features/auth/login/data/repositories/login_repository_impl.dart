import 'package:digital_jeweller/core/base/base_repository.dart';
import '../../domain/repositories/login_repository.dart';
import '../models/login_model.dart';
import '../services/login_service.dart';

class LoginRepositoryImpl extends BaseRepository implements LoginRepository {
  final LoginService loginService;

  LoginRepositoryImpl({required this.loginService});

  @override
  Future<LoginResponseModel> login({
    required LoginRequestModel loginRequest,
  }) async {
    return await loginService.login(loginRequest);
  }

  @override
  Future<void> logout() async {
    await loginService.logout();
  }
}
