import 'package:digital_jeweller/core/base/base_repository.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../data/models/login_response_model.dart';
import '../../data/datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<LoginResponseModel> login(
    String mobile,
    String password,
    String jewellerCode,
  ) async {
    return await remoteDataSource.login(mobile, password, jewellerCode);
  }

  @override
  Future<void> logout() async {
    // Perform any local logout logic if needed (e.g. clear cache)
  }
}
