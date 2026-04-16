import 'package:flutter/material.dart';

class SuperAdminDashboardPage extends StatelessWidget {
  const SuperAdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome, Super Admin',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Total Jewellers', '1,245', Icons.store),
              const SizedBox(width: 16),
              _buildStatCard('Active Users', '45,210', Icons.people),
              const SizedBox(width: 16),
              _buildStatCard('System Revenue', '\$1.2M', Icons.monetization_on),
            ],
          ),
          const SizedBox(height: 32),
          const Expanded(
            child: Center(
              child: Text(
                'Charts and overview metrics will be displayed here',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Icon(icon, color: Colors.blue, size: 24),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
