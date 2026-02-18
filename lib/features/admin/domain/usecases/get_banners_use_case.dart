
import 'package:dartz/dartz.dart';
import 'package:digital_jeweller/core/error/failures.dart';
import 'package:digital_jeweller/features/admin/domain/entities/banner.dart';
import 'package:digital_jeweller/features/admin/domain/repositories/banner_repository.dart';

class GetBannersUseCase {
  final BannerRepository repository;

  GetBannersUseCase(this.repository);

  Future<Either<Failure, List<Banner>>> call() async {
    return await repository.getBanners();
  }
}
