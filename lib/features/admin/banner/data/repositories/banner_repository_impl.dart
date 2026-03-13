import 'package:dartz/dartz.dart';
import 'package:digital_jeweller/core/error/exceptions.dart';
import 'package:digital_jeweller/core/error/failures.dart';
import '../services/banner_service.dart';
import '../../domain/entities/banner.dart';
import '../../domain/repositories/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerService service;

  BannerRepositoryImpl({required this.service});

  @override
  Future<Either<Failure, void>> createBanner({
    required String title,
    required String imageUrl,
    required String link,
  }) async {
    try {
      await service.createBanner(title: title, imageUrl: imageUrl, link: link);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Banner>>> getBanners() async {
    try {
      final banners = await service.getBanners();
      return Right(banners);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
