import 'package:digital_jeweller/core/base/base_repository.dart';
import 'package:digital_jeweller/features/admin/data/datasources/jeweller_dashboard_datasource.dart';
import 'package:digital_jeweller/features/admin/domain/entities/jeweller_dashboard.dart';
import 'package:digital_jeweller/features/admin/domain/repositories/jeweller_dashboard_repository.dart';

class JewellerDashboardRepositoryImpl extends BaseRepository
    implements JewellerDashboardRepository {
  final JewellerDashboardDataSource dataSource;

  JewellerDashboardRepositoryImpl({required this.dataSource});

  @override
  Future<JewellerDashboard> getDashboard() async {
    return execute(() async => await dataSource.getDashboard());
  }
}
