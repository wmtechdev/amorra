import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';
import 'package:amorra/core/utils/app_responsive/app_responsive.dart';
import 'package:amorra/core/utils/app_spacing/app_spacing.dart';
import 'package:amorra/presentation/widgets/common/app_checkbox.dart';


/// Profile Setup Topics Section Widget
/// Reusable widget for displaying multiple choice options with checkboxes
class ProfileSetupTopicsSection extends StatelessWidget {
  final List<String> options;
  final RxList<String> selectedOptions;
  final Function(String) onToggle;
  final String? errorText;

  const ProfileSetupTopicsSection({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.onToggle,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;
    
    return Container(
      padding: AppSpacing.symmetric(context, h: 0.02, v: 0.015),
      decoration: BoxDecoration(
        border: Border.all(
          color: hasError ? AppColors.error : AppColors.lightGrey,
          width: hasError ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(
          AppResponsive.radius(context, factor: 1.5),
        ),
      ),
      child: Obx(
        () => Column(
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return Padding(
              padding: EdgeInsets.only(
                bottom: AppResponsive.screenHeight(context) * 0.01,
              ),
              child: AppCheckbox(
                value: isSelected,
                onChanged: (value) => onToggle(option),
                label: option,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

