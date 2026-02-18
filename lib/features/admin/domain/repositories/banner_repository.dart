
import 'package:dartz/dartz.dart';
import 'package:digital_jeweller/core/error/failures.dart';
import 'package:digital_jeweller/features/admin/domain/entities/banner.dart';

abstract class BannerRepository {
  Future<Either<Failure, void>> createBanner({
    required String title,
    required String imageUrl,
    required String link,
  });

  Future<Either<Failure, List<Banner>>> getBanners();
}
