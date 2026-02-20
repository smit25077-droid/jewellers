import 'package:digital_jeweller/features/admin/domain/repositories/scheme_repository.dart';

class JoinSchemeUseCase {
  final SchemeRepository repository;

  JoinSchemeUseCase({required this.repository});

  Future<void> call(String schemeId) async {
    return await repository.joinScheme(schemeId);
  }
}
