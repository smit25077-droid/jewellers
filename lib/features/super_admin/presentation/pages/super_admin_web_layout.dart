import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digital_jeweller/features/master_admin/presentation/pages/dashboard/master_admin_dashboard_page.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/presentation/pages/jeweller_page.dart';
import 'package:digital_jeweller/features/master_admin/presentation/pages/subscription/subscription_plans_page.dart';
import 'package:digital_jeweller/features/super_admin/presentation/widgets/custom_sidebar.dart';
import 'package:digital_jeweller/features/super_admin/presentation/controllers/super_admin_dashboard_controller.dart';

class SuperAdminWebLayout extends GetView<SuperAdminDashboardController> {
  const SuperAdminWebLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 900;

        return Scaffold(
          appBar: !isDesktop
              ? AppBar(
                  title: const Text('Super Admin Dashboard'),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {},
                    ),
                  ],
                )
              : null, // Desktop uses sidebar only or custom top bar area
          drawer: !isDesktop
              ? Obx(
                  () => CustomSidebar(
                    selectedIndex: controller.selectedIndex.value,
                    onItemSelected: (index) {
                      controller.changeTab(index);
                      Navigator.pop(context); // Close drawer
                    },
                  ),
                )
              : null,
          body: Row(
            children: [
              if (isDesktop)
                SizedBox(
                  width: 250,
                  child: Obx(
                    () => CustomSidebar(
                      selectedIndex: controller.selectedIndex.value,
                      onItemSelected: controller.changeTab,
                    ),
                  ),
                ),
              if (isTablet)
                SizedBox(
                  width: 80, // Collapsed sidebar for tablet
                  child: NavigationRail(
                    selectedIndex: controller.selectedIndex.value,
                    onDestinationSelected: controller.changeTab,
                    labelType: NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.dashboard),
                        label: Text('Dashboard'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.store),
                        label: Text('Jewellers'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.people),
                        label: Text('Users'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.settings),
                        label: Text('Settings'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.logout),
                        label: Text('Logout'),
                      ),
                    ],
                  ),
                ),
              if (isDesktop || isTablet)
                const VerticalDivider(thickness: 1, width: 1),
              
              // Main Content Area
              Expanded(
                child: Column(
                  children: [
                    if (isDesktop)
                      _buildDesktopHeader(),
                    Expanded(
                      child: Obx(() => _buildContent(controller.selectedIndex.value)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopHeader() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Text(
            _getTitle(controller.selectedIndex.value),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Overview Dashboard';
      case 1:
        return 'Jewellers Management';
      case 2:
        return 'User Administration';
      case 3:
        return 'System Settings';
      default:
        return 'Super Admin';
    }
  }

  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return const MasterAdminDashboardPage();
      case 1:
        return const JewellerPage();
      case 2:
        return const SubscriptionPlansPage();
      case 3:
        return const Center(child: Text('Settings Placeholder', style: TextStyle(fontSize: 24)));
      default:
        return const Center(child: Text('Content Placeholder', style: TextStyle(fontSize: 24)));
    }
  }
}
