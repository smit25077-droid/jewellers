import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/routes/app_pages.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/classic_card.dart';

class JewellerHomePage extends StatefulWidget {
  const JewellerHomePage({super.key});

  @override
  State<JewellerHomePage> createState() => _JewellerHomePageState();
}

class _JewellerHomePageState extends State<JewellerHomePage> {
  int _selectedIndex = 0;

  /// Maps each tab index to its corresponding named route.
  final List<String> _routes = [
    AppRoutes.adminDashboard,
    AppRoutes.adminUserList,
    AppRoutes.adminListScheme,
    AppRoutes.profile,
  ];

  void _onTabChanged(int index) {
    if (index == _selectedIndex) return; // avoid re-navigating to the same tab

    setState(() {
      _selectedIndex = index;
    });

    // Navigate using Get.offNamed with nested navigator (id: 1)
    // offNamed replaces the current page so we don't stack pages
    Get.offNamed(_routes[index], id: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: AppRoutes.adminDashboard,
        onGenerateRoute: (settings) {
          // Find the matching GetPage from AppPages
          final page = GetPages.findPage(settings.name);
          if (page != null) {
            return GetPageRoute(
              settings: settings,
              page: page.page,
              binding: page.binding,
              bindings: page.bindings,
              transition: Transition.fade,
              transitionDuration: const Duration(milliseconds: 200),
            );
          }
          return null;
        },
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDark ? 3 : 1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabChanged,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: ClassicTheme.getTextSecondary(context),
        selectedLabelStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: GoogleFonts.outfit(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people_rounded),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt_rounded),
            label: 'Schemes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/// Helper to find GetPage from registered routes.
class GetPages {
  static GetPage? findPage(String? name) {
    if (name == null) return null;
    try {
      return AppPages.routes.firstWhere((page) => page.name == name);
    } catch (_) {
      return null;
    }
  }
}
