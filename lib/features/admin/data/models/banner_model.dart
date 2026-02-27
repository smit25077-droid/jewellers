
import 'package:digital_jeweller/features/admin/domain/entities/banner.dart';

class BannerModel extends Banner {
  BannerModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.link,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      link: json['link'],
    );
  }
}
