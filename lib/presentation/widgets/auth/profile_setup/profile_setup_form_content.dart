import 'package:amorra/presentation/controllers/auth/profile_setup/profile_setup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amorra/presentation/widgets/common/app_large_button.dart';
import 'package:amorra/presentation/widgets/common/app_text_field_error_message.dart';
import 'package:amorra/presentation/widgets/auth/profile_setup/profile_setup_form_section.dart';
import 'package:amorra/presentation/widgets/auth/profile_setup/profile_setup_dropdown_field.dart';
import 'package:amorra/presentation/widgets/auth/profile_setup/profile_setup_topics_section.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';
import 'package:amorra/core/utils/app_spacing/app_spacing.dart';
import 'package:amorra/core/utils/app_texts/app_texts.dart';

/// Profile Setup Form Content Widget
/// Reusable form content that can be used in ProfileSetupScreen or bottom sheets
class ProfileSetupFormContent extends GetView<ProfileSetupController> {
  final bool showSaveButton;
  final VoidCallback? onSave;

  const ProfileSetupFormContent({
    super.key,
    this.showSaveButton = true,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.symmetric(
        context,
        h: 0.04,
        v: 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Conversation Tone
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSetupFormSection(
                  label: AppTexts.conversationToneLabel,
                  field: ProfileSetupDropdownField(
                    value: controller.selectedTone.value.isEmpty
                        ? null
                        : controller.selectedTone.value,
                    items: controller.toneOptions,
                    onChanged: controller.updateTone,
                    hint: AppTexts.conversationToneHint,
                    errorText: controller.toneError.value,
                  ),
                ),
                // Error message
                AppTextFieldErrorMessage(
                  errorText: controller.toneError.value,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // Sexual Orientation
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSetupFormSection(
                  label: AppTexts.sexualOrientationLabel,
                  field: ProfileSetupDropdownField(
                    value: controller.selectedSexualOrientation.value.isEmpty
                        ? null
                        : controller.selectedSexualOrientation.value,
                    items: controller.sexualOrientationOptions,
                    onChanged: controller.updateSexualOrientation,
                    hint: AppTexts.sexualOrientationHint,
                    errorText: controller.sexualOrientationError.value,
                  ),
                ),
                // Error message
                AppTextFieldErrorMessage(
                  errorText: controller.sexualOrientationError.value,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // Topics to Avoid
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSetupFormSection(
                  label: AppTexts.topicsToAvoidLabel,
                  hint: AppTexts.topicsToAvoidHint,
                  field: ProfileSetupTopicsSection(
                    options: controller.topicsToAvoidOptions,
                    selectedOptions: controller.selectedTopicsToAvoid,
                    onToggle: controller.toggleTopicToAvoid,
                    errorText: controller.topicsToAvoidError.value,
                  ),
                ),
                // Error message
                AppTextFieldErrorMessage(
                  errorText: controller.topicsToAvoidError.value,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // Biggest Challenge
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSetupFormSection(
                  label: AppTexts.biggestChallengeLabel,
                  hint: AppTexts.biggestChallengeHint,
                  field: ProfileSetupTopicsSection(
                    options: controller.biggestChallengeOptions,
                    selectedOptions: controller.selectedBiggestChallenge,
                    onToggle: controller.toggleBiggestChallenge,
                    errorText: controller.biggestChallengeError.value,
                  ),
                ),
                // Error message
                AppTextFieldErrorMessage(
                  errorText: controller.biggestChallengeError.value,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // Support Type
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSetupFormSection(
                  label: AppTexts.supportTypeLabel,
                  field: ProfileSetupDropdownField(
                    value: controller.selectedSupportType.value.isEmpty
                        ? null
                        : controller.selectedSupportType.value,
                    items: controller.supportTypeOptions,
                    onChanged: controller.updateSupportType,
                    hint: AppTexts.supportTypeHint,
                    errorText: controller.supportTypeError.value,
                  ),
                ),
                // Error message
                AppTextFieldErrorMessage(
                  errorText: controller.supportTypeError.value,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // Relationship Status
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSetupFormSection(
                  label: AppTexts.relationshipStatusLabel,
                  field: ProfileSetupDropdownField(
                    value: controller.selectedRelationshipStatus.value.isEmpty
                        ? null
                        : controller.selectedRelationshipStatus.value,
                    items: controller.relationshipStatusOptions,
                    onChanged: controller.updateRelationshipStatus,
                    hint: AppTexts.relationshipStatusHint,
                    errorText: controller.relationshipStatusError.value,
                  ),
                ),
                // Error message
                AppTextFieldErrorMessage(
                  errorText: controller.relationshipStatusError.value,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // Daily Routine
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSetupFormSection(
                  label: AppTexts.dailyRoutineLabel,
                  field: ProfileSetupDropdownField(
                    value: controller.selectedDailyRoutine.value.isEmpty
                        ? null
                        : controller.selectedDailyRoutine.value,
                    items: controller.dailyRoutineOptions,
                    onChanged: controller.updateDailyRoutine,
                    hint: AppTexts.dailyRoutineHint,
                    errorText: controller.dailyRoutineError.value,
                  ),
                ),
                // Error message
                AppTextFieldErrorMessage(
                  errorText: controller.dailyRoutineError.value,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // Interested In
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSetupFormSection(
                  label: AppTexts.interestedInLabel,
                  field: ProfileSetupDropdownField(
                    value: controller.selectedInterestedIn.value.isEmpty
                        ? null
                        : controller.selectedInterestedIn.value,
                    items: controller.interestedInOptions,
                    onChanged: controller.updateInterestedIn,
                    hint: AppTexts.interestedInHint,
                    errorText: controller.interestedInError.value,
                  ),
                ),
                // Error message
                AppTextFieldErrorMessage(
                  errorText: controller.interestedInError.value,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // AI Communication Style
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSetupFormSection(
                  label: AppTexts.aiCommunicationLabel,
                  field: ProfileSetupDropdownField(
                    value: controller.selectedAiCommunication.value.isEmpty
                        ? null
                        : controller.selectedAiCommunication.value,
                    items: controller.aiCommunicationOptions,
                    onChanged: controller.updateAiCommunication,
                    hint: AppTexts.aiCommunicationHint,
                    errorText: controller.aiCommunicationError.value,
                  ),
                ),
                // Error message
                AppTextFieldErrorMessage(
                  errorText: controller.aiCommunicationError.value,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // AI Tools Familiarity
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSetupFormSection(
                  label: AppTexts.aiToolsFamiliarityLabel,
                  field: ProfileSetupDropdownField(
                    value: controller.selectedAiToolsFamiliarity.value.isEmpty
                        ? null
                        : controller.selectedAiToolsFamiliarity.value,
                    items: controller.aiToolsFamiliarityOptions,
                    onChanged: controller.updateAiToolsFamiliarity,
                    hint: AppTexts.aiToolsFamiliarityHint,
                    errorText: controller.aiToolsFamiliarityError.value,
                  ),
                ),
                // Error message
                AppTextFieldErrorMessage(
                  errorText: controller.aiToolsFamiliarityError.value,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // AI Honesty Preference
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSetupFormSection(
                  label: AppTexts.aiHonestyLabel,
                  field: ProfileSetupDropdownField(
                    value: controller.selectedAiHonesty.value.isEmpty
                        ? null
                        : controller.selectedAiHonesty.value,
                    items: controller.aiHonestyOptions,
                    onChanged: controller.updateAiHonesty,
                    hint: AppTexts.aiHonestyHint,
                    errorText: controller.aiHonestyError.value,
                  ),
                ),
                // Error message
                AppTextFieldErrorMessage(
                  errorText: controller.aiHonestyError.value,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // Stress Response
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSetupFormSection(
                  label: AppTexts.stressResponseLabel,
                  field: ProfileSetupDropdownField(
                    value: controller.selectedStressResponse.value.isEmpty
                        ? null
                        : controller.selectedStressResponse.value,
                    items: controller.stressResponseOptions,
                    onChanged: controller.updateStressResponse,
                    hint: AppTexts.stressResponseHint,
                    errorText: controller.stressResponseError.value,
                  ),
                ),
                // Error message
                AppTextFieldErrorMessage(
                  errorText: controller.stressResponseError.value,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // Time Dedication
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSetupFormSection(
                  label: AppTexts.timeDedicationLabel,
                  field: ProfileSetupDropdownField(
                    value: controller.selectedTimeDedication.value.isEmpty
                        ? null
                        : controller.selectedTimeDedication.value,
                    items: controller.timeDedicationOptions,
                    onChanged: controller.updateTimeDedication,
                    hint: AppTexts.timeDedicationHint,
                    errorText: controller.timeDedicationError.value,
                  ),
                ),
                // Error message
                AppTextFieldErrorMessage(
                  errorText: controller.timeDedicationError.value,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.02),

          // Save Button
          if (showSaveButton)
            Obx(
              () => AppLargeButton(
                text: AppTexts.profileSetupSaveButton,
                onPressed: onSave ?? controller.updatePreferences,
                isLoading: controller.isLoading.value,
              ),
            ),
          AppSpacing.vertical(context, 0.02),
        ],
      ),
    );
  }
}

