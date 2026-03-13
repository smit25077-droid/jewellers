class Banner {
  final String id;
  final String title;
  final String imageUrl;
  final String link;

  Banner({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.link,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      link: json['link'] ?? '',
    );
  }
}
