import 'package:amorra/core/utils/app_images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';
import 'package:amorra/core/utils/app_responsive/app_responsive.dart';
import 'package:amorra/core/utils/app_spacing/app_spacing.dart';
import 'package:amorra/core/utils/app_styles/app_text_styles.dart';
import 'package:amorra/core/utils/app_texts/app_texts.dart';

/// Chat Empty State Widget
/// Shows empty state when there are no messages
class ChatEmptyState extends StatelessWidget {
  const ChatEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.startConversation,
            height: AppResponsive.screenHeight(context) * 0.2,
            width: AppResponsive.screenWidth(context) * 0.7,
          ),
          AppSpacing.vertical(context, 0.02),
          Text(
            AppTexts.chatEmptyStateTitle,
            style: AppTextStyles.headline(context).copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              fontSize: AppResponsive.scaleSize(context, 22),
            ),
          ),
          Text(
            AppTexts.chatEmptyStateSubtitle,
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.grey,
              fontSize: AppResponsive.scaleSize(context, 14),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
