import 'package:dartz/dartz.dart';
import 'package:digital_jeweller/core/error/failures.dart';
import 'package:digital_jeweller/core/service_locator.dart';
import '../entities/banner.dart';
import '../repositories/banner_repository.dart';

class GetBannersUseCase {
  final repository = sl<BannerRepository>();

  Future<Either<Failure, List<Banner>>> call() async {
    return await repository.getBanners();
  }
}
