import 'package:digital_jeweller/features/user/domain/entities/customer_dashboard.dart';

class CustomerDashboardSchemeModel extends CustomerDashboardScheme {
  const CustomerDashboardSchemeModel({
    required super.id,
    required super.name,
    super.description,
    super.totalAmount,
    super.emiAmount,
    super.status,
  });

  factory CustomerDashboardSchemeModel.fromJson(Map<String, dynamic> json) {
    return CustomerDashboardSchemeModel(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      emiAmount: (json['emiAmount'] as num?)?.toDouble(),
      status: json['status'] as String?,
    );
  }
}

class PaymentStatModel extends PaymentStat {
  const PaymentStatModel({
    required super.schemeId,
    required super.schemeName,
    required super.totalPaid,
    required super.remainingAmount,
    required super.status,
    super.nextDueDate,
  });

  factory PaymentStatModel.fromJson(Map<String, dynamic> json) {
    return PaymentStatModel(
      schemeId: json['schemeId'] as String? ?? '',
      schemeName: json['schemeName'] as String? ?? '',
      totalPaid: (json['totalPaid'] as num?)?.toDouble() ?? 0.0,
      remainingAmount: (json['remainingAmount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? '',
      nextDueDate: json['nextDueDate'] != null
          ? DateTime.tryParse(json['nextDueDate'] as String)
          : null,
    );
  }
}

class CustomerDashboardModel extends CustomerDashboard {
  const CustomerDashboardModel({
    required super.jewellerSchemesCount,
    required super.jewellerSchemes,
    required super.myJoinedSchemesCount,
    required super.myJoinedSchemes,
    required super.recentWinners,
    required super.paymentStats,
  });

  factory CustomerDashboardModel.fromJson(Map<String, dynamic> json) {
    final jewellerSchemesData =
        json['jewellerSchemes'] as Map<String, dynamic>? ?? {};
    final myJoinedSchemesData =
        json['myJoinedSchemes'] as Map<String, dynamic>? ?? {};

    return CustomerDashboardModel(
      jewellerSchemesCount: jewellerSchemesData['count'] as int? ?? 0,
      jewellerSchemes: ((jewellerSchemesData['schemes'] as List?) ?? [])
          .map(
            (e) => CustomerDashboardSchemeModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      myJoinedSchemesCount: myJoinedSchemesData['count'] as int? ?? 0,
      myJoinedSchemes: ((myJoinedSchemesData['schemes'] as List?) ?? [])
          .map(
            (e) => CustomerDashboardSchemeModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      recentWinners: json['recentWinners'] as List<dynamic>? ?? [],
      paymentStats: ((json['paymentStats'] as List?) ?? [])
          .map((e) => PaymentStatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
