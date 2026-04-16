import '../entities/jeweller.dart';
import '../repositories/jeweller_repository.dart';

class UpdateJewellerDetailsUseCase {
  final JewellerRepository repository;

  UpdateJewellerDetailsUseCase({required this.repository});

  Future<Jeweller> call(Jeweller jeweller) async {
    return await repository.updateJeweller(jeweller);
  }
}
