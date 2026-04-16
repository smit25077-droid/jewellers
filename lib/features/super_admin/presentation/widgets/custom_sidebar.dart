import 'package:flutter/material.dart';

class CustomSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'Super Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _buildNavItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            index: 0,
          ),
          _buildNavItem(
            icon: Icons.store,
            title: 'Jewellers',
            index: 1,
          ),
          _buildNavItem(
            icon: Icons.people,
            title: 'Users',
            index: 2,
          ),
          _buildNavItem(
            icon: Icons.settings,
            title: 'Settings',
            index: 3,
          ),
          const Spacer(),
          const Divider(),
          _buildNavItem(
            icon: Icons.logout,
            title: 'Logout',
            index: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final isSelected = selectedIndex == index;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Colors.blue : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: () => onItemSelected(index),
      selectedTileColor: Colors.blue.withValues(alpha: 0.1),
    );
  }
}
