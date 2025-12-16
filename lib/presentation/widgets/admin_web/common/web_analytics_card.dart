import 'package:flutter/material.dart';
import 'package:amorra/core/utils/web/web_responsive/web_responsive.dart';
import 'package:amorra/core/utils/web/web_spacing/web_spacing.dart';
import 'package:amorra/core/utils/web/web_text_styles/web_text_styles.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';

/// Web Analytics Card Widget
/// Desktop-optimized analytics card for dashboard
class WebAnalyticsCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData? icon;

  const WebAnalyticsCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: WebSpacing.card(context),
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
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: EdgeInsets.all(
                    WebResponsive.isDesktop(context) ? 10 : 8,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      WebResponsive.radius(context, factor: 0.5),
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: WebResponsive.iconSize(context, factor: 0.8),
                  ),
                ),
                WebSpacing.horizontalSpacing(context, 0.75),
              ],
              Expanded(
                child: Text(
                  label,
                  style: WebTextStyles.label(context).copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
            ],
          ),
          WebSpacing.medium(context),
          Text(
            value,
            style: WebTextStyles.heading(context).copyWith(
              color: color,
              fontSize: WebResponsive.fontSize(context, factor: 1.75),
            ),
          ),
        ],
      ),
    );
  }
}

