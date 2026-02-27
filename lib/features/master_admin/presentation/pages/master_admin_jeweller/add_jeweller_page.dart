import 'package:digital_jeweller/features/master_admin/presentation/controllers/master_admin_controller.dart';
import 'package:digital_jeweller/features/master_admin/presentation/controllers/master_admin_jeweller_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddJewellerPage extends GetWidget<MasterAdminJewellerController> {
  const AddJewellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final masterAdminCont = Get.find<MasterAdminController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Jeweller')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: masterAdminCont.formKey,
          child: Column(
            children: [
              _buildTextField(
                controller.nameController,
                'Jeweller Name',
                Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Jeweller Name';
                  }
                  return null;
                },
              ),
              _buildTextField(controller.shopNameController, 'Shop Name', Icons.store),
              _buildTextField(
                controller.addressController,
                'Shop Address',
                Icons.location_on,
              ),
              _buildTextField(
                controller.phoneController,
                'Mobile Number',
                Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                controller.emailController,
                'Email',
                Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                controller.passwordController,
                'Password',
                Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Password';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller.jewellerCodeController,
                'Jeweller Code',
                Icons.code,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Jeweller Code';
                  }
                  return null;
                },
              ),
              const Divider(height: 32),
              _buildTextField(controller.panController, 'PAN Card', Icons.credit_card),
              _buildTextField(controller.aadharController, 'Aadhar Card', Icons.badge),
              _buildTextField(
                controller.gstController,
                'GST Number (27ABCDE1234F2Z5)',
                Icons.description,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (masterAdminCont.formKey.currentState!.validate()) {
                    controller.addJeweller();
                  }
                },
                child: const Text('Save Jeweller'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType? keyboardType,
    String? Function(String?)? validator,
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
      ),
    );
  }
}
