import 'package:digital_jeweller/features/admin/domain/entities/jeweller_dashboard.dart';

class JewellerDashboardModel extends JewellerDashboard {
  const JewellerDashboardModel({
    required super.totalSchemes,
    required super.totalEnrollments,
    required super.totalWinners,
    required super.recentWinners,
  });

  factory JewellerDashboardModel.fromJson(Map<String, dynamic> json) {
    return JewellerDashboardModel(
      totalSchemes: json['totalSchemes'] as int? ?? 0,
      totalEnrollments: json['totalEnrollments'] as int? ?? 0,
      totalWinners: json['totalWinners'] as int? ?? 0,
      recentWinners: json['recentWinners'] as List<dynamic>? ?? [],
    );
  }
}
