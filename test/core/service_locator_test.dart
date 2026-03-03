import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:digital_jeweller/core/service_locator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('Service Locator - Registration Check', () {
    test('Service locator setup should complete without errors', () async {
      // This test verifies that setupLocator() can be called
      // In a real app, GetStorage.init() would be called in main()
      expect(() => setupLocator(), returnsNormally);
    });
  });
}
