import '../../domain/entities/jeweller.dart';
import '../../domain/repositories/jeweller_repository.dart';

class UpdateJewellerStatusUseCase {
  final JewellerRepository repository;

  UpdateJewellerStatusUseCase({required this.repository});

  Future<Jeweller> call(String id, bool isActive) async {
    return await repository.toggleJewellerStatus(id, isActive);
  }
}
