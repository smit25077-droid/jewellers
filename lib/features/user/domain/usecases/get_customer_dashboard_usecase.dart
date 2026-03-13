import 'package:digital_jeweller/features/user/domain/entities/customer_dashboard.dart';
import 'package:digital_jeweller/features/user/domain/repositories/customer_dashboard_repository.dart';

class GetCustomerDashboardUseCase {
  final CustomerDashboardRepository repository;

  GetCustomerDashboardUseCase({required this.repository});

  Future<CustomerDashboard> call() async {
    return await repository.getDashboard();
  }
}
