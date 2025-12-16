import 'package:flutter/material.dart';
import 'package:amorra/core/utils/web/web_responsive/web_responsive.dart';
import 'package:amorra/core/utils/web/web_spacing/web_spacing.dart';
import 'package:amorra/core/utils/web/web_text_styles/web_text_styles.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';
import 'package:amorra/core/utils/web/web_texts/web_texts.dart';

/// Web Search Bar Widget
/// Desktop-optimized search bar for admin dashboard
class WebSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final TextEditingController? controller;

  const WebSearchBar({
    super.key,
    required this.hintText,
    this.onChanged,
    this.onFilterTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          WebResponsive.radius(context, factor: 1.0),
        ),
        border: Border.all(
          color: AppColors.lightGrey,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: WebTextStyles.bodyText(context),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: WebTextStyles.hintText(context),
                border: InputBorder.none,
                contentPadding: WebSpacing.inputField(context),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.grey,
                  size: WebResponsive.iconSize(context, factor: 0.8),
                ),
              ),
            ),
          ),
          if (onFilterTap != null) ...[
            Container(
              width: 1,
              height: WebResponsive.screenHeight(context) * 0.04,
              color: AppColors.lightGrey,
            ),
            IconButton(
              icon: Icon(
                Icons.filter_list,
                color: AppColors.grey,
                size: WebResponsive.iconSize(context, factor: 0.9),
              ),
              onPressed: onFilterTap,
              tooltip: WebTexts.actionFilter,
            ),
          ],
        ],
      ),
    );
  }
}

