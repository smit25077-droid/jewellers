import '../../domain/entities/jeweller.dart';
import '../../domain/repositories/jeweller_repository.dart';

class CreateJewellerUseCase {
  final JewellerRepository repository;

  CreateJewellerUseCase({required this.repository});

  Future<Jeweller> call(Jeweller jeweller) async {
    return await repository.createJeweller(jeweller);
  }
}
