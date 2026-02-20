import 'package:digital_jeweller/features/admin/domain/repositories/scheme_repository.dart';
import 'package:digital_jeweller/features/user/domain/entities/joined_scheme.dart';

class JoinedSchemeUseCase {
  final SchemeRepository repository;

  JoinedSchemeUseCase({required this.repository});

  Future<List<JoinedScheme>> call() async {
    return await repository.getJoinedSchemes();
  }
}
