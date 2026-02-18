import '../entities/scheme.dart';
import '../repositories/scheme_repository.dart';

class AdminSchemesAddUpdateUsecase {
  final SchemeRepository repository;

  AdminSchemesAddUpdateUsecase(this.repository);

  Future<List<Scheme>> execute() async {
    return await repository.getSchemes();
  }
}
