import '../repositories/auth_repository.dart';
import '../../data/models/login_response_model.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<LoginResponseModel> call(
    String mobile,
    String password,
    String jewellerCode,
  ) {
    return repository.login(mobile, password, jewellerCode);
  }
}
