import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_controller.dart';

class BannerManagementPage extends StatelessWidget {
  const BannerManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();
    final urlController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Ad Banners')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: urlController,
                    decoration: const InputDecoration(
                      labelText: 'Banner Image URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // if (urlController.text.isNotEmpty) {
                    //   controller.addBanner(
                    //     AdBanner(
                    //       id: DateTime.now().millisecondsSinceEpoch.toString(),
                    //       imageUrl: urlController.text,
                    //       jewellerId: 'current_jeweller_id',
                    //     ),
                    //   );
                    //   urlController.clear();
                    // }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.banners.length,
                itemBuilder: (context, index) {
                  final banner = controller.banners[index];
                  return Stack(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(banner.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 24,
                        top: 24,
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: () => controller.removeBanner(banner.id),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.red.withValues(alpha:0.7),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
