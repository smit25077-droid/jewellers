import 'package:digital_jeweller/features/user/domain/entities/joined_scheme.dart';

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
    String? schemeImagePath,
  });

  Future<Scheme> updateScheme({
    required String id,
    Map<String, dynamic>? updateData,
    String? schemeImagePath,
  });

  Future<void> deleteScheme(String id);
  Future<void> joinScheme(String schemeId);
  Future<List<JoinedScheme>> getJoinedSchemes();
}
