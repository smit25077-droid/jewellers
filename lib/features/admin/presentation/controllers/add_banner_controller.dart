
import 'package:digital_jeweller/features/admin/domain/usecases/create_banner_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBannerController extends GetxController {
  final CreateBannerUseCase _createBannerUseCase;

  AddBannerController({required CreateBannerUseCase createBannerUseCase})
      : _createBannerUseCase = createBannerUseCase;

  final titleController = TextEditingController();
  final imageUrlController = TextEditingController();
  final linkController = TextEditingController();

  final isLoading = false.obs;

  Future<void> createBanner() async {
    isLoading.value = true;
    final result = await _createBannerUseCase(
      title: titleController.text,
      imageUrl: imageUrlController.text,
      link: linkController.text,
    );
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (_) => Get.back(),
    );
    isLoading.value = false;
  }
}
