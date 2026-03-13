import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digital_jeweller/core/theme/app_colors.dart';
import '../controllers/jeweller_controller.dart';
import '../widgets/jeweller_card.dart';
import 'add_jeweller_page.dart';

class JewellerPage extends GetWidget<JewellerController> {
  const JewellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => controller.loadJewellers(),
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
            actions: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () => Get.to(() => const AddJewellerPage()),
              ),
            ],
          ),
          Obx(() {
            if (controller.isLoadingJewellers.value &&
                controller.jewellers.isEmpty) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (controller.jewellers.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.storefront_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No Jewellers Registered Yet',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
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
