import 'package:digital_jeweller/core/base/base_repository.dart';
import 'package:digital_jeweller/features/user/data/datasources/customer_dashboard_datasource.dart';
import 'package:digital_jeweller/features/user/domain/entities/customer_dashboard.dart';
import 'package:digital_jeweller/features/user/domain/repositories/customer_dashboard_repository.dart';

class CustomerDashboardRepositoryImpl extends BaseRepository
    implements CustomerDashboardRepository {
  final CustomerDashboardDataSource dataSource;

  CustomerDashboardRepositoryImpl({required this.dataSource});

  @override
  Future<CustomerDashboard> getDashboard() async {
    return execute(() async => await dataSource.getDashboard());
  }
}
