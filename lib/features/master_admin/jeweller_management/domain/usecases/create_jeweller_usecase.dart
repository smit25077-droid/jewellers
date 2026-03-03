import '../entities/jeweller.dart';
import '../repositories/jeweller_repository.dart';

class CreateJewellerUseCase {
  final JewellerRepository repository;

  CreateJewellerUseCase({required this.repository});

  Future<Jeweller> execute(Jeweller jeweller) async {
    // Add validation logic here if needed
    if (jeweller.name.isEmpty) {
      throw Exception('Jeweller name cannot be empty');
    }
    if (jeweller.email.isEmpty) {
      throw Exception('Email cannot be empty');
    }
    if (jeweller.phone.isEmpty) {
      throw Exception('Phone cannot be empty');
    }
    
    return await repository.createJeweller(jeweller);
  }
}
