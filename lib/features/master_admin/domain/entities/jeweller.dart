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
}
