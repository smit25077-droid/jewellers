import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'classic_card.dart';
import '../utils/snackbar_utils.dart';

/// Common logout dialog with theme support
class CommonDialogs {
  /// Show logout confirmation dialog
  static Future<bool> showLogoutDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const LogoutConfirmDialog(),
    );
    return result ?? false;
  }

  /// Show delete confirmation dialog
  static Future<bool> showDeleteDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmDialog(title: title, message: message),
    );
    return result ?? false;
  }

  /// Show success message
  static void showSuccess(String message) {
    debugPrint('Success: $message');
  }

  /// Show error message
  static void showError(String message) {
    SnackBarUtils.showError(message);
  }
}

/// Logout confirmation dialog
class LogoutConfirmDialog extends StatelessWidget {
  const LogoutConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: ClassicTheme.getCardBackground(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.warning.withAlpha(1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.logout, size: 48, color: AppColors.warning),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: ClassicTheme.getTextPrimary(context),
                fontFamily: 'Serif',
              ),
            ),
            const SizedBox(height: 12),

            // Message
            Text(
              'Are you sure you want to logout?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: ClassicTheme.getTextSecondary(context),
              ),
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: isDark
                            ? Colors.white.withAlpha(3)
                            : Colors.grey.shade300,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: ClassicTheme.getTextSecondary(context),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Delete confirmation dialog
class DeleteConfirmDialog extends StatelessWidget {
  final String title;
  final String message;

  const DeleteConfirmDialog({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: ClassicTheme.getCardBackground(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.error.withAlpha(1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline,
                size: 48,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: ClassicTheme.getTextPrimary(context),
                fontFamily: 'Serif',
              ),
            ),
            const SizedBox(height: 12),

            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: ClassicTheme.getTextSecondary(context),
              ),
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: isDark
                            ? Colors.white.withAlpha(3)
                            : Colors.grey.shade300,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: ClassicTheme.getTextSecondary(context),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
