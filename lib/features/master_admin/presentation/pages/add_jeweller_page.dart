import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/master_admin_controller.dart';
// import '../../domain/entities/jeweller.dart';

class AddJewellerPage extends StatelessWidget {
  const AddJewellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final get = Get.find<MasterAdminController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Jeweller')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: get.formKey,
          child: Column(
            children: [
              _buildTextField(
                get.nameController,
                'Jeweller Name',
                Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Jeweller Name';
                  }
                  return null;
                },
              ),
              _buildTextField(get.shopNameController, 'Shop Name', Icons.store),
              _buildTextField(
                get.addressController,
                'Shop Address',
                Icons.location_on,
              ),
              _buildTextField(
                get.phoneController,
                'Mobile Number',
                Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                get.emailController,
                'Email',
                Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                get.passwordController,
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
                get.jewellerCodeController,
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
              _buildTextField(get.panController, 'PAN Card', Icons.credit_card),
              _buildTextField(get.aadharController, 'Aadhar Card', Icons.badge),
              _buildTextField(
                get.gstController,
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
                  if (get.formKey.currentState!.validate()) {
                    get.addJeweller();
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
