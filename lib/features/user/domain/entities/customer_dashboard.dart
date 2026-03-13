class CustomerDashboardScheme {
  final String id;
  final String name;
  final String? description;
  final double? totalAmount;
  final double? emiAmount;
  final String? status;

  const CustomerDashboardScheme({
    required this.id,
    required this.name,
    this.description,
    this.totalAmount,
    this.emiAmount,
    this.status,
  });
}

class PaymentStat {
  final String schemeId;
  final String schemeName;
  final double totalPaid;
  final double remainingAmount;
  final String status;
  final DateTime? nextDueDate;

  const PaymentStat({
    required this.schemeId,
    required this.schemeName,
    required this.totalPaid,
    required this.remainingAmount,
    required this.status,
    this.nextDueDate,
  });
}

class CustomerDashboard {
  final int jewellerSchemesCount;
  final List<CustomerDashboardScheme> jewellerSchemes;
  final int myJoinedSchemesCount;
  final List<CustomerDashboardScheme> myJoinedSchemes;
  final List<dynamic> recentWinners;
  final List<PaymentStat> paymentStats;

  const CustomerDashboard({
    required this.jewellerSchemesCount,
    required this.jewellerSchemes,
    required this.myJoinedSchemesCount,
    required this.myJoinedSchemes,
    required this.recentWinners,
    required this.paymentStats,
  });
}
