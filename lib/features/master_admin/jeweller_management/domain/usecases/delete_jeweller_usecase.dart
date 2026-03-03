import '../repositories/jeweller_repository.dart';

class DeleteJewellerUseCase {
  final JewellerRepository repository;

  DeleteJewellerUseCase({required this.repository});

  Future<String> execute(String id) async {
    if (id.isEmpty) {
      throw Exception('Jeweller ID cannot be empty');
    }
    
    return await repository.deleteJeweller(id);
  }
}
