class Scheme {
  final String id;
  final String name;
  final String description;
  final double totalAmount;
  final double emiAmount;
  final int durationMonths;
  final String jewellerName;
  final bool isActive;
  final DateTime startDate;
  final DateTime endDate;

  Scheme({
    required this.id,
    required this.name,
    required this.description,
    required this.totalAmount,
    required this.emiAmount,
    required this.durationMonths,
    required this.jewellerName,
    required this.isActive,
    required this.startDate,
    required this.endDate,
  });
}
