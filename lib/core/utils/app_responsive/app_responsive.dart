import 'package:flutter/material.dart';

class AppResponsive {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool isMobile(BuildContext context) => screenWidth(context) < 600;

  static bool isTablet(BuildContext context) =>
      screenWidth(context) >= 600 && screenWidth(context) < 1024;

  static bool isDesktop(BuildContext context) => screenWidth(context) >= 1024;

  static double scaleSize(BuildContext context, double size) {
    return size * (screenWidth(context) / 375);
  }

  static double iconSize(BuildContext context, {double factor = 1}) {
    return screenWidth(context) * 0.05 * factor;
  }

  static double radius(BuildContext context, {double factor = 1}) =>
      screenWidth(context) * 0.02 * factor;
}
