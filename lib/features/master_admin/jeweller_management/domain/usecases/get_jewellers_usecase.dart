import '../entities/jeweller.dart';
import '../repositories/jeweller_repository.dart';

class GetJewellersUseCase {
  final JewellerRepository repository;

  GetJewellersUseCase({required this.repository});

  Future<List<Jeweller>> execute() async {
    return await repository.getJewellers();
  }
}
