import 'package:flutter/material.dart';
import 'package:amorra/data/models/user_model.dart';
import 'package:amorra/core/utils/web/web_responsive/web_responsive.dart';
import 'package:amorra/core/utils/web/web_spacing/web_spacing.dart';
import 'package:amorra/core/utils/web/web_text_styles/web_text_styles.dart';
import 'package:amorra/core/utils/web/web_texts/web_texts.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';

/// User Actions Menu Widget
/// Popup menu for user actions
class UserActionsMenu extends StatelessWidget {
  final UserModel user;
  final VoidCallback onViewDetails;
  final VoidCallback onBlockUnblock;
  final VoidCallback onGrantTrial;
  final VoidCallback onDelete;

  const UserActionsMenu({
    super.key,
    required this.user,
    required this.onViewDetails,
    required this.onBlockUnblock,
    required this.onGrantTrial,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        size: WebResponsive.iconSize(context, factor: 0.8),
        color: AppColors.grey,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.visibility,
                size: WebResponsive.iconSize(context, factor: 0.7),
                color: AppColors.grey,
              ),
              WebSpacing.horizontalSpacing(context, 0.5),
              Text(WebTexts.usersViewDetails),
            ],
          ),
          onTap: onViewDetails,
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                user.isBlocked ? Icons.lock_open : Icons.block,
                size: WebResponsive.iconSize(context, factor: 0.7),
                color: AppColors.grey,
              ),
              WebSpacing.horizontalSpacing(context, 0.5),
              Text(user.isBlocked
                  ? WebTexts.usersUnblock
                  : WebTexts.usersBlock),
            ],
          ),
          onTap: onBlockUnblock,
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.card_giftcard,
                size: WebResponsive.iconSize(context, factor: 0.7),
                color: AppColors.grey,
              ),
              WebSpacing.horizontalSpacing(context, 0.5),
              Text(WebTexts.usersGrantTrial),
            ],
          ),
          onTap: onGrantTrial,
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(
                Icons.delete,
                size: WebResponsive.iconSize(context, factor: 0.7),
                color: AppColors.error,
              ),
              WebSpacing.horizontalSpacing(context, 0.5),
              Text(
                WebTexts.usersDelete,
                style: WebTextStyles.bodyText(context).copyWith(
                  color: AppColors.error,
                ),
              ),
            ],
          ),
          onTap: onDelete,
        ),
      ],
    );
  }
}

