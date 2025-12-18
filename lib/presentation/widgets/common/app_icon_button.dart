import 'package:flutter/material.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';
import 'package:amorra/core/utils/app_responsive/app_responsive.dart';
import 'package:amorra/presentation/widgets/common/app_loading_indicator.dart';

/// App Icon Button Widget
/// Reusable circular icon button with loading state support
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;
  final double? iconSize;
  final EdgeInsets? padding;
  final List<BoxShadow>? boxShadow;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.isLoading = false,
    this.backgroundColor,
    this.iconColor,
    this.size,
    this.iconSize,
    this.padding,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = size ?? AppResponsive.iconSize(context, factor: 1.5);
    final finalIconSize =
        iconSize ?? AppResponsive.iconSize(context, factor: 0.8);
    final finalBackgroundColor = backgroundColor ?? AppColors.white;
    final finalIconColor = iconColor ?? AppColors.primary;
    final finalPadding =
        padding ?? EdgeInsets.all(AppResponsive.screenWidth(context) * 0.02);

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        padding: finalPadding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: finalBackgroundColor,
        ),
        child: isLoading
            ? Center(
                child: AppLoadingIndicator(
                  size: finalIconSize,
                  color: finalIconColor,
                ),
              )
            : Icon(icon, color: finalIconColor, size: finalIconSize),
      ),
    );
  }
}
