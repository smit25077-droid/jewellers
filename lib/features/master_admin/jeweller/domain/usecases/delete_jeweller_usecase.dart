import '../../domain/repositories/jeweller_repository.dart';

class DeleteJewellerUseCase {
  final JewellerRepository repository;

  DeleteJewellerUseCase({required this.repository});

  Future<String> call(String id) async {
    return await repository.deleteJeweller(id);
  }
}
