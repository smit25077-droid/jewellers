
import 'package:digital_jeweller/features/admin/presentation/controllers/add_banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBannerPage extends GetView<AddBannerController> {
  const AddBannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Banner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: controller.imageUrlController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: controller.linkController,
              decoration: const InputDecoration(
                labelText: 'Link',
              ),
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
