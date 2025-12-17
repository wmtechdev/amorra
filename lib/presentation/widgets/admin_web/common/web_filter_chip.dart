import 'package:amorra/core/utils/app_gradient/app_gradient.dart';
import 'package:flutter/material.dart';
import 'package:amorra/core/utils/web/web_responsive/web_responsive.dart';
import 'package:amorra/core/utils/web/web_text_styles/web_text_styles.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';

/// Web Filter Chip Widget
/// Desktop-optimized filter chip for admin dashboard
class WebFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const WebFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        WebResponsive.radius(context, factor: 2.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: WebResponsive.isDesktop(context) ? 16 : 12,
          vertical: WebResponsive.isDesktop(context) ? 6 : 4,
        ),
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(
                  WebResponsive.radius(context, factor: 2.0),
                ),
              ).withAppGradient()
            : BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(
                  WebResponsive.radius(context, factor: 2.0),
                ),
                border: Border.all(color: AppColors.lightGrey, width: 1),
              ),
        child: Text(
          label,
          style: WebTextStyles.bodyText(context).copyWith(
            color: isSelected ? AppColors.white : AppColors.black,
            fontWeight: FontWeight.normal,
            fontSize: WebResponsive.fontSize(context, factor: 0.875),
          ),
        ),
      ),
    );
  }
}
