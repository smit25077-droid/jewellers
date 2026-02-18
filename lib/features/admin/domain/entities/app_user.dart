class AppUser {
  final String id;
  final String name;
  final String number;
  final String password;
  final String idProof;
  final String jewellerId;
  final String? schemeId;

  AppUser({
    required this.id,
    required this.name,
    required this.number,
    required this.password,
    required this.idProof,
    required this.jewellerId,
    this.schemeId,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'number': number,
    'password': password,
    'idProof': idProof,
    'jewellerId': jewellerId,
    'schemeId': schemeId,
  };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    id: json['id'],
    name: json['name'],
    number: json['number'],
    password: json['password'],
    idProof: json['idProof'],
    jewellerId: json['jewellerId'],
    schemeId: json['schemeId'],
  );
}
