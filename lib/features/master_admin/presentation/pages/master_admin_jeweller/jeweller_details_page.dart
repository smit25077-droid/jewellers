import 'package:digital_jeweller/features/master_admin/presentation/controllers/master_admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/domain/entities/jeweller.dart';

class JewellerDetailsPage extends StatelessWidget {
  final Jeweller jeweller;
  const JewellerDetailsPage({super.key, required this.jeweller});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MasterAdminController>();
    final isDark = Get.isDarkMode;

    // Get the current jeweller from the controller's list to ensure we have the latest data
    final currentJeweller =
        controller.jewellers.firstWhereOrNull((j) => j.id == jeweller.id) ??
        jeweller;

    return GetBuilder<MasterAdminController>(
      builder: (_) {
        // Refresh jeweller data from controller
        final updatedJeweller =
            controller.jewellers.firstWhereOrNull((j) => j.id == jeweller.id) ??
            currentJeweller;

        return Scaffold(
          backgroundColor: isDark
              ? AppColors.backgroundDark
              : AppColors.backgroundLight,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    updatedJeweller.name,
                    style: GoogleFonts.playfairDisplay(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark],
                      ),
                    ),
                    child:
                        updatedJeweller.logo != null &&
                            updatedJeweller.logo!.isNotEmpty
                        ? Image.network(
                            updatedJeweller.logo!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                                  child: Icon(
                                    Icons.storefront_rounded,
                                    size: 80,
                                    color: Colors.white.withValues(alpha: 0.5),
                                  ),
                                ),
                          )
                        : Center(
                            child: Icon(
                              Icons.storefront_rounded,
                              size: 80,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Owner Information'),
                      _buildInfoCard([
                        _buildInfoTile(
                          Icons.person,
                          'Owner Name',
                          updatedJeweller.name,
                        ),
                        _buildInfoTile(
                          Icons.phone,
                          'Phone',
                          updatedJeweller.phone,
                        ),
                        _buildInfoTile(
                          Icons.email,
                          'Email',
                          updatedJeweller.email,
                        ),
                      ]),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Shop Details'),
                      _buildInfoCard([
                        _buildInfoTile(
                          Icons.location_on,
                          'Address',
                          updatedJeweller.address,
                        ),
                        _buildInfoTile(
                          Icons.description,
                          'GST Number',
                          updatedJeweller.gstNumber,
                        ),
                      ]),
                      // const SizedBox(height: 24),
                      // _buildSectionTitle('Bank Details'),
                      // _buildInfoCard([
                      //   _buildInfoTile(
                      //     Icons.account_balance,
                      //     'Account No',
                      //     updatedJeweller.phone,
                      //   ),
                      //   _buildInfoTile(
                      //     Icons.account_balance_rounded,
                      //     'Bank Name',
                      //     updatedJeweller.bankName,
                      //   ),
                      //   _buildInfoTile(Icons.code, 'IFSC Code', updatedJeweller.ifsc),
                      //   _buildInfoTile(Icons.map, 'Branch', updatedJeweller.branch),
                      //   _buildInfoTile(Icons.payment, 'UPI ID', updatedJeweller.upiId),
                      // ]),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Legal Documents'),
                      _buildInfoCard([
                        _buildInfoTile(
                          Icons.credit_card,
                          'PAN Card',
                          updatedJeweller.panNumber,
                        ),
                        _buildInfoTile(
                          Icons.badge,
                          'Aadhar Card',
                          updatedJeweller.aadhaarNumber,
                        ),
                      ]),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Actions'),
                      _buildInfoCard([
                        ListTile(
                          // leading: Icon(
                          //   updatedJeweller.isActive == true
                          //     ? Icons.toggle_on
                          //     : Icons.toggle_off,
                          //   color: updatedJeweller.isActive == true
                          //     ? Colors.green
                          //     : Colors.grey,
                          //   size: 28,
                          // ),
                          title: Text(
                            'Status',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          subtitle: Text(
                            updatedJeweller.isActive == true
                                ? 'Active'
                                : 'Inactive',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: updatedJeweller.isActive == true
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                          trailing: Switch(
                            value: updatedJeweller.isActive ?? false,
                            onChanged: (value) {
                              controller.toggleJewellerStatus(
                                updatedJeweller.id,
                                updatedJeweller.isActive ?? false,
                              );
                            },
                            activeThumbColor: Colors.green,
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.redAccent,
                            size: 24,
                          ),
                          title: const Text(
                            'Delete Jeweller',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () =>
                              _showDeleteDialog(context, updatedJeweller.id),
                        ),
                      ]),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String id) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Delete Jeweller',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
                        Get.find<MasterAdminController>().deleteJeweller(id);
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.gold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: AppColors.gold, size: 20),
      title: Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
      subtitle: Text(
        value,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
