import 'package:digital_jeweller/core/base/base_repository.dart';
import 'package:digital_jeweller/core/service_locator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:digital_jeweller/core/utils/snackbar_utils.dart';

abstract class BaseController<R extends BaseRepository> extends GetxController {
  /// The repository instance for this controller.
  /// Resolved lazily from the service locator when first accessed.
  R get repository => sl<R>();

  final isLoading = false.obs;

  void showLoading() => isLoading.value = true;

  void hideLoading() => isLoading.value = false;

  void showError(String message) {
    SnackBarUtils.showError(message);
  }

  void showSuccess(String message) {
    // According to user request: not show any flushbar for success
    debugPrint('Success: $message');
  }
}
