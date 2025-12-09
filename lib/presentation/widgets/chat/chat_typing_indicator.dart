import 'package:flutter/material.dart';
import 'dart:async';
import 'package:amorra/core/utils/app_colors/app_colors.dart';
import 'package:amorra/core/utils/app_responsive/app_responsive.dart';

/// Chat Typing Indicator Widget
/// Animated dots showing AI is typing
class ChatTypingIndicator extends StatefulWidget {
  const ChatTypingIndicator({super.key});

  @override
  State<ChatTypingIndicator> createState() => _ChatTypingIndicatorState();
}

class _ChatTypingIndicatorState extends State<ChatTypingIndicator>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  int _dotIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _dotIndex = (_dotIndex + 1) % 3;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppResponsive.screenWidth(context) * 0.01,
          ),
          width: AppResponsive.scaleSize(context, 8),
          height: AppResponsive.scaleSize(context, 8),
          decoration: BoxDecoration(
            color: _dotIndex == index
                ? AppColors.white
                : AppColors.white.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}

