import '../entities/scheme.dart';
import '../repositories/scheme_repository.dart';

class GetSchemesUseCase {
  final SchemeRepository repository;

  GetSchemesUseCase(this.repository);

  Future<List<Scheme>> execute() async {
    return await repository.getSchemes();
  }

  // Adding call() to avoid breaking UserController if it still uses it
  Future<List<Scheme>> call() async {
    return await execute();
  }
}
