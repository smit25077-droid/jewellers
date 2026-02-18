import '../entities/scheme.dart';

abstract class SchemeRepository {
  Future<List<Scheme>> getSchemes();

  Future<Scheme> createScheme({
    required String name,
    required String description,
    required double totalAmount,
    required double emiAmount,
    required String jewellerCode,
    required int durationMonths,
    required String startDate,
    required String endDate,
  });

  Future<Scheme> updateScheme({
    required String id,
    Map<String, dynamic>? updateData,
  });

  Future<void> deleteScheme(String id);
}
