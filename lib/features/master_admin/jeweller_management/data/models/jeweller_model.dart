import '../../domain/entities/jeweller.dart';

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
      id: json['_id'] ?? '',
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
