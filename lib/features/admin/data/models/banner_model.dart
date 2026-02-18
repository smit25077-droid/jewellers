
import 'package:digital_jeweller/features/admin/domain/entities/banner.dart';

class BannerModel extends Banner {
  BannerModel({
    required String id,
    required String title,
    required String imageUrl,
    required String link,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          link: link,
        );

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      link: json['link'],
    );
  }
}
