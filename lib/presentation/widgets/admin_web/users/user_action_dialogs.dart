import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amorra/data/models/user_model.dart';
import 'package:amorra/presentation/widgets/admin_web/common/web_button.dart';
import 'package:amorra/core/utils/web/web_text_styles/web_text_styles.dart';
import 'package:amorra/core/utils/web/web_texts/web_texts.dart';

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

}

