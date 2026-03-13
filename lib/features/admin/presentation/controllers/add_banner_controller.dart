import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:digital_jeweller/features/admin/banner/domain/usecases/create_banner_usecase.dart';

class AddBannerController extends GetxController {
  final CreateBannerUseCase _createBannerUseCase;

  AddBannerController({required CreateBannerUseCase createBannerUseCase})
    : _createBannerUseCase = createBannerUseCase;

  final titleController = TextEditingController();
  final linkController = TextEditingController();
  final selectedBannerPath = RxnString();
  final _imagePicker = ImagePicker();

  final isLoading = false.obs;

  Future<void> createBanner() async {
    if (titleController.text.isEmpty || selectedBannerPath.value == null) {
      Get.snackbar('Error', 'Please fill in title and pick an image');
      return;
    }

    isLoading.value = true;
    final result = await _createBannerUseCase(
      title: titleController.text.trim(),
      imageUrl: selectedBannerPath.value!,
      link: linkController.text.trim(),
    );
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (_) => Get.back(),
    );
    isLoading.value = false;
  }

  @override
  void onClose() {
    titleController.dispose();
    linkController.dispose();
    super.onClose();
  }

  Future<void> pickBannerImage(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take a Photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      final picked = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
      );
      if (picked != null) selectedBannerPath.value = picked.path;
    }
  }
}
