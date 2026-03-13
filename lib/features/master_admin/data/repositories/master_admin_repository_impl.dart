import 'package:digital_jeweller/features/master_admin/data/data_service/master_admin_service.dart';

import '../../jeweller/domain/entities/jeweller.dart';
import '../../domain/repositories/master_admin_repository.dart';

class MasterAdminRepositoryImpl implements MasterAdminRepository {
  final MasterAdminRemoteDataSource remoteDataSource;

  MasterAdminRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Jeweller>> getJewellers() async {
    return await remoteDataSource.getJewellers();
  }

  @override
  Future<Jeweller> createJeweller(Jeweller jeweller) async {
    return await remoteDataSource.createJeweller(jeweller);
  }

  @override
  Future deleteJeweller(String id) async {
    return await remoteDataSource.deleteJeweller(id);
  }

  @override
  Future<Jeweller> toggleJewellerStatus(String id, bool isActive) async {
    return await remoteDataSource.toggleJewellerStatus(id, isActive);
  }
}
