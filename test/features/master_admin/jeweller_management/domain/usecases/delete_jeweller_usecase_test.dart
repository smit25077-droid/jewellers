import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/usecases/delete_jeweller_usecase.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/repositories/jeweller_repository.dart';

@GenerateMocks([JewellerRepository])
import 'delete_jeweller_usecase_test.mocks.dart';

void main() {
  late DeleteJewellerUseCase useCase;
  late MockJewellerRepository mockRepository;

  setUp(() {
    mockRepository = MockJewellerRepository();
    useCase = DeleteJewellerUseCase(repository: mockRepository);
  });

  group('DeleteJewellerUseCase', () {
    const testId = '123';
    const successMessage = 'Jeweller deleted successfully';

    test('should delete jeweller successfully', () async {
      // Arrange
      when(mockRepository.deleteJeweller(testId)).thenAnswer((_) async => successMessage);

      // Act
      final result = await useCase.execute(testId);

      // Assert
      expect(result, successMessage);
      verify(mockRepository.deleteJeweller(testId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw exception when ID is empty', () async {
      // Act & Assert
      expect(
        () => useCase.execute(''),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Jeweller ID cannot be empty'),
        )),
      );
      verifyNever(mockRepository.deleteJeweller(any));
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(mockRepository.deleteJeweller(testId)).thenThrow(Exception('Failed to delete jeweller'));

      // Act & Assert
      expect(() => useCase.execute(testId), throwsException);
      verify(mockRepository.deleteJeweller(testId)).called(1);
    });

    test('should handle 404 not found error', () async {
      // Arrange
      when(mockRepository.deleteJeweller(testId)).thenThrow(Exception('Jeweller not found'));

      // Act & Assert
      expect(
        () => useCase.execute(testId),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Jeweller not found'),
        )),
      );
      verify(mockRepository.deleteJeweller(testId)).called(1);
    });
  });
}
