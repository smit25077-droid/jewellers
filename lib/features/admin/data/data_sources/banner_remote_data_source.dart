import 'package:digital_jeweller/core/constants/api_endpoints.dart';
import 'package:digital_jeweller/core/error/exceptions.dart';
import 'package:digital_jeweller/features/admin/data/models/banner_model.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

abstract class BannerRemoteDataSource {
  Future<void> createBanner({
    required String title,
    required String imageUrl,
    required String link,
  });

  Future<List<BannerModel>> getBanners();
}

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  final Dio dio;
  final GetStorage storage;

  BannerRemoteDataSourceImpl({required this.dio, required this.storage});

  @override
  Future<void> createBanner({
    required String title,
    required String imageUrl,
    required String link,
  }) async {
    final token = storage.read('token');
    try {
      await dio.post(
        '${ApiEndpoints.baseUrl}/banners',
        data: {
          'title': title,
          'imageUrl': imageUrl,
          'link': link,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
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
