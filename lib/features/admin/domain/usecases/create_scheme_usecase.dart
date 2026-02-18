import '../entities/scheme.dart';
import '../repositories/scheme_repository.dart';

class CreateSchemeUseCase {
  final SchemeRepository repository;

  CreateSchemeUseCase(this.repository);

  Future<Scheme> execute({
    required String name,
    required String description,
    required double totalAmount,
    required double emiAmount,
    required String jewellerCode,
    required int durationMonths,
    required String startDate,
    required String endDate,
  }) async {
    return await repository.createScheme(
      name: name,
      description: description,
      totalAmount: totalAmount,
      emiAmount: emiAmount,
      jewellerCode: jewellerCode,
      durationMonths: durationMonths,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
