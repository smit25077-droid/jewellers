import '../entities/scheme.dart';
import '../repositories/scheme_repository.dart';

class UpdateSchemeUseCase {
  final SchemeRepository repository;

  UpdateSchemeUseCase(this.repository);

  Future<Scheme> execute({
    required String id,
    Map<String, dynamic>? updateData,
  }) async {
    return await repository.updateScheme(id: id, updateData: updateData);
  }
}
