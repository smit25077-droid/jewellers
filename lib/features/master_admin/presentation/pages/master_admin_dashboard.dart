import 'package:digital_jeweller/core/service_locator.dart';
import 'package:digital_jeweller/features/master_admin/domain/repositories/master_admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/master_admin_controller.dart';
import 'add_jeweller_page.dart';
import 'subscription_plans_page.dart';
import 'master_admin_profile_page.dart';
import 'dashboard_home_view.dart';
import 'jeweller_list_view.dart';

class MasterAdminDashboard extends StatefulWidget {
  const MasterAdminDashboard({super.key});

  @override
  State<MasterAdminDashboard> createState() => _MasterAdminDashboardState();
}

class _MasterAdminDashboardState extends State<MasterAdminDashboard> {
  int _selectedIndex = 0;
  final controller = Get.put(
    MasterAdminController(adminRepo: sl.get<MasterAdminRepository>()),
  );

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const DashboardHomeView(),
      const JewellerListView(),
      const SubscriptionPlansPage(),
      const MasterAdminProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _selectedIndex == 1 ? _buildFAB() : null,
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
            color: AppColors.gold.withValues(alpha: 0.4),
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

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Get.isDarkMode ? AppColors.surfaceDark : Colors.white,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: GoogleFonts.outfit(fontSize: 12),
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
      ),
    );
  }
}
