import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/master_admin_controller.dart';
import '../widgets/jeweller_card.dart';

class JewellerListView extends StatelessWidget {
  const JewellerListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MasterAdminController>();
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        controller.loadJewellers();
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Jeweller List',
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            pinned: true,
            backgroundColor: AppColors.primary,
          ),
          Obx(() {
            if (controller.jewellers.isEmpty) {
              return const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.storefront_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No Jewellers Registered Yet',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final jeweller = controller.jewellers[index];
                  return JewellerCard(jeweller: jeweller, index: index);
                }, childCount: controller.jewellers.length),
              ),
            );
          }),
        ],
      ),
    );
  }
}
