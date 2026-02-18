import 'package:digital_jeweller/core/constants/app_design_constants.dart';
import 'package:digital_jeweller/core/widgets/classic_card.dart';
import 'package:digital_jeweller/features/admin/presentation/customer_add_update/controller/customer_add_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_loading.dart';
import '../../domain/entities/customer.dart';

class CustomerAddUpdatePage extends GetView<CustomerAddUpdateController> {
  final Customer? customer;

  const CustomerAddUpdatePage({super.key, this.customer});

  //   @override
  //   State<CustomerAddUpdatePage> createState() => _CustomerAddUpdatePageState();
  // }
  //
  // class _CustomerAddUpdatePageState extends State<CustomerAddUpdatePage> {
  //   CustomerAddUpdateController get controller =>
  //       Get.find<CustomerAddUpdateController>();

  // @override
  // void initState() {
  //   super.initState();
  //   // Handle arguments - ensure it's a Customer or null, not a List
  //   final args =  customer;
  //   controller.customer.value = (args is Customer) ? args : null;
  //
  //   if (controller.customer.value != null) {
  //     controller.loadLatestDetails(controller.customer.value!);
  //   }
  //   controller.nameController.text = controller.customer.value?.name ?? '';
  //   controller.phoneController.text = controller.customer.value?.phone ?? '';
  //   controller.emailController.text = controller.customer.value?.email ?? '';
  // }

  @override
  Widget build(BuildContext context) {
    final args = customer;
    controller.customer.value = (args is Customer) ? args : null;
    if (controller.customer.value != null) {
      controller.loadLatestDetails(controller.customer.value!);
    }
    controller.nameController.text = controller.customer.value?.name ?? '';
    controller.phoneController.text = controller.customer.value?.phone ?? '';
    controller.emailController.text = controller.customer.value?.email ?? '';

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        title: Text(
          customer != null ? 'Update Customer' : 'Create Customer',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        // Show global loading overlay if needed
        if (controller.isLoading.value &&
            controller.customerObservable.value == null) {
          return const CommonLoading(message: 'Loading customer...');
        }

        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  // Customer Header (Edit Mode)
                  if (customer != null) ...{
                    ClassicCard(
                      child: Row(
                        children: [
                          ClassicAvatar(
                            name: controller.nameController.text,
                            size: 56,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.nameController.text,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: ClassicTheme.getTextPrimary(context),
                                    fontFamily: 'Serif',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  controller.phoneController.text,
                                  style: TextStyle(
                                    color: ClassicTheme.getTextSecondary(
                                      context,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: AppColors.error,
                            ),
                            onPressed: () =>
                                controller.onDeleteCustomer(context: context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  },

                  // Form Section
                  ClassicCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer != null
                              ? 'Customer Details'
                              : 'New Customer',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: ClassicTheme.getTextPrimary(context),
                            fontFamily: 'Serif',
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildForm(context),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Submit Button
                  ClassicOutlinedButton(
                    margin: AppDesignConstants.paddingHorizontal,
                    text: customer != null
                        ? 'Update Customer'
                        : 'Create Customer',
                    onPressed: () => customer == null
                        ? controller.createCustomer()
                        : controller.onSave(customer: customer!),
                    icon: customer != null
                        ? Icons.save_outlined
                        : Icons.person_add_outlined,
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
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildForm(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? Colors.white.withOpacity(0.2)
        : Colors.grey.shade300;
    final fillColor = isDark
        ? const Color(0xFF3A3A3A)
        : const Color(0xFFF5F5F5);

    return Column(
      children: [
        TextField(
          controller: controller.nameController,
          style: TextStyle(
            color: ClassicTheme.getTextPrimary(context),
            fontFamily: 'Serif',
          ),
          decoration: InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(
              color: ClassicTheme.getTextSecondary(context),
            ),
            prefixIcon: Icon(
              Icons.person,
              color: ClassicTheme.getAccentBrown(context),
            ),
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
              borderSide: BorderSide(
                color: ClassicTheme.getAccentBrown(context),
                width: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller.phoneController,
          enabled: customer == null,
          style: TextStyle(
            color: ClassicTheme.getTextPrimary(context),
            fontFamily: 'Serif',
          ),
          decoration: InputDecoration(
            labelText: 'Mobile Number',
            labelStyle: TextStyle(
              color: ClassicTheme.getTextSecondary(context),
            ),
            prefixIcon: Icon(
              Icons.phone,
              color: ClassicTheme.getAccentBrown(context),
            ),
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
              borderSide: BorderSide(
                color: ClassicTheme.getAccentBrown(context),
                width: 1.5,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: borderColor.withOpacity(0.5)),
            ),
          ),
          keyboardType: TextInputType.phone,
          maxLength: 10,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller.emailController,
          style: TextStyle(
            color: ClassicTheme.getTextPrimary(context),
            fontFamily: 'Serif',
          ),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(
              color: ClassicTheme.getTextSecondary(context),
            ),
            prefixIcon: Icon(
              Icons.email,
              color: ClassicTheme.getAccentBrown(context),
            ),
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
              borderSide: BorderSide(
                color: ClassicTheme.getAccentBrown(context),
                width: 1.5,
              ),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        if (customer == null) ...{
          const SizedBox(height: 16),
          TextField(
            controller: controller.passwordController,
            style: TextStyle(
              color: ClassicTheme.getTextPrimary(context),
              fontFamily: 'Serif',
            ),
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(
                color: ClassicTheme.getTextSecondary(context),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: ClassicTheme.getAccentBrown(context),
              ),
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
                borderSide: BorderSide(
                  color: ClassicTheme.getAccentBrown(context),
                  width: 1.5,
                ),
              ),
            ),
            obscureText: true,
          ),
        },
      ],
    );
  }
}
