import 'package:digital_jeweller/features/auth/data/models/login_request_model.dart';
import '../repositories/auth_repository.dart';
import '../../data/models/login_response_model.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<LoginResponseModel> call({required LoginRequestModel loginRequest}) {
    return repository.login(loginRequest: loginRequest);
  }
}
