import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/presentation/pages/jeweller_page.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/presentation/controllers/jeweller_controller.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/domain/entities/jeweller.dart';
import 'package:digital_jeweller/core/service_locator.dart';

void main() {
  setUpAll(() async {
    await setupLocator();
  });

  tearDownAll(() {
    sl.reset();
  });

  group('JewellerPage Widget Tests', () {
    testWidgets('should render SliverAppBar with title', (WidgetTester tester) async {
      // Arrange
      Get.testMode = true;
      final controller = Get.put(sl<JewellerController>());

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: JewellerPage(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.text('Jeweller List'), findsOneWidget);
    });

    testWidgets('should show loading indicator when loading', (WidgetTester tester) async {
      // Arrange
      Get.testMode = true;
      final controller = Get.put(sl<JewellerController>());
      controller.isLoadingJewellers.value = true;
      controller.jewellers.clear();

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: JewellerPage(),
        ),
      );
      await tester.pump();

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show empty state when no jewellers', (WidgetTester tester) async {
      // Arrange
      Get.testMode = true;
      final controller = Get.put(sl<JewellerController>());
      controller.isLoadingJewellers.value = false;
      controller.jewellers.clear();

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: JewellerPage(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('No Jewellers Registered Yet'), findsOneWidget);
      expect(find.byIcon(Icons.storefront_outlined), findsOneWidget);
    });

    testWidgets('should display jewellers list', (WidgetTester tester) async {
      // Arrange
      Get.testMode = true;
      final controller = Get.put(sl<JewellerController>());
      controller.isLoadingJewellers.value = false;
      controller.jewellers.value = [
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

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: JewellerPage(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Test Jeweller 1'), findsOneWidget);
      expect(find.text('Test Jeweller 2'), findsOneWidget);
    });

    testWidgets('should have add button in app bar', (WidgetTester tester) async {
      // Arrange
      Get.testMode = true;
      final controller = Get.put(sl<JewellerController>());

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: JewellerPage(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should support pull to refresh', (WidgetTester tester) async {
      // Arrange
      Get.testMode = true;
      final controller = Get.put(sl<JewellerController>());

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: JewellerPage(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(RefreshIndicator), findsOneWidget);
    });
  });
}
