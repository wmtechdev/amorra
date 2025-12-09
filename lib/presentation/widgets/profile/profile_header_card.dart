import 'package:flutter/material.dart';
import 'package:amorra/core/utils/app_responsive/app_responsive.dart';
import 'package:amorra/core/utils/app_spacing/app_spacing.dart';
import 'package:amorra/core/utils/app_gradient/app_gradient.dart';
import 'package:amorra/presentation/widgets/common/user_avatar.dart';
import 'profile_name_display.dart';
import 'profile_name_edit_field.dart';

/// Profile Header Card Widget
/// Displays gradient card with avatar and editable name
class ProfileHeaderCard extends StatelessWidget {
  final String userName;
  final int? userAge;
  final bool isEditingName;
  final TextEditingController nameController;
  final VoidCallback onEditTap;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const ProfileHeaderCard({
    super.key,
    required this.userName,
    this.userAge,
    required this.isEditingName,
    required this.nameController,
    required this.onEditTap,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: double.infinity,
      padding: AppSpacing.symmetric(
        context,
        h: 0.04,
        v: isEditingName ? 0.02 : 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppResponsive.radius(context, factor: 2),
        ),
      ).withAppGradient(),
      child: Column(
        children: [
          // Avatar Circle
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: AppResponsive.screenWidth(context) * (isEditingName ? 0.25 : 0.35),
            height: AppResponsive.screenWidth(context) * (isEditingName ? 0.25 : 0.35),
            child: UserAvatar(
              age: userAge,
              size: AppResponsive.screenWidth(context) * (isEditingName ? 0.25 : 0.35),
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // Name Display/Edit with animation
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 0.1),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  )),
                  child: child,
                ),
              );
            },
            child: isEditingName
                ? ProfileNameEditField(
                    key: const ValueKey('edit'),
                    nameController: nameController,
                    onSave: onSave,
                    onCancel: onCancel,
                  )
                : ProfileNameDisplay(
                    key: const ValueKey('display'),
                    userName: userName,
                    onEditTap: onEditTap,
                  ),
          ),
        ],
      ),
    );
  }
}

