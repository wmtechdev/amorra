import 'package:amorra/core/utils/app_responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class AppSpacing {
  static EdgeInsets padding(BuildContext context, {double multiplier = 1}) =>
      EdgeInsets.all(MediaQuery.of(context).size.width * 0.03 * multiplier);

  static EdgeInsets all(BuildContext context, {double factor = 1}) =>
      EdgeInsets.all(AppResponsive.screenWidth(context) * 0.02 * factor);

  static EdgeInsets symmetric(
    BuildContext context, {
    double h = 0.04,
    double v = 0.02,
  }) => EdgeInsets.symmetric(
    horizontal: AppResponsive.screenWidth(context) * h,
    vertical: AppResponsive.screenHeight(context) * v,
  );

  static SizedBox vertical(BuildContext context, double factor) =>
      SizedBox(height: AppResponsive.screenHeight(context) * factor);

  static SizedBox horizontal(BuildContext context, double factor) =>
      SizedBox(width: AppResponsive.screenWidth(context) * factor);
}
