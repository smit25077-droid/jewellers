import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:digital_jeweller/features/master_admin/presentation/pages/master_admin_home_page.dart';
import 'package:digital_jeweller/features/master_admin/presentation/controllers/master_admin_controller.dart';
import 'package:digital_jeweller/core/service_locator.dart';

void main() {
  setUpAll(() async {
    await setupLocator();
  });

  tearDownAll(() {
    sl.reset();
  });

  group('MasterAdminHomePage Widget Tests', () {
    testWidgets('should render Scaffold with BottomNavigationBar', (WidgetTester tester) async {
      // Arrange
      Get.testMode = true;
      final controller = Get.put(MasterAdminController());

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: MasterAdminHomePage(key: Key('master_admin_home')),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('BottomNavigationBar should have 4 items', (WidgetTester tester) async {
      // Arrange
      Get.testMode = true;
      final controller = Get.put(MasterAdminController());

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: MasterAdminHomePage(key: Key('master_admin_home')),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      final bottomNav = tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNav.items.length, 4);
      expect(bottomNav.items[0].label, 'Dashboard');
      expect(bottomNav.items[1].label, 'Jewellers');
      expect(bottomNav.items[2].label, 'Plans');
      expect(bottomNav.items[3].label, 'Profile');
    });

    testWidgets('should change page when bottom nav item is tapped', (WidgetTester tester) async {
      // Arrange
      Get.testMode = true;
      final controller = Get.put(MasterAdminController());

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: MasterAdminHomePage(key: Key('master_admin_home')),
        ),
      );
      await tester.pumpAndSettle();

      // Initial state - Dashboard selected
      expect(controller.selectedIndex.value, 0);

      // Tap on Jewellers tab
      await tester.tap(find.text('Jewellers'));
      await tester.pumpAndSettle();

      // Assert
      expect(controller.selectedIndex.value, 1);
    });

    testWidgets('should show FAB only on Jewellers tab', (WidgetTester tester) async {
      // Arrange
      Get.testMode = true;
      final controller = Get.put(MasterAdminController());

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: MasterAdminHomePage(key: Key('master_admin_home')),
        ),
      );
      await tester.pumpAndSettle();

      // Dashboard tab - no FAB
      expect(find.byType(FloatingActionButton), findsNothing);

      // Switch to Jewellers tab
      controller.changePage(1);
      await tester.pumpAndSettle();

      // Assert - FAB should be visible
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('should navigate through all tabs', (WidgetTester tester) async {
      // Arrange
      Get.testMode = true;
      final controller = Get.put(MasterAdminController());

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: MasterAdminHomePage(key: Key('master_admin_home')),
        ),
      );
      await tester.pumpAndSettle();

      // Test all tabs
      for (int i = 0; i < 4; i++) {
        await tester.tap(find.byType(BottomNavigationBarItem).at(i));
        await tester.pumpAndSettle();
        expect(controller.selectedIndex.value, i);
      }
    });
  });
}
