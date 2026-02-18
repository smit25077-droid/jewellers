class Customer {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? role;
  final String? jewellerId;
  final String? fcmToken;
  final String? platform;
  final String? profileImage;
  final String? joinedDate;
  final DateTime? createdAt;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.role,
    this.jewellerId,
    this.fcmToken,
    this.platform,
    this.profileImage,
    this.joinedDate,
    this.createdAt,
  });
}
