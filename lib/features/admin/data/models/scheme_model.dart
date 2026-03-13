import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';

class SchemeModel extends Scheme {
  SchemeModel({
    required super.id,
    required super.name,
    required super.description,
    required super.totalAmount,
    required super.emiAmount,
    required super.durationMonths,
    required super.jewellerName,
    required super.isActive,
    required super.startDate,
    required super.endDate,
    super.schemeImage,
  });

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
      schemeImage: json['schemeImage'],
    );
  }
}
