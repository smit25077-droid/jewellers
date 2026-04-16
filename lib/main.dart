import 'package:digital_jeweller/core/bindings/initial_binding.dart';
import 'package:digital_jeweller/core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_pages.dart';
import 'core/constants/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Initialize Dependencies
  await setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GetStorage _storage = GetStorage();

  String _getInitialRoute() {
    final token = _storage.read('token');
    final role = _storage.read('role');

    if (token == null) {
      return AppRoutes.login;
    }

    switch (role) {
      case 'jewellers_admin':
        return AppRoutes.jewellerHome;
      case 'super_admin':
        return AppRoutes.superAdminWebDashboard;
      case 'customer':
        return AppRoutes.userHomeScreen;
      default:
        return AppRoutes.login;
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialRoute = _getInitialRoute();
    debugPrint('token == ${_storage.read('token')}');
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        title: 'Digital Jeweller',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBinding(),
        initialRoute: initialRoute,
        getPages: AppPages.routes,
      ),
    );
  }
}
