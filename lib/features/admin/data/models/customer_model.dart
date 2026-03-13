import '../../domain/entities/customer.dart';

class CustomerModel extends Customer {
  CustomerModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.role,
    required super.jewellerId,
    super.fcmToken,
    super.platform,
    super.createdAt,
    super.profileImage,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? json['mobile'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
      jewellerId: (json['jeweller'] ?? '').toString(),
      fcmToken: json['fcmToken']?.toString(),
      platform: json['platform']?.toString(),
      profileImage: json['photo']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      // Backend expects `phone` when creating and `mobile` when updating.
      'phone': phone,
      'role': role,
      'jeweller': jewellerId,
      if (fcmToken != null) 'fcmToken': fcmToken,
      if (platform != null) 'platform': platform,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
    };
  }
}
