import '../entities/scheme.dart';

abstract class AdminSchemeAddUpdateRepository {
  Future<List<Scheme>> getSchemes();
}
