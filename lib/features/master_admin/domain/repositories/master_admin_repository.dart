import 'package:digital_jeweller/features/master_admin/jeweller/domain/entities/jeweller.dart';

abstract class MasterAdminRepository {
  Future<List<Jeweller>> getJewellers();
  Future<Jeweller> createJeweller(Jeweller jeweller);
  Future deleteJeweller(String id);
  Future<Jeweller> toggleJewellerStatus(String id, bool isActive);
}
