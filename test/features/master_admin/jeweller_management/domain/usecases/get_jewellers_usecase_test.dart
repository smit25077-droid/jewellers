import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/usecases/get_jewellers_usecase.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/repositories/jeweller_repository.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/entities/jeweller.dart';

@GenerateMocks([JewellerRepository])
import 'get_jewellers_usecase_test.mocks.dart';

void main() {
  late GetJewellersUseCase useCase;
  late MockJewellerRepository mockRepository;

  setUp(() {
    mockRepository = MockJewellerRepository();
    useCase = GetJewellersUseCase(repository: mockRepository);
  });

  group('GetJewellersUseCase', () {
    final testJewellers = [
      Jeweller(
        id: '1',
        name: 'Test Jeweller 1',
        address: '123 Main St',
        phone: '1234567890',
        email: 'test1@example.com',
        jewellerCode: 'JC001',
        password: 'pass123',
        panNumber: 'ABCDE1234F',
        aadhaarNumber: '123456789012',
        gstNumber: '22AAAAA0000A1Z5',
        isActive: true,
      ),
      Jeweller(
        id: '2',
        name: 'Test Jeweller 2',
        address: '456 Park Ave',
        phone: '0987654321',
        email: 'test2@example.com',
        jewellerCode: 'JC002',
        password: 'pass456',
        panNumber: 'FGHIJ5678K',
        aadhaarNumber: '987654321098',
        gstNumber: '07BBBBB1111B2Z6',
        isActive: false,
      ),
    ];

    test('should get jewellers from repository', () async {
      // Arrange
      when(mockRepository.getJewellers()).thenAnswer((_) async => testJewellers);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, testJewellers);
      verify(mockRepository.getJewellers()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return empty list when no jewellers', () async {
      // Arrange
      when(mockRepository.getJewellers()).thenAnswer((_) async => []);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, []);
      expect(result.length, 0);
      verify(mockRepository.getJewellers()).called(1);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(mockRepository.getJewellers()).thenThrow(Exception('Failed to fetch jewellers'));

      // Act & Assert
      expect(() => useCase.execute(), throwsException);
      verify(mockRepository.getJewellers()).called(1);
    });
  });
}
