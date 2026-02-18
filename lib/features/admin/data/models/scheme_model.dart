import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';

class SchemeModel extends Scheme {
  SchemeModel({
    required String id,
    required String name,
    required String description,
    required double totalAmount,
    required double emiAmount,
    required int durationMonths,
    required String jewellerName,
    required bool isActive,
    required DateTime startDate,
    required DateTime endDate,
  }) : super(
         id: id,
         name: name,
         description: description,
         totalAmount: totalAmount,
         emiAmount: emiAmount,
         durationMonths: durationMonths,
         jewellerName: jewellerName,
         isActive: isActive,
         startDate: startDate,
         endDate: endDate,
       );

  factory SchemeModel.fromJson(Map<String, dynamic> json) {
    return SchemeModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      emiAmount: (json['emiAmount'] as num?)?.toDouble() ?? 0.0,
      durationMonths: json['durationMonths'] ?? 0,
      jewellerName: (json['jeweller'] is Map)
          ? (json['jeweller']['name'] ?? 'Unknown Jeweller')
          : 'Unknown Jeweller',
      isActive: json['isActive'] ?? false,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'])
          : DateTime.now(),
    );
  }
}
