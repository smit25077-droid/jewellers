
import 'package:dartz/dartz.dart';
import 'package:digital_jeweller/core/error/failures.dart';
import 'package:digital_jeweller/features/admin/domain/repositories/banner_repository.dart';

class CreateBannerUseCase {
  final BannerRepository repository;

  CreateBannerUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String title,
    required String imageUrl,
    required String link,
  }) async {
    return await repository.createBanner(
      title: title,
      imageUrl: imageUrl,
      link: link,
    );
  }
}
