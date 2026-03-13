import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/master_admin/domain/repositories/master_admin_repository.dart';

import 'package:digital_jeweller/features/master_admin/jeweller/domain/entities/jeweller.dart';

class MasterAdminJewellerUsecase {
  MasterAdminJewellerUsecase();

  Future<List<Jeweller>> getJewellers() async {
    return await sl<MasterAdminRepository>().getJewellers();
  }

  Future<Jeweller> createJeweller(Jeweller jeweller) async {
    return await sl<MasterAdminRepository>().createJeweller(jeweller);
  }

  Future deleteJeweller(String id) async {
    return await sl<MasterAdminRepository>().deleteJeweller(id);
  }

  Future<Jeweller> toggleJewellerStatus({id, isActive}) {
    return sl<MasterAdminRepository>().toggleJewellerStatus(id, isActive);
  }
}
