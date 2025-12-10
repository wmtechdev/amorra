import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:lottie/lottie.dart';
import 'package:amorra/core/utils/app_colors/app_colors.dart';
import 'package:amorra/core/utils/app_responsive/app_responsive.dart';
import 'package:amorra/core/utils/app_spacing/app_spacing.dart';
import 'package:amorra/core/utils/app_styles/app_text_styles.dart';

/// App Lottie Message Widget
/// Reusable widget that displays a Lottie animation with a message below it
/// The full screen is blurred when this widget is shown
class AppLottieMessage extends StatelessWidget {
  final String lottiePath;
  final String message;
  final double? lottieWidth;
  final double? lottieHeight;
  final Color? messageColor;

  const AppLottieMessage({
    super.key,
    required this.lottiePath,
    required this.message,
    this.lottieWidth,
    this.lottieHeight,
    this.messageColor,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        color: AppColors.black.withValues(alpha: 0.3),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie Animation
              Lottie.asset(
                lottiePath,
                width: lottieWidth ?? AppResponsive.screenWidth(context) * 0.9,
                height:
                    lottieHeight ?? AppResponsive.screenWidth(context) * 0.9,
                fit: BoxFit.contain,
                repeat: false,
              ),

              // Message Text
              Padding(
                padding: AppSpacing.symmetric(context, h: 0.1, v: 0),
                child: Text(
                  message,
                  style: AppTextStyles.headline(context).copyWith(
                    color: messageColor ?? AppColors.white,
                    fontSize: AppResponsive.scaleSize(context, 24),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
