import 'dart:io';

import 'package:digital_jeweller/core/constants/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CommonImagePicker {
  static final ImagePicker _picker = ImagePicker();

  /// Shows a bottom sheet to pick image source and returns the picked image path or null if cancelled.
  static Future<String?> pickImage(BuildContext context, {String? currentImagePath}) async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
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
            if (currentImagePath != null)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text(
                  'Remove Photo',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () => Navigator.pop(context, null), // Return null to indicate removal
              ),
          ],
        ),
      ),
    );

    if (source == null) return null; // User dismissed bottom sheet without choosing

    // If user tapped "Remove Photo"
    if (currentImagePath != null &&  source == null) {
      return null;
    }

    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 800,
    );

    return pickedFile?.path;
  }
}

/// Widget that shows an image from either a local file path or a network URL.
/// If both are null or empty, shows a default placeholder icon.
class ShowImage extends StatelessWidget {
  final String? localPath; // Local file path (picked image)
  final String? networkUrl; // Network image URL
  final double radius;
  final Color backgroundColor;
  final Widget? placeholder;

  const ShowImage({
    Key? key,
    this.localPath,
    this.networkUrl,
    this.radius = 48,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    if (localPath != null && localPath!.isNotEmpty) {
      imageProvider = FileImage(File(localPath!));
    } else if (networkUrl != null && networkUrl!.isNotEmpty) {
      final fullUrl = ApiEndpoints.getImageUrl(networkUrl!);
      if (fullUrl.isNotEmpty) {
        imageProvider = NetworkImage(fullUrl);
      }
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      backgroundImage: imageProvider,
      child: imageProvider == null
          ? (placeholder ??
          Icon(
            Icons.person,
            size: radius,
            color: Colors.grey.shade600,
          ))
          : null,
    );
  }
}
