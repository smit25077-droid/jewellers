import '../entities/jeweller.dart';
import '../repositories/jeweller_repository.dart';

class ToggleJewellerStatusUseCase {
  final JewellerRepository repository;

  ToggleJewellerStatusUseCase({required this.repository});

  Future<Jeweller> execute(String id, bool isActive) async {
    if (id.isEmpty) {
      throw Exception('Jeweller ID cannot be empty');
    }
    
    return await repository.toggleJewellerStatus(id, isActive);
  }
}
