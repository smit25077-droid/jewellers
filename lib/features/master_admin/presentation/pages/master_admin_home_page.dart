import 'package:digital_jeweller/core/constants/app_routes.dart';
import 'package:digital_jeweller/core/widgets/common_profile_page.dart';
import 'package:digital_jeweller/features/admin/presentation/customer_add_update/admin_customer_list_page.dart';
import 'package:digital_jeweller/features/auth/presentation/binding/auth_biniding.dart';
import 'package:digital_jeweller/features/master_admin/presentation/binding/master_admin_binding.dart';
import 'package:digital_jeweller/features/master_admin/presentation/binding/master_admin_dashboard_binding.dart';
import 'package:digital_jeweller/features/master_admin/presentation/binding/master_admin_jeweller_binding.dart';
import 'package:digital_jeweller/features/master_admin/presentation/binding/master_admin_subscription_binding.dart';
import 'package:digital_jeweller/features/master_admin/presentation/controllers/master_admin_jeweller_controller.dart';
import 'package:digital_jeweller/features/master_admin/presentation/controllers/master_admin_subsciption_controller.dart';
import 'package:digital_jeweller/features/master_admin/presentation/pages/dashboard/master_admin_dashboard_page.dart';
import 'package:digital_jeweller/features/master_admin/presentation/pages/master_admin_jeweller/add_jeweller_page.dart';
import 'package:digital_jeweller/features/master_admin/presentation/pages/master_admin_jeweller/jeweller_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/master_admin_controller.dart';
import 'subscription/subscription_plans_page.dart';

//
// class MasterAdminHomePage extends StatefulWidget {
//   const MasterAdminHomePage({super.key});
//
//   @override
//   State<MasterAdminHomePage> createState() => _MasterAdminHomePageState();
// }
//
// class _MasterAdminHomePageState extends State<MasterAdminHomePage> {
//   int _selectedIndex = 0;
//   final controller = Get.put(MasterAdminController());
//
//   late List<Widget> _screens;
//
//   @override
//   void initState() {
//     super.initState();
//     _screens = [
//       const MasterAdminDashboardPage(),
//       const JewellerListView(),
//       const SubscriptionPlansPage(),
//       const CommonProfilePage(),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(index: _selectedIndex, children: _screens),
//       bottomNavigationBar: _buildBottomNav(),
//       floatingActionButton: _selectedIndex == 1 ? _buildFAB() : null,
//     );
//   }
//
//   Widget _buildFAB() {
//     return Container(
//       height: 64,
//       width: 64,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: LinearGradient(colors: [Colors.amber, AppColors.gold]),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.gold.withValues(alpha: 0.4),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: FloatingActionButton(
//         heroTag: 'addJewellerFAB',
//         onPressed: () => Get.toNamed(AppRoutes.masterAdminJewellerAddUpdate),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         child: const Icon(Icons.add, color: Colors.white, size: 32),
//       ),
//     );
//   }
//
//   Widget _buildBottomNav() {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.1),
//             blurRadius: 20,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) => setState(() => _selectedIndex = index),
//         elevation: 0,
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Get.isDarkMode ? AppColors.surfaceDark : Colors.white,
//         selectedItemColor: AppColors.gold,
//         unselectedItemColor: Colors.grey,
//         selectedLabelStyle: GoogleFonts.outfit(
//           fontWeight: FontWeight.bold,
//           fontSize: 12,
//         ),
//         unselectedLabelStyle: GoogleFonts.outfit(fontSize: 12),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard_rounded),
//             label: 'Dashboard',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.storefront_rounded),
//             label: 'Jewellers',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.card_membership_rounded),
//             label: 'Plans',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_rounded),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }

class MasterAdminHomePage extends GetWidget<MasterAdminController> {
  // final BottomNavController controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            Offstage(
              offstage: controller.selectedIndex.value != 0,
              child: GetNavigator(
                key: Get.nestedKey(0),
                // initialRoute: AppRoutes.masterAdminDashboard,
                pages: [
                  GetPage(
                    name: AppRoutes.masterAdminDashboard,
                    page: () => const MasterAdminDashboardPage(),
                    binding: MasterAdminDashboardBinding(),
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: controller.selectedIndex.value != 1,
              child: GetNavigator(
                key: Get.nestedKey(1),
                // initialRoute: AppRoutes.masterAdminJewellerList,
                pages: [
                  GetPage(
                    name: AppRoutes.masterAdminJewellerList,
                    page: () => const JewellerListView(),
                    binding: MasterAdminJewellerBinding(),
                    // settings: RouteSettings(name: AppRoutes.masterAdminDashboard),
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: controller.selectedIndex.value != 2,
              child: GetNavigator(
                key: Get.nestedKey(2),
                // initialRoute: AppRoutes.masterAdminJewellerList,
                pages: [
                  GetPage(
                    name: AppRoutes.masterAdminSubscriptionPlans,
                    page: () => const SubscriptionPlansPage(),
                    binding: MasterAdminSubscriptionBinding(),
                    // settings: RouteSettings(name: AppRoutes.masterAdminDashboard),
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: controller.selectedIndex.value != 3,
              child: GetNavigator(
                key: Get.nestedKey(3),
                // initialRoute: AppRoutes.masterAdminJewellerList,
                pages: [
                  GetPage(
                    name: AppRoutes.profile,
                    page: () => const CommonProfilePage(),
                    binding: AuthBinding(),
                    // settings: RouteSettings(name: AppRoutes.masterAdminDashboard),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_rounded),
              label: 'Jewellers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_membership_rounded),
              label: 'Plans',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Get.isDarkMode
              ? AppColors.surfaceDark
              : Colors.white,
          selectedItemColor: AppColors.gold,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: GoogleFonts.outfit(fontSize: 12),
        ),
      ),
      floatingActionButton: Obx(
        () => controller.selectedIndex.value == 1
            ? _buildFAB()
            : SizedBox.shrink(),
      ),
    );
  }

  Widget _buildFAB() {
    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [Colors.amber, AppColors.gold]),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withAlpha(100),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton(
        heroTag: 'addJewellerFAB',
        onPressed: () => Get.to(() => const AddJewellerPage()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }
}
