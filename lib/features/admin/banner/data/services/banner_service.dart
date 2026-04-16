import 'package:digital_jeweller/core/constants/api_endpoints.dart';
import 'package:digital_jeweller/core/error/exceptions.dart';
import '../models/banner_model.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';

abstract class BannerService {
  Future<void> createBanner({
    required String title,
    required String imageUrl,
    required String link,
  });

  Future<List<BannerModel>> getBanners();
}

class BannerServiceImpl implements BannerService {
  final Dio dio;
  final GetStorage storage;

  BannerServiceImpl({required this.dio, required this.storage});

  @override
  Future<void> createBanner({
    required String title,
    required String imageUrl,
    required String link,
  }) async {
    final token = storage.read('token');
    try {
      final formData = FormData.fromMap({
        'title': title,
        'link': link,
        'imageUrl': kIsWeb
          ? MultipartFile.fromBytes(
              await (await XFile(imageUrl)).readAsBytes(),
              filename: 'banner.png',
            )
          : await MultipartFile.fromFile(
              imageUrl,
              filename: imageUrl.split('/').last,
            ),
      });

      await dio.post(
        '${ApiEndpoints.baseUrl}/banners',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to create banner');
    }
  }

  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      final response = await dio.get('${ApiEndpoints.baseUrl}/banners');
      final banners = (response.data['responseData']['banners'] as List)
          .map((banner) => BannerModel.fromJson(banner))
          .toList();
      return banners;
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to fetch banners');
    }
  }
}
