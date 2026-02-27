import 'package:digital_jeweller/core/theme/app_colors.dart';
import 'package:digital_jeweller/core/widgets/common_cards.dart';
import 'package:digital_jeweller/features/master_admin/presentation/controllers/master_admin_controller.dart';
import 'package:digital_jeweller/features/master_admin/presentation/widgets/recent_activity_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MasterAdminDashboardPage extends GetWidget<MasterAdminController> {
  const MasterAdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Summary',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        title: 'Total Jewellers',
                        value: controller.jewellers.length.toString(),
                        icon: Icons.store_rounded,
                        color: AppColors.gold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        title: 'Active Plans',
                        value: '12',
                        icon: Icons.card_membership_rounded,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        title: 'New Requests',
                        value: '5',
                        icon: Icons.notifications_active_rounded,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        title: 'Revenue',
                        value: '₹45k',
                        icon: Icons.payments_rounded,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'Recent Activities',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                RecentActivityItem(
                  title: 'New Jeweller Added',
                  subtitle: 'SK Jewelry Store registered 2 hours ago',
                  icon: Icons.add_business_rounded,
                  time: '2h ago',
                ),
                RecentActivityItem(
                  title: 'Plan Updated',
                  subtitle: 'Premium Plan price updated',
                  icon: Icons.edit_note_rounded,
                  time: '5h ago',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'Master Admin',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primaryDark,
                const Color(0xFF004D40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
