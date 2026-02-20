import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';

class JoinedScheme {
  final String id;
  final Scheme scheme;
  final String status;
  final DateTime enrolledAt;
  final String jewellerName;

  JoinedScheme({
    required this.id,
    required this.scheme,
    required this.status,
    required this.enrolledAt,
    required this.jewellerName,
  });
}
