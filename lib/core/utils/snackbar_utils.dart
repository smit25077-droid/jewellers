import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarUtils {
  static String? _lastMessage;
  static DateTime? _lastShown;

  static void showError(String message) {
    // Prevent duplicate snackbars within 2 seconds
    final now = DateTime.now();
    if (_lastMessage == message &&
        _lastShown != null &&
        now.difference(_lastShown!) < const Duration(seconds: 2)) {
      return;
    }

    _lastMessage = message;
    _lastShown = now;

    if (Get.context != null) {
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.TOP, // Moved to TOP
        backgroundColor: Colors.redAccent.withOpacity(0.9),
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white, size: 18),
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Smaller horizontal size
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Compact padding
        borderRadius: 8,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        dismissDirection: DismissDirection.up,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }

  static void showSuccess(String message) {
    debugPrint('Success: $message');
  }
}
