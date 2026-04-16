import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digital_jeweller/core/theme/app_colors.dart';
import 'package:digital_jeweller/core/constants/api_endpoints.dart';
import '../../domain/entities/jeweller.dart';
import '../controllers/jeweller_controller.dart';
import '../pages/add_jeweller_page.dart';
import '../pages/jeweller_details_page.dart';

class JewellerCard extends StatelessWidget {
  final Jeweller jeweller;
  final int index;

  const JewellerCard({super.key, required this.jeweller, required this.index});

  Widget _buildInitialAvatar() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gold, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          jeweller.name.isNotEmpty
              ? jeweller.name.substring(0, 1).toUpperCase()
              : 'J',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Get.isDarkMode ? AppColors.surfaceDark : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: Get.isDarkMode ? 0.2 : 0.04,
              ),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () async {
              // Navigate to details and refresh list when returning
              await Get.to(() => JewellerDetailsPage(jeweller: jeweller));
              // Refresh list after returning from details
              final controller = Get.find<JewellerController>();
              controller.loadJewellers();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Logo or Initial
                  jeweller.logo != null && jeweller.logo!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          ApiEndpoints.getImageUrl(jeweller.logo),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildInitialAvatar();
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : _buildInitialAvatar(),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jeweller.name,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${jeweller.jewellerCode} • ${jeweller.phone}',
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Actions (Edit/Delete)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: Colors.blue, size: 20),
                        onPressed: () {
                          final controller = Get.find<JewellerController>();
                          controller.loadJewellerForEdit(jeweller);
                          Get.to(() => const AddJewellerPage());
                        },
                        tooltip: 'Edit Jeweller',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 20),
                        onPressed: () => _showDeleteDialog(context),
                        tooltip: 'Delete Jeweller',
                      ),
                      const SizedBox(width: 8),
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: (jeweller.isActive ?? false)
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          (jeweller.isActive ?? false) ? 'Active' : 'Inactive',
                          style: TextStyle(
                            color: (jeweller.isActive ?? false) ? Colors.green : Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                'Delete Jeweller',
                style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Are you sure you want to remove this jeweller?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.find<JewellerController>().deleteJeweller(jeweller.id, popDetails: false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
