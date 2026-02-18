import 'package:digital_jeweller/core/constants/app_design_constants.dart';
import 'package:digital_jeweller/core/widgets/classic_card.dart';
import 'package:digital_jeweller/core/widgets/common_text_fields.dart';
import 'package:digital_jeweller/core/theme/app_colors.dart';
import 'package:digital_jeweller/features/admin/presentation/schemes/controller/admin_scheme_add_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminSchemeAddUpdatePage
    extends GetWidget<AdminSchemeAddUpdateController> {
  const AdminSchemeAddUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        title: Text(
          controller.isUpdate.value ? 'Update Scheme' : 'Create New Scheme',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            ClassicCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      controller.isUpdate.value
                          ? 'Scheme Details'
                          : 'New Scheme Info',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: ClassicTheme.getTextPrimary(context),
                        fontFamily: 'Serif',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CommonTextFields(
                    controller: controller.nameController,
                    labelText: 'Scheme Name',
                    prefixIcon: const Icon(Icons.title),
                  ),
                  const SizedBox(height: 16),
                  CommonTextFields(
                    controller: controller.descriptionController,
                    labelText: 'Description',
                    prefixIcon: const Icon(Icons.description),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  CommonTextFields(
                    controller: controller.totalAmountController,
                    labelText: 'Total Amount',
                    prefixIcon: const Icon(Icons.account_balance_wallet),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CommonTextFields(
                    controller: controller.emiAmountController,
                    labelText: 'EMI Amount',
                    prefixIcon: const Icon(Icons.currency_rupee),
                    keyboardType: TextInputType.number,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: CommonTextFields(
                  //         controller: controller.totalAmountController,
                  //         labelText: 'Total Amount',
                  //         prefixIcon: const Icon(Icons.account_balance_wallet),
                  //         keyboardType: TextInputType.number,
                  //       ),
                  //     ),
                  //     const SizedBox(width: 16),
                  //     Expanded(
                  //       child: CommonTextFields(
                  //         controller: controller.emiAmountController,
                  //         labelText: 'EMI Amount',
                  //         prefixIcon: const Icon(Icons.currency_rupee),
                  //         keyboardType: TextInputType.number,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 16),
                  CommonTextFields(
                    controller: controller.durationMonthsController,
                    labelText: 'Duration (Months)',
                    prefixIcon: const Icon(Icons.timer),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Obx(
                        () => controller.isUpdate.value
                        ? const SizedBox.shrink()
                        : CommonTextFields(
                      controller: controller.jewellerCodeController,
                      labelText: 'Jeweller Code',
                      prefixIcon: const Icon(Icons.store),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: CommonTextFields(
                  //         controller: controller.durationMonthsController,
                  //         labelText: 'Duration (Months)',
                  //         prefixIcon: const Icon(Icons.timer),
                  //         keyboardType: TextInputType.number,
                  //       ),
                  //     ),
                  //     const SizedBox(width: 16),
                  //     Expanded(
                  //       child: Obx(
                  //         () => controller.isUpdate.value
                  //             ? const SizedBox.shrink()
                  //             : CommonTextFields(
                  //                 controller: controller.jewellerCodeController,
                  //                 labelText: 'Jeweller Code',
                  //                 prefixIcon: const Icon(Icons.store),
                  //               ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => controller.selectDate(
                            context,
                            controller.startDateController,
                          ),
                          child: IgnorePointer(
                            child: CommonTextFields(
                              controller: controller.startDateController,
                              labelText: 'Start Date',
                              prefixIcon: const Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: () => controller.selectDate(
                            context,
                            controller.endDateController,
                          ),
                          child: IgnorePointer(
                            child: CommonTextFields(
                              controller: controller.endDateController,
                              labelText: 'End Date',
                              prefixIcon: const Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ClassicOutlinedButton(
              margin: AppDesignConstants.paddingHorizontal,
              onPressed: () {
                controller.onTapUpdateCreate();
              },
              text: controller.isUpdate.value ? 'Update Scheme' : 'Save Scheme',
            ),
            Obx(
              () => controller.isUpdate.value
                  ? Column(
                      children: [
                        const SizedBox(height: 16),
                        ClassicOutlinedButton(
                          margin: AppDesignConstants.paddingHorizontal,
                          onPressed: () {
                            Get.dialog(
                              AlertDialog(
                                title: const Text('Delete Scheme'),
                                content: const Text(
                                  'Are you sure you want to delete this scheme?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller.deleteScheme();
                                      Get.back();
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          text: 'Delete Scheme',
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
