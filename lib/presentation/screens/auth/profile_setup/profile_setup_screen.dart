import 'package:amorra/presentation/controllers/auth/profile_setup/profile_setup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:amorra/presentation/widgets/common/app_dots_indicator.dart';
import 'package:amorra/presentation/widgets/auth/auth_main/auth_header.dart';
import 'package:amorra/presentation/widgets/auth/profile_setup/profile_setup_form_content.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';
import 'package:amorra/core/utils/app_spacing/app_spacing.dart';
import 'package:amorra/core/utils/app_texts/app_texts.dart';

/// Profile Setup Screen
/// Collects user preferences after age verification
/// Mandatory screen - prevents back navigation
class ProfileSetupScreen extends GetView<ProfileSetupController> {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // Prevent back navigation - user must complete profile setup
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: SafeArea(
          child: Column(
            children: [
              // Step Indicator (Step 2 of 5) - Full width, equally split
              // Combined steps: Age Verification (1), Profile Setup (2), Onboarding (3-5)
              AppDotsIndicator(
                totalPages: 5,
                currentPage: 1,
                // Step 2 (Profile Setup)
                fullWidth: true,
                activeColor: AppColors.primary,
                // Completed steps
                inactiveColor: AppColors.secondary, // Remaining steps
              ),

              // Header
              Padding(
                padding: AppSpacing.symmetric(
                  context,
                  h: 0.04,
                  v: 0.02,
                ).copyWith(bottom: 0),
                child: AuthHeader(
                  title: AppTexts.profileSetupTitle,
                  subtitle: AppTexts.profileSetupSubtitle,
                ),
              ),

              Expanded(
                child: ProfileSetupFormContent(
                  showSaveButton: true,
                  onSave: controller.savePreferences,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
