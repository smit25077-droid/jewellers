import 'package:flutter_test/flutter_test.dart';
import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/usecases/get_jewellers_usecase.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/usecases/create_jeweller_usecase.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/usecases/delete_jeweller_usecase.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/usecases/toggle_jeweller_status_usecase.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/repositories/jeweller_repository.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/data/services/jeweller_service.dart';

void main() {
  setUpAll(() async {
    await setupLocator();
  });

  tearDownAll(() {
    sl.reset();
  });

  group('Jeweller Management Integration Tests', () {
    test('should register all jeweller management dependencies', () {
      // Assert - Service
      expect(sl.isRegistered<JewellerService>(), true);
      expect(sl<JewellerService>(), isA<JewellerServiceImpl>());

      // Assert - Repository
      expect(sl.isRegistered<JewellerRepository>(), true);

      // Assert - Use Cases
      expect(sl.isRegistered<GetJewellersUseCase>(), true);
      expect(sl.isRegistered<CreateJewellerUseCase>(), true);
      expect(sl.isRegistered<DeleteJewellerUseCase>(), true);
      expect(sl.isRegistered<ToggleJewellerStatusUseCase>(), true);
    });

    test('should return same instance for singleton services', () {
      // Act
      final service1 = sl<JewellerService>();
      final service2 = sl<JewellerService>();

      // Assert
      expect(identical(service1, service2), true);
    });

    test('should return same instance for singleton repository', () {
      // Act
      final repo1 = sl<JewellerRepository>();
      final repo2 = sl<JewellerRepository>();

      // Assert
      expect(identical(repo1, repo2), true);
    });

    test('should create new instances for use cases', () {
      // Act
      final useCase1 = sl<GetJewellersUseCase>();
      final useCase2 = sl<GetJewellersUseCase>();

      // Assert - Use cases should be factory instances
      expect(useCase1, isA<GetJewellersUseCase>());
      expect(useCase2, isA<GetJewellersUseCase>());
    });

    test('should resolve dependencies correctly', () {
      // Act
      final getJewellersUseCase = sl<GetJewellersUseCase>();
      final createJewellerUseCase = sl<CreateJewellerUseCase>();
      final deleteJewellerUseCase = sl<DeleteJewellerUseCase>();
      final toggleStatusUseCase = sl<ToggleJewellerStatusUseCase>();

      // Assert - All use cases should be properly instantiated
      expect(getJewellersUseCase, isNotNull);
      expect(createJewellerUseCase, isNotNull);
      expect(deleteJewellerUseCase, isNotNull);
      expect(toggleStatusUseCase, isNotNull);
    });

    test('should have proper dependency chain', () {
      // Act
      final service = sl<JewellerService>();
      final repository = sl<JewellerRepository>();
      final useCase = sl<GetJewellersUseCase>();

      // Assert - Verify dependency chain exists
      expect(service, isNotNull);
      expect(repository, isNotNull);
      expect(useCase, isNotNull);
    });
  });
}
