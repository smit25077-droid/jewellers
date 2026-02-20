import '../../../../core/base/base_repository.dart';
import '../../domain/entities/scheme.dart';
import '../../domain/repositories/scheme_repository.dart';
import 'package:digital_jeweller/features/user/domain/entities/joined_scheme.dart';
import '../datasources/scheme_remote_datasource.dart';

class SchemeRepositoryImpl extends BaseRepository implements SchemeRepository {
  final SchemeRemoteDataSource remoteDataSource;

  SchemeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Scheme>> getSchemes() async {
    return execute(() async {
      return await remoteDataSource.getSchemes();
    });
  }

  @override
  Future<Scheme> createScheme({
    required String name,
    required String description,
    required double totalAmount,
    required double emiAmount,
    required String jewellerCode,
    required int durationMonths,
    required String startDate,
    required String endDate,
  }) async {
    return execute(() async {
      return await remoteDataSource.createScheme(
        name: name,
        description: description,
        totalAmount: totalAmount,
        emiAmount: emiAmount,
        jewellerCode: jewellerCode,
        durationMonths: durationMonths,
        startDate: startDate,
        endDate: endDate,
      );
    });
  }

  @override
  Future<Scheme> updateScheme({
    required String id,
    Map<String, dynamic>? updateData,
  }) async {
    return execute(() async {
      return await remoteDataSource.updateScheme(
        id: id,
        updateData: updateData,
      );
    });
  }

  @override
  Future<void> deleteScheme(String id) async {
    return execute(() async {
      await remoteDataSource.deleteScheme(id);
    });
  }

  @override
  Future<void> joinScheme(String schemeId) async {
    return execute(() async {
      await remoteDataSource.joinScheme(schemeId);
    });
  }

  @override
  Future<List<JoinedScheme>> getJoinedSchemes() async {
    return execute(() async {
      return await remoteDataSource.getJoinedSchemes();
    });
  }
}
