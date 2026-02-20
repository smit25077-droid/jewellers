import 'package:digital_jeweller/features/admin/domain/entities/scheme.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_design_constants.dart';

class SchemeCard extends StatelessWidget {
  final Scheme scheme;

  const SchemeCard({super.key, required this.scheme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Card(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: AppDesignConstants.borderRadiusM,
        ),
        child: InkWell(
          onTap: () {
            /* Navigate to scheme details */
          },
          borderRadius: AppDesignConstants.borderRadiusM,
          child: Padding(
            padding: AppDesignConstants.padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scheme.name,
                  style: AppDesignConstants.titleLarge(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppDesignConstants.spaceS),
                Text(
                  scheme.description,
                  style: AppDesignConstants.bodyMedium(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${scheme.emiAmount}/month',
                      style: AppDesignConstants.titleMedium().copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${scheme.durationMonths} Months',
                      style: AppDesignConstants.bodySmall(
                        // color: AppColors.getTextColor(context, secondary: true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
