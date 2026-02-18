
import 'package:dartz/dartz.dart';
import 'package:digital_jeweller/core/error/exceptions.dart';
import 'package:digital_jeweller/core/error/failures.dart';
import 'package:digital_jeweller/features/admin/data/data_sources/banner_remote_data_source.dart';
import 'package:digital_jeweller/features/admin/domain/entities/banner.dart';
import 'package:digital_jeweller/features/admin/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource remoteDataSource;

  BannerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> createBanner({
    required String title,
    required String imageUrl,
    required String link,
  }) async {
    try {
      await remoteDataSource.createBanner(
        title: title,
        imageUrl: imageUrl,
        link: link,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Banner>>> getBanners() async {
    try {
      final banners = await remoteDataSource.getBanners();
      return Right(banners);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
