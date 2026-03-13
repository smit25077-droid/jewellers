import '../../domain/entities/jeweller.dart';
import '../../domain/repositories/jeweller_repository.dart';

class GetJewellersUseCase {
  final JewellerRepository repository;

  GetJewellersUseCase({required this.repository});

  Future<List<Jeweller>> call() async {
    return await repository.getJewellers();
  }
}
