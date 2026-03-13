import 'package:digital_jeweller/core/constants/app_design_constants.dart';
import 'package:digital_jeweller/core/widgets/classic_card.dart';
import 'package:digital_jeweller/core/widgets/image_picker.dart';
import 'package:digital_jeweller/features/admin/presentation/customer_add_update/controller/customer_add_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_loading.dart';

class CustomerAddUpdatePage extends GetView<CustomerAddUpdateController> {
  const CustomerAddUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        title: Text(
          controller.customer.value != null ? 'Update Customer' : 'Create Customer',
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        // Show global loading overlay if needed
        if (controller.isLoading.value && controller.customerObservable.value == null) {
          return const CommonLoading(message: 'Loading customer...');
        }

        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  ClassicCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.customer.value != null ? 'Customer Details' : 'New Customer',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: ClassicTheme.getTextPrimary(context),
                                fontFamily: 'Serif',
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_outline, color: AppColors.error),
                              onPressed: () => controller.onDeleteCustomer(context: context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Center(
                          child: Obx(() {
                            return GestureDetector(
                              onTap: () => controller.pickImage(context),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ShowImage(
                                    localPath: controller.selectedImagePath.value,
                                    // your picked image path (nullable)
                                    networkUrl: controller.customer.value?.profileImage,
                                    // your network image URL (nullable)
                                    radius: 48,
                                    backgroundColor: Colors.grey.shade200,
                                    placeholder: Icon(Icons.person, size: 48, color: Colors.grey.shade500),
                                  ),

                                  Positioned(
                                    bottom: 0,
                                    right: -4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ClassicTheme.getAccentBrown(context),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                      padding: const EdgeInsets.all(6),
                                      child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 8),

                        Center(
                          child: Text(
                            'Tap to add profile photo (optional)',
                            style: TextStyle(fontSize: 12, color: ClassicTheme.getTextSecondary(context)),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ],
                        _buildForm(context),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Submit Button
                  ClassicOutlinedButton(
                    margin: AppDesignConstants.paddingHorizontal,
                    text: controller.customer.value != null ? 'Update Customer' : 'Create Customer',
                    onPressed: () => controller.customer.value == null
                        ? controller.createCustomer()
                        : controller.onSave(customer: controller.customer.value!),
                    icon: controller.customer.value != null ? Icons.save_outlined : Icons.person_add_outlined,
                  ),
                ],
              ),
            ),
            if (controller.isRefreshing.value)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  minHeight: 2,
                  color: AppColors.primary,
                  backgroundColor: AppColors.primary.withAlpha(2),
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildForm(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? Colors.white.withAlpha(2) : Colors.grey.shade300;
    final fillColor = isDark ? const Color(0xFF3A3A3A) : const Color(0xFFF5F5F5);

    return Column(
      children: [
        TextField(
          controller: controller.nameController,
          style: TextStyle(color: ClassicTheme.getTextPrimary(context), fontFamily: 'Serif'),
          decoration: InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(color: ClassicTheme.getTextSecondary(context)),
            prefixIcon: Icon(Icons.person, color: ClassicTheme.getAccentBrown(context)),
            filled: true,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: ClassicTheme.getAccentBrown(context), width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller.phoneController,
          enabled: controller.customer.value == null,
          style: TextStyle(color: ClassicTheme.getTextPrimary(context), fontFamily: 'Serif'),
          decoration: InputDecoration(
            labelText: 'Mobile Number',
            labelStyle: TextStyle(color: ClassicTheme.getTextSecondary(context)),
            prefixIcon: Icon(Icons.phone, color: ClassicTheme.getAccentBrown(context)),
            counterText: '',
            filled: true,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: ClassicTheme.getAccentBrown(context), width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: borderColor.withAlpha(5)),
            ),
          ),
          keyboardType: TextInputType.phone,
          maxLength: 10,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller.emailController,
          style: TextStyle(color: ClassicTheme.getTextPrimary(context), fontFamily: 'Serif'),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: ClassicTheme.getTextSecondary(context)),
            prefixIcon: Icon(Icons.email, color: ClassicTheme.getAccentBrown(context)),
            filled: true,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: ClassicTheme.getAccentBrown(context), width: 1.5),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        if (controller.customer.value == null) ...{
          const SizedBox(height: 16),
          TextField(
            controller: controller.passwordController,
            style: TextStyle(color: ClassicTheme.getTextPrimary(context), fontFamily: 'Serif'),
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: ClassicTheme.getTextSecondary(context)),
              prefixIcon: Icon(Icons.lock, color: ClassicTheme.getAccentBrown(context)),
              filled: true,
              fillColor: fillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: ClassicTheme.getAccentBrown(context), width: 1.5),
              ),
            ),
            obscureText: true,
          ),
        },
      ],
    );
  }
}
