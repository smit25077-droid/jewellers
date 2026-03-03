class Jeweller {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String jewellerCode;
  final String? logo;
  final bool? isActive;
  final String? password;
  final String panNumber;
  final String aadhaarNumber;
  final String gstNumber;

  Jeweller({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.jewellerCode,
    this.logo,
    this.isActive,
    this.password,
    required this.panNumber,
    required this.aadhaarNumber,
    required this.gstNumber,
  });

  Jeweller copyWith({
    String? id,
    String? name,
    String? address,
    String? phone,
    String? email,
    String? jewellerCode,
    String? logo,
    bool? isActive,
    String? password,
    String? panNumber,
    String? aadhaarNumber,
    String? gstNumber,
  }) {
    return Jeweller(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      jewellerCode: jewellerCode ?? this.jewellerCode,
      logo: logo ?? this.logo,
      isActive: isActive ?? this.isActive,
      password: password ?? this.password,
      panNumber: panNumber ?? this.panNumber,
      aadhaarNumber: aadhaarNumber ?? this.aadhaarNumber,
      gstNumber: gstNumber ?? this.gstNumber,
    );
  }
}
