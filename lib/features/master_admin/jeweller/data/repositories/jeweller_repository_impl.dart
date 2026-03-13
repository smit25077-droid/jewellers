import 'package:digital_jeweller/core/base/base_repository.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/domain/entities/jeweller.dart';
import '../../domain/repositories/jeweller_repository.dart';
import '../services/jeweller_service.dart';

class JewellerRepositoryImpl extends BaseRepository
    implements JewellerRepository {
  final JewellerService service;

  JewellerRepositoryImpl({required this.service});

  @override
  Future<List<Jeweller>> getJewellers() async {
    return await service.getJewellers();
  }

  @override
  Future<Jeweller> createJeweller(Jeweller jeweller) async {
    return await service.createJeweller(jeweller);
  }

  @override
  Future<String> deleteJeweller(String id) async {
    return await service.deleteJeweller(id);
  }

  @override
  Future<Jeweller> toggleJewellerStatus(String id, bool isActive) async {
    return await service.toggleJewellerStatus(id, isActive);
  }

  @override
  Future<Jeweller> updateJeweller(Jeweller jeweller) async {
    return await service.updateJeweller(jeweller);
  }
}
