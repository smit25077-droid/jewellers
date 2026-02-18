class CustomerModel {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String? profileImage;
  final String? joinedDate;

  CustomerModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.profileImage,
    this.joinedDate,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      name: (json['name'] ?? 'Unknown').toString(),
      phone: (json['phone'] ?? json['mobile'] ?? '').toString(),
      email: json['email']?.toString(),
      profileImage: json['profile_image']?.toString(),
      joinedDate:
          json['created_at']?.toString() ?? json['joined_date']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'profile_image': profileImage,
      'created_at': joinedDate,
    };
  }
}
