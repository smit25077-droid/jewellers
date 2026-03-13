import 'dart:io';

import 'package:digital_jeweller/features/admin/presentation/controllers/add_banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBannerPage extends GetView<AddBannerController> {
  const AddBannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Banner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16.0),
            // Banner Image Picker
            Obx(
              () => GestureDetector(
                onTap: () => controller.pickBannerImage(context),
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                    image: controller.selectedBannerPath.value != null
                        ? DecorationImage(
                            image: FileImage(
                              File(controller.selectedBannerPath.value!),
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: controller.selectedBannerPath.value == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 48,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Pick Banner Image',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: controller.linkController,
              decoration: const InputDecoration(labelText: 'Link'),
            ),
            const SizedBox(height: 32.0),
            Obx(() {
              return ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.createBanner(),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Create Banner'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
