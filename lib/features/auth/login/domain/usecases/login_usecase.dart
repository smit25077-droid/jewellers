import '../../data/models/login_model.dart';
import '../repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<LoginResponseModel> call({required LoginRequestModel loginRequest}) {
    return repository.login(loginRequest: loginRequest);
  }
}
