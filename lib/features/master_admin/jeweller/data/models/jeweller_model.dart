import 'package:digital_jeweller/features/master_admin/jeweller/domain/entities/jeweller.dart';

class JewellerModel extends Jeweller {
  JewellerModel({
    required super.id,
    required super.name,
    required super.address,
    required super.phone,
    required super.email,
    required super.jewellerCode,
    super.logo,
    super.isActive,
    super.password,
    required super.panNumber,
    required super.aadhaarNumber,
    required super.gstNumber,
  });

  factory JewellerModel.fromJson(Map<String, dynamic> json) {
    return JewellerModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      jewellerCode: json['jewellerCode'] ?? '',
      logo: json['logo'],
      isActive: json['isActive'],
      panNumber: json['panNumber'] ?? '',
      aadhaarNumber: json['aadhaarNumber'] ?? '',
      gstNumber: json['gstNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'jewellerCode': jewellerCode,
      'password': password,
      'panNumber': panNumber,
      'aadhaarNumber': aadhaarNumber,
      'gstNumber': gstNumber,
    };
  }
}

class JewellerListResponseModel {
  final int count;
  final List<JewellerModel> jewellers;

  JewellerListResponseModel({required this.count, required this.jewellers});

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
