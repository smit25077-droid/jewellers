class LoginResponseModel {
  final int responseStatus;
  final String responseMessage;
  final ResponseData? responseData;

  LoginResponseModel({
    required this.responseStatus,
    required this.responseMessage,
    this.responseData,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      responseStatus: json['responseStatus'],
      responseMessage: json['responseMessage'],
      responseData: json['responseData'] != null
          ? ResponseData.fromJson(json['responseData'])
          : null,
    );
  }
}

class ResponseData {
  final String token;
  final User user;

  ResponseData({required this.token, required this.user});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final Jeweller? jeweller;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.jeweller,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ??  '',
      role: json['role'] ?? '',
      jeweller: json['jeweller'] != null
          ? Jeweller.fromJson(json['jeweller'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'jeweller': jeweller?.toJson(),
    };
  }
}

class Jeweller {
  final String id;
  final String name;
  final String code;

  Jeweller({required this.id, required this.name, required this.code});

  factory Jeweller.fromJson(Map<String, dynamic> json) {
    return Jeweller(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code};
  }
}
