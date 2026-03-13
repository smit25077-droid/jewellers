import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/usecases/create_jeweller_usecase.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/repositories/jeweller_repository.dart';
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/entities/jeweller.dart';

@GenerateMocks([JewellerRepository])
import 'create_jeweller_usecase_test.mocks.dart';

void main() {
  late CreateJewellerUseCase useCase;
  late MockJewellerRepository mockRepository;

  setUp(() {
    mockRepository = MockJewellerRepository();
    useCase = CreateJewellerUseCase(repository: mockRepository);
  });

  group('CreateJewellerUseCase', () {
    final testJeweller = Jeweller(
      id: '1',
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

    test('should create jeweller successfully', () async {
      // Arrange
      when(mockRepository.createJeweller(any)).thenAnswer((_) async => testJeweller);

      // Act
      final result = await useCase.execute(testJeweller);

      // Assert
      expect(result, testJeweller);
      verify(mockRepository.createJeweller(testJeweller)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw exception when name is empty', () async {
      // Arrange
      final invalidJeweller = Jeweller(
        id: '1',
        name: '',
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

      // Act & Assert
      expect(
        () => useCase.execute(invalidJeweller),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Jeweller name cannot be empty'),
        )),
      );
      verifyNever(mockRepository.createJeweller(any));
    });

    test('should throw exception when email is empty', () async {
      // Arrange
      final invalidJeweller = Jeweller(
        id: '1',
        name: 'Test Jeweller',
        address: '123 Main St',
        phone: '1234567890',
        email: '',
        jewellerCode: 'JC001',
        password: 'pass123',
        panNumber: 'ABCDE1234F',
        aadhaarNumber: '123456789012',
        gstNumber: '22AAAAA0000A1Z5',
        isActive: true,
      );

      // Act & Assert
      expect(
        () => useCase.execute(invalidJeweller),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Email cannot be empty'),
        )),
      );
      verifyNever(mockRepository.createJeweller(any));
    });

    test('should throw exception when phone is empty', () async {
      // Arrange
      final invalidJeweller = Jeweller(
        id: '1',
        name: 'Test Jeweller',
        address: '123 Main St',
        phone: '',
        email: 'test@example.com',
        jewellerCode: 'JC001',
        password: 'pass123',
        panNumber: 'ABCDE1234F',
        aadhaarNumber: '123456789012',
        gstNumber: '22AAAAA0000A1Z5',
        isActive: true,
      );

      // Act & Assert
      expect(
        () => useCase.execute(invalidJeweller),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Phone cannot be empty'),
        )),
      );
      verifyNever(mockRepository.createJeweller(any));
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(mockRepository.createJeweller(any)).thenThrow(Exception('Failed to create jeweller'));

      // Act & Assert
      expect(() => useCase.execute(testJeweller), throwsException);
      verify(mockRepository.createJeweller(testJeweller)).called(1);
    });
  });
}
