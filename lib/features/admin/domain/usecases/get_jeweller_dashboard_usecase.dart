import 'package:digital_jeweller/features/admin/domain/entities/jeweller_dashboard.dart';
import 'package:digital_jeweller/features/admin/domain/repositories/jeweller_dashboard_repository.dart';

class GetJewellerDashboardUseCase {
  final JewellerDashboardRepository repository;

  GetJewellerDashboardUseCase({required this.repository});

  Future<JewellerDashboard> call() async {
    return await repository.getDashboard();
  }
}
