import 'package:digital_jeweller/features/admin/data/models/scheme_model.dart';
import 'package:digital_jeweller/features/user/domain/entities/joined_scheme.dart';

class JoinedSchemeModel extends JoinedScheme {
  JoinedSchemeModel({
    required super.id,
    required super.scheme,
    required super.status,
    required super.enrolledAt,
    required super.jewellerName,
  });

  factory JoinedSchemeModel.fromJson(Map<String, dynamic> json) {
    return JoinedSchemeModel(
      id: json['_id'] ?? '',
      scheme: SchemeModel.fromJson(json['scheme'] ?? {}),
      status: json['status'] ?? 'active',
      enrolledAt: json['enrolledAt'] != null
          ? DateTime.parse(json['enrolledAt'])
          : DateTime.now(),
      jewellerName: (json['jeweller'] is Map)
          ? (json['jeweller']['name'] ?? '')
          : '',
    );
  }
}
