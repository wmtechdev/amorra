import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amorra/data/models/user_model.dart';
import 'package:amorra/presentation/widgets/admin_web/common/web_button.dart';
import 'package:amorra/core/utils/web/web_responsive/web_responsive.dart';
import 'package:amorra/core/utils/web/web_spacing/web_spacing.dart';
import 'package:amorra/core/utils/web/web_text_styles/web_text_styles.dart';
import 'package:amorra/core/utils/web/web_texts/web_texts.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';

/// User Action Dialogs
/// Collection of dialogs for user actions
class UserActionDialogs {
  /// Show block/unblock confirmation dialog
  static void showBlockUnblockDialog(
    BuildContext context,
    UserModel user,
    VoidCallback onConfirm,
  ) {
    Get.dialog(
      AlertDialog(
        title: Text(
          user.isBlocked ? WebTexts.usersUnblock : WebTexts.usersBlock,
          style: WebTextStyles.heading(context),
        ),
        content: Text(
          user.isBlocked
              ? '${WebTexts.usersUnblockConfirm} ${user.name}?'
              : '${WebTexts.usersBlockConfirm} ${user.name}?',
          style: WebTextStyles.bodyText(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(WebTexts.actionCancel),
          ),
          WebButton(
            text: user.isBlocked ? WebTexts.usersUnblock : WebTexts.usersBlock,
            onPressed: () {
              Get.back();
              onConfirm();
            },
          ),
        ],
      ),
    );
  }

  /// Show grant free trial dialog
  static void showGrantTrialDialog(
    BuildContext context,
    UserModel user,
    Function(int) onConfirm,
  ) {
    final daysController = TextEditingController(text: '7');
    Get.dialog(
      Dialog(
        child: Container(
          width: WebResponsive.isDesktop(context) ? 400 : double.infinity,
          padding: WebSpacing.all(context, factor: 2.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                WebTexts.usersGrantTrial,
                style: WebTextStyles.heading(context),
              ),
              WebSpacing.large(context),
              Text(
                '${WebTexts.usersGrantTrial} ${user.name}',
                style: WebTextStyles.bodyText(context),
              ),
              WebSpacing.medium(context),
              TextField(
                controller: daysController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: WebTexts.usersTrialDays,
                  hintText: '7',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      WebResponsive.radius(context, factor: 1.0),
                    ),
                  ),
                ),
              ),
              WebSpacing.large(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  WebButton(
                    text: WebTexts.usersTrialCancel,
                    onPressed: () => Get.back(),
                    isOutlined: true,
                  ),
                  WebSpacing.horizontalSpacing(context, 0.75),
                  WebButton(
                    text: WebTexts.usersTrialGrant,
                    onPressed: () {
                      final days = int.tryParse(daysController.text) ?? 7;
                      Get.back();
                      onConfirm(days);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Show delete user confirmation dialog
  static void showDeleteDialog(
    BuildContext context,
    UserModel user,
    VoidCallback onConfirm,
  ) {
    Get.dialog(
      AlertDialog(
        title: Text(
          WebTexts.usersDelete,
          style: WebTextStyles.heading(context).copyWith(
            color: AppColors.error,
          ),
        ),
        content: Text(
          '${WebTexts.usersDeleteConfirm} ${user.name}?',
          style: WebTextStyles.bodyText(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(WebTexts.actionCancel),
          ),
          WebButton(
            text: WebTexts.usersDelete,
            onPressed: () {
              Get.back();
              onConfirm();
            },
            backgroundColor: AppColors.error,
          ),
        ],
      ),
    );
  }
}

