import 'jeweller_model.dart';

/// Model for the jewellers list API response:
/// {
///   "responseStatus": 200,
///   "responseMessage": "Jewellers retrieved",
///   "responseData": {
///     "count": 3,
///     "jewellers": [ ... ]
///   }
/// }
class JewellerListResponseModel {
  final int count;
  final List<JewellerModel> jewellers;

  JewellerListResponseModel({
    required this.count,
    required this.jewellers,
  });

  factory JewellerListResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jewellersList = json['jewellers'] ?? [];
    return JewellerListResponseModel(
      count: json['count'] is int
          ? json['count'] as int
          : int.tryParse(json['count']?.toString() ?? '0') ?? 0,
      jewellers: jewellersList
          .map((e) => JewellerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
