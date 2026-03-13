import 'package:cached_network_image/cached_network_image.dart';
import 'package:digital_jeweller/core/constants/app_design_constants.dart';
import 'package:digital_jeweller/features/admin/banner/domain/entities/banner.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:get/get.dart';

class BannerCard extends StatelessWidget {
  final Banner banner;

  const BannerCard({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(banner.link),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: AppDesignConstants.borderRadiusM,
          boxShadow: AppDesignConstants.getShadow(),
        ),
        child: ClipRRect(
          borderRadius: AppDesignConstants.borderRadiusM,
          child: CachedNetworkImage(
            imageUrl: banner.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Image.network(
              'https://placehold.co/600x400/grey/white?text=${banner.title.replaceAll(' ', '+')}',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
