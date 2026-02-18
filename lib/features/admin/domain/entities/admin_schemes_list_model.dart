class AdBanner {
  final String id;
  final String imageUrl;
  final String jewellerId;

  AdBanner({
    required this.id,
    required this.imageUrl,
    required this.jewellerId,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'imageUrl': imageUrl,
    'jewellerId': jewellerId,
  };

  factory AdBanner.fromJson(Map<String, dynamic> json) => AdBanner(
    id: json['id'],
    imageUrl: json['imageUrl'],
    jewellerId: json['jewellerId'],
  );
}
