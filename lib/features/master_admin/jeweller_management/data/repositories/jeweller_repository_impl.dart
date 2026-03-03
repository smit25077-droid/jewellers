import '../../domain/entities/jeweller.dart';
import '../../domain/repositories/jeweller_repository.dart';
import '../services/jeweller_service.dart';

class JewellerRepositoryImpl implements JewellerRepository {
  final JewellerService service;

  JewellerRepositoryImpl({required this.service});

  @override
  Future<List<Jeweller>> getJewellers() async {
    try {
      return await service.getJewellers();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Jeweller> createJeweller(Jeweller jeweller) async {
    try {
      return await service.createJeweller(jeweller);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteJeweller(String id) async {
    try {
      return await service.deleteJeweller(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Jeweller> toggleJewellerStatus(String id, bool isActive) async {
    try {
      return await service.toggleJewellerStatus(id, isActive);
    } catch (e) {
      rethrow;
    }
  }
}
