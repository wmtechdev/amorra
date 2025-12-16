import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';
import 'package:amorra/core/utils/app_responsive/app_responsive.dart';
import 'package:amorra/core/utils/app_spacing/app_spacing.dart';
import 'package:amorra/core/utils/app_styles/app_text_styles.dart';
import 'package:amorra/core/utils/app_texts/app_texts.dart';
import '../../widgets/common/app_large_button.dart';

/// Subscription Plan Action Widget
/// Displays action button or current plan indicator
class SubscriptionPlanAction extends StatelessWidget {
  final bool isCurrentPlan;
  final bool isPremium;
  final VoidCallback? onSelect;
  final VoidCallback? onCancel;

  const SubscriptionPlanAction({
    super.key,
    required this.isCurrentPlan,
    this.isPremium = false,
    this.onSelect,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02).copyWith(top: 0),
      child: isCurrentPlan
          ? Column(
              children: [
                // Current Plan Indicator
                Container(
                  padding: AppSpacing.symmetric(context, h: 0.04, v: 0.01),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(
                      AppResponsive.radius(context, factor: 1.5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.tick_circle,
                        size: AppResponsive.iconSize(context),
                        color: AppColors.success,
                      ),
                      AppSpacing.horizontal(context, 0.02),
                      Text(
                        AppTexts.subscriptionCurrentPlan,
                        style: AppTextStyles.bodyText(context).copyWith(
                          color: AppColors.black,
                          fontSize: AppResponsive.scaleSize(context, 16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Cancel Subscription Button (only for premium plans)
                if (isPremium && onCancel != null) ...[
                  AppSpacing.vertical(context, 0.01),
                  AppLargeButton(
                    text: AppTexts.subscriptionCancelPlan,
                    onPressed: onCancel,
                    backgroundColor: AppColors.error,
                    textColor: AppColors.white,
                  ),
                ],
              ],
            )
          : isPremium
          ? AppLargeButton(
              text: AppTexts.subscriptionSelectPlan,
              onPressed: onSelect,
            )
          : const SizedBox.shrink(),
    );
  }
}
