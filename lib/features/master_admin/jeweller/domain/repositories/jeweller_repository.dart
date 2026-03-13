import '../entities/jeweller.dart';

abstract class JewellerRepository {
  Future<List<Jeweller>> getJewellers();
  Future<Jeweller> createJeweller(Jeweller jeweller);
  Future<String> deleteJeweller(String id);
  Future<Jeweller> toggleJewellerStatus(String id, bool isActive);
  Future<Jeweller> updateJeweller(Jeweller jeweller);
}
