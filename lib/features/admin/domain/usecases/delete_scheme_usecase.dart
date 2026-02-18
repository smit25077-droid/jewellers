import '../repositories/scheme_repository.dart';

class DeleteSchemeUseCase {
  final SchemeRepository repository;

  DeleteSchemeUseCase(this.repository);

  Future<void> execute(String id) async {
    return await repository.deleteScheme(id);
  }
}
