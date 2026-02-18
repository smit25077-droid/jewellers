import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Global Loading Overlay Controller
class LoadingOverlay {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  /// Show loading overlay
  static void show({String? message}) {
    if (_isShowing) return;

    _isShowing = true;
    _overlayEntry = OverlayEntry(
      builder: (context) => _LoadingWidget(message: message),
    );

    Overlay.of(Get.overlayContext!).insert(_overlayEntry!);
  }

  /// Hide loading overlay
  static void hide() {
    if (!_isShowing) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
    _isShowing = false;
  }

  /// Check if loading is currently showing
  static bool get isShowing => _isShowing;
}

/// Loading Widget
class _LoadingWidget extends StatelessWidget {
  final String? message;

  const _LoadingWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message!,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Loading Dialog (Alternative approach)
class LoadingDialog {
  static bool _isShowing = false;

  /// Show loading dialog
  static void show({String? message}) {
    if (_isShowing) return;

    _isShowing = true;
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                if (message != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Hide loading dialog
  static void hide() {
    if (!_isShowing) return;

    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    _isShowing = false;
  }
}
