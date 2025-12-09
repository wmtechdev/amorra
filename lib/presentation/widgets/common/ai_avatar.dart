import 'package:amorra/core/utils/app_gradient/app_gradient.dart';
import 'package:amorra/core/utils/app_images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';
import 'package:amorra/core/utils/app_responsive/app_responsive.dart';
import 'package:amorra/core/utils/app_spacing/app_spacing.dart';

/// AI Avatar Widget
/// Reusable AI avatar with gradient background
class AIAvatar extends StatelessWidget {
  final double? size;
  final double? iconSize;

  const AIAvatar({
    super.key,
    this.size,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = size ?? AppResponsive.iconSize(context, factor: 2);
    final imageSize = iconSize ?? AppResponsive.iconSize(context, factor: 0.8);

    return Container(
      width: avatarSize,
      height: avatarSize,
      padding: AppSpacing.all(context, factor: 0.5),
      decoration: BoxDecoration(shape: BoxShape.circle).withAppGradient(),
      child: Image.asset(
        AppImages.chatbotLogo,
        height: imageSize,
        width: imageSize,
        color: AppColors.white,
      ),
    );
  }
}

