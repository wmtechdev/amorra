import 'package:amorra/core/utils/app_gradient/app_gradient.dart';
import 'package:amorra/core/utils/app_images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';
import 'package:amorra/core/utils/app_responsive/app_responsive.dart';
import 'package:amorra/core/utils/app_spacing/app_spacing.dart';
import 'package:amorra/core/utils/app_styles/app_text_styles.dart';
import 'package:amorra/core/utils/app_texts/app_texts.dart';
import 'package:amorra/presentation/widgets/chat/chat_date_label.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:amorra/presentation/controllers/chat/chat_controller.dart';
import 'package:amorra/presentation/controllers/auth/auth_controller.dart';

/// Chat Header Widget
/// Header with AI name and status
class ChatHeader extends GetView<ChatController> {
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ).withAppGradient(),
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
                      Obx(() {
                        // Listen to user changes to update status
                        final authController = Get.find<AuthController>();
                        final userName =
                            authController.currentUser.value?.name ?? '';

                        // Get first name
                        String firstName = '';
                        if (userName.isNotEmpty) {
                          final nameParts = userName.trim().split(' ');
                          firstName = nameParts.isNotEmpty ? nameParts[0] : '';
                        }

                        // Build status message
                        final statusMessage = firstName.isNotEmpty
                            ? '${AppTexts.chatAIStatusWithName} $firstName!'
                            : AppTexts.chatAIStatus;

                        return Text(
                          statusMessage,
                          style: AppTextStyles.hintText(context).copyWith(
                            color: AppColors.success,
                            fontSize: AppResponsive.scaleSize(context, 12),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                // // Settings Icon
                // IconButton(
                //   icon: Icon(
                //     Iconsax.setting_3,
                //     color: AppColors.black,
                //     size: AppResponsive.iconSize(context, factor: 1.2),
                //   ),
                //   onPressed: controller.showProfileSetupBottomSheet,
                //   padding: EdgeInsets.zero,
                //   constraints: const BoxConstraints(),
                // ),
              ],
            ),
          ),

          // Date label on border
          Center(child: ChatDateLabel(date: DateTime.now())),
        ],
      ),
    );
  }
}
