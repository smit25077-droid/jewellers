import 'package:digital_jeweller/core/base/base_repository.dart';
import 'package:digital_jeweller/core/service_locator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

abstract class BaseController<R extends BaseRepository> extends GetxController {
  /// The repository instance for this controller.
  /// Resolved lazily from the service locator when first accessed.
  R get repository => sl<R>();

  final isLoading = false.obs;

  void showLoading() => isLoading.value = true;

  void hideLoading() => isLoading.value = false;

  void showError(String message) {
    try {
      if (Get.context != null) {
        Get.snackbar(
          titleText: const SizedBox.shrink(),
          '',
          message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withAlpha(9),
          colorText: Colors.white,
          margin: const EdgeInsets.all(8),
          borderRadius: 10,
        );
      } else {
        debugPrint(
          '⚠️ BaseController: Cannot show error snackbar (no context): $message',
        );
      }
    } catch (e) {
      debugPrint('⚠️ BaseController: Error showing snackbar: $e');
      debugPrint('⚠️ BaseController: Original error message: $message');
    }
  }

  void showSuccess(String message) {
    try {
      if (Get.context != null) {
        Get.snackbar(
          titleText: const SizedBox.shrink(),
          '',
          message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withAlpha(9),
          colorText: Colors.white,
          margin: const EdgeInsets.all(8),
          borderRadius: 10,
        );
      } else {
        debugPrint(
          '⚠️ BaseController: Cannot show success snackbar (no context): $message',
        );
      }
    } catch (e) {
      debugPrint('⚠️ BaseController: Error showing snackbar: $e');
      debugPrint('⚠️ BaseController: Original success message: $message');
    }
  }
}
