import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amorra/data/models/subscription_model.dart';
import 'package:amorra/presentation/widgets/admin_web/common/web_button.dart';
import 'package:amorra/core/utils/web/web_responsive/web_responsive.dart';
import 'package:amorra/core/utils/web/web_spacing/web_spacing.dart';
import 'package:amorra/core/utils/web/web_text_styles/web_text_styles.dart';
import 'package:amorra/core/utils/web/web_texts/web_texts.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';

/// Subscription Action Dialogs
/// Collection of dialogs for subscription actions
class SubscriptionActionDialogs {
  /// Show cancel subscription dialog
  static void showCancelDialog(
    BuildContext context,
    SubscriptionModel subscription,
    Function(String?) onConfirm,
  ) {
    final reasonController = TextEditingController();
    Get.dialog(
      Dialog(
        child: Container(
          width: WebResponsive.isDesktop(context) ? 500 : double.infinity,
          padding: WebSpacing.all(context, factor: 2.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                WebTexts.subscriptionsCancel,
                style: WebTextStyles.heading(context),
              ),
              WebSpacing.large(context),
              Text(
                WebTexts.subscriptionsCancelConfirm,
                style: WebTextStyles.bodyText(context),
              ),
              WebSpacing.medium(context),
              TextField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: WebTexts.subscriptionsCancelReason,
                  hintText: WebTexts.subscriptionsCancelReasonHint,
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
                    text: WebTexts.actionCancel,
                    onPressed: () => Get.back(),
                    isOutlined: true,
                  ),
                  WebSpacing.horizontalSpacing(context, 0.75),
                  WebButton(
                    text: WebTexts.subscriptionsConfirmCancel,
                    onPressed: () {
                      Get.back();
                      onConfirm(reasonController.text.isEmpty
                          ? null
                          : reasonController.text);
                    },
                    backgroundColor: AppColors.error,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Show reactivate subscription dialog
  static void showReactivateDialog(
    BuildContext context,
    SubscriptionModel subscription,
    VoidCallback onConfirm,
  ) {
    Get.dialog(
      AlertDialog(
        title: Text(
          WebTexts.subscriptionsReactivate,
          style: WebTextStyles.heading(context),
        ),
        content: Text(
          '${WebTexts.subscriptionsReactivateConfirm} ${subscription.userId}?',
          style: WebTextStyles.bodyText(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(WebTexts.actionCancel),
          ),
          WebButton(
            text: WebTexts.subscriptionsReactivate,
            onPressed: () {
              Get.back();
              onConfirm();
            },
            backgroundColor: AppColors.success,
          ),
        ],
      ),
    );
  }
}

