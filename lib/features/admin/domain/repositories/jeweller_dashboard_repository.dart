import 'package:digital_jeweller/features/admin/domain/entities/jeweller_dashboard.dart';

abstract class JewellerDashboardRepository {
  Future<JewellerDashboard> getDashboard();
}
