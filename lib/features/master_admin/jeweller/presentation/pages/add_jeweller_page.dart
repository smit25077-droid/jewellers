import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:digital_jeweller/core/constants/api_endpoints.dart';
import 'package:digital_jeweller/core/utils/input_formatters.dart';
import 'package:flutter/services.dart';
import '../controllers/jeweller_controller.dart';

class AddJewellerPage extends GetWidget<JewellerController> {
  const AddJewellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          controller.isEditMode.value ? 'Edit Jeweller' : 'Add New Jeweller',
        )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              // Logo Picker
              _buildLogoPicker(),
              const SizedBox(height: 24),
              
              _buildTextField(
                controller.nameController,
                'Jeweller Name',
                Icons.person,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Jeweller Name';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller.shopNameController,
                'Shop Name',
                Icons.store,
                textCapitalization: TextCapitalization.words,
              ),
              _buildTextField(
                controller.addressController,
                'Shop Address',
                Icons.location_on,
                textCapitalization: TextCapitalization.words,
              ),
              _buildTextField(
                controller.phoneController,
                'Mobile Number',
                Icons.phone,
                keyboardType: TextInputType.phone,
                inputFormatters: [AppInputFormatters.phone, AppInputFormatters.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Mobile Number';
                  }
                  if (value.length != 10) {
                    return 'Mobile number must be 10 digits';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller.emailController,
                'Email',
                Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              Obx(() => controller.isEditMode.value
                ? _buildTextField(
                    controller.passwordController,
                    'Password (Leave empty to keep current)',
                    Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  )
                : _buildTextField(
                    controller.passwordController,
                    'Password',
                    Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
              ),
              _buildTextField(
                controller.jewellerCodeController,
                'Jeweller Code',
                Icons.code,
                inputFormatters: [AppInputFormatters.uppercase],
                textCapitalization: TextCapitalization.characters,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Jeweller Code';
                  }
                  return null;
                },
              ),
              const Divider(height: 32),
              _buildTextField(
                controller.panController,
                'PAN Card',
                Icons.credit_card,
                inputFormatters: [AppInputFormatters.uppercase, LengthLimitingTextInputFormatter(10)],
                textCapitalization: TextCapitalization.characters,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (value.length != 10) {
                      return 'PAN must be 10 characters';
                    }
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller.aadharController,
                'Aadhar Card',
                Icons.badge,
                keyboardType: TextInputType.number,
                inputFormatters: [AppInputFormatters.aadhar, AppInputFormatters.digitsOnly],
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (value.length != 12) {
                      return 'Aadhar must be 12 digits';
                    }
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller.gstController,
                'GST Number (27ABCDE1234F2Z5)',
                Icons.description,
                inputFormatters: [AppInputFormatters.uppercase, LengthLimitingTextInputFormatter(15)],
                textCapitalization: TextCapitalization.characters,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (value.length != 15) {
                      return 'GST must be 15 characters';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: controller.isCreatingJeweller.value
                      ? null
                      : () {
                          if (controller.isEditMode.value) {
                            controller.updateJeweller();
                          } else {
                            controller.addJeweller();
                          }
                        },
                  child: controller.isCreatingJeweller.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(controller.isEditMode.value ? 'Update Jeweller' : 'Save Jeweller'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoPicker() {
    return Obx(() {
      final logoPath = controller.selectedLogoPath.value;
      
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            if (logoPath != null && logoPath.isNotEmpty)
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: logoPath.startsWith('http')
                      ? Image.network(
                          ApiEndpoints.getImageUrl(logoPath),
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 150,
                              width: 150,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.error, size: 50),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 150,
                              width: 150,
                              color: Colors.grey.shade200,
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        )
                      : (kIsWeb || logoPath.startsWith('blob:'))
                        ? Image.network(
                            logoPath,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(logoPath),
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: controller.removeLogo,
                      icon: const Icon(Icons.close, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ],
              )
            else
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.store, size: 60, color: Colors.grey),
              ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: controller.pickLogo,
              icon: const Icon(Icons.upload),
              label: Text(logoPath != null ? 'Change Logo' : 'Upload Logo'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Recommended: 512x512 px, Max 2MB',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
      ),
    );
  }
}
