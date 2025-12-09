import 'package:amorra/core/utils/app_gradient/app_gradient.dart';
import 'package:amorra/core/utils/app_images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';
import 'package:amorra/core/utils/app_responsive/app_responsive.dart';
import 'package:amorra/core/utils/app_spacing/app_spacing.dart';
import 'package:amorra/core/utils/app_styles/app_text_styles.dart';
import 'package:amorra/core/utils/app_texts/app_texts.dart';
import 'package:amorra/presentation/widgets/chat/chat_date_label.dart';

/// Chat Header Widget
/// Header with AI name and status
class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.lightGrey, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main header content
          Padding(
            padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
            child: Row(
              children: [
                // AI Avatar
                Container(
                  width: AppResponsive.iconSize(context, factor: 2),
                  height: AppResponsive.iconSize(context, factor: 2),
                  padding: AppSpacing.all(context, factor: 0.5),
                  decoration: BoxDecoration(shape: BoxShape.circle).withAppGradient(),
                  child: Image.asset(
                    AppImages.chatbotLogo,
                    height: AppResponsive.iconSize(context, factor: 0.8),
                    width: AppResponsive.iconSize(context, factor: 0.8),
                    color: AppColors.white,
                  ),
                ),
                AppSpacing.horizontal(context, 0.02),

                // AI Name and Status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppTexts.chatAIPersonaName,
                        style: AppTextStyles.heading(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          fontSize: AppResponsive.scaleSize(context, 18),
                        ),
                      ),
                      Text(
                        AppTexts.chatAIStatus,
                        style: AppTextStyles.hintText(context).copyWith(
                          color: AppColors.success,
                          fontSize: AppResponsive.scaleSize(context, 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Date label on border
          Center(
            child: ChatDateLabel(date: DateTime.now()),
          ),
        ],
      ),
    );
  }
}

