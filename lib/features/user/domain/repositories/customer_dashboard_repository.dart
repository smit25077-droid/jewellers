import 'package:digital_jeweller/features/user/domain/entities/customer_dashboard.dart';

abstract class CustomerDashboardRepository {
  Future<CustomerDashboard> getDashboard();
}
