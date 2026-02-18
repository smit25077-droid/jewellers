class JewellerCreateRequest {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String jewellerCode;
  final String password;
  final String panNumber;
  final String aadhaarNumber;
  final String gstNumber;

  JewellerCreateRequest({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.jewellerCode,
    required this.password,
    required this.panNumber,
    required this.aadhaarNumber,
    required this.gstNumber,
  });
}
