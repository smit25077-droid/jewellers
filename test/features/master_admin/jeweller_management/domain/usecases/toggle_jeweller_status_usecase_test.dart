import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/usecases/toggle_jeweller_status_usecase.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/repositories/jeweller_repository.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/entities/jeweller.dart';

@GenerateMocks([JewellerRepository])
import 'toggle_jeweller_status_usecase_test.mocks.dart';

void main() {
  late ToggleJewellerStatusUseCase useCase;
  late MockJewellerRepository mockRepository;

  setUp(() {
    mockRepository = MockJewellerRepository();
    useCase = ToggleJewellerStatusUseCase(repository: mockRepository);
  });

  group('ToggleJewellerStatusUseCase', () {
    const testId = '123';
    final activeJeweller = Jeweller(
      id: testId,
      name: 'Test Jeweller',
      address: '123 Main St',
      phone: '1234567890',
      email: 'test@example.com',
      jewellerCode: 'JC001',
      password: 'pass123',
      panNumber: 'ABCDE1234F',
      aadhaarNumber: '123456789012',
      gstNumber: '22AAAAA0000A1Z5',
      isActive: true,
    );

    final inactiveJeweller = activeJeweller.copyWith(isActive: false);

    test('should activate jeweller successfully', () async {
      // Arrange
      when(mockRepository.toggleJewellerStatus(testId, true))
          .thenAnswer((_) async => activeJeweller);

      // Act
      final result = await useCase.execute(testId, true);

      // Assert
      expect(result, activeJeweller);
      expect(result.isActive, true);
      verify(mockRepository.toggleJewellerStatus(testId, true)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should deactivate jeweller successfully', () async {
      // Arrange
      when(mockRepository.toggleJewellerStatus(testId, false))
          .thenAnswer((_) async => inactiveJeweller);

      // Act
      final result = await useCase.execute(testId, false);

      // Assert
      expect(result, inactiveJeweller);
      expect(result.isActive, false);
      verify(mockRepository.toggleJewellerStatus(testId, false)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw exception when ID is empty', () async {
      // Act & Assert
      expect(
        () => useCase.execute('', true),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Jeweller ID cannot be empty'),
        )),
      );
      verifyNever(mockRepository.toggleJewellerStatus(any, any));
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(mockRepository.toggleJewellerStatus(testId, true))
          .thenThrow(Exception('Failed to update status'));

      // Act & Assert
      expect(() => useCase.execute(testId, true), throwsException);
      verify(mockRepository.toggleJewellerStatus(testId, true)).called(1);
    });

    test('should handle 404 not found error', () async {
      // Arrange
      when(mockRepository.toggleJewellerStatus(testId, true))
          .thenThrow(Exception('Jeweller not found'));

      // Act & Assert
      expect(
        () => useCase.execute(testId, true),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Jeweller not found'),
        )),
      );
      verify(mockRepository.toggleJewellerStatus(testId, true)).called(1);
    });
  });
}
