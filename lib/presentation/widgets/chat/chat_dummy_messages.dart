import 'package:flutter/material.dart';
import 'package:amorra/core/utils/app_responsive/app_responsive.dart';
import 'package:amorra/core/constants/app_constants.dart';
import 'package:amorra/presentation/widgets/chat/chat_message_bubble.dart';

/// Chat Dummy Messages Widget
/// Shows static dummy messages for preview purposes
class ChatDummyMessages extends StatelessWidget {
  const ChatDummyMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Column(
      children: [
        // User message
        Padding(
          padding: EdgeInsets.only(
            bottom: AppResponsive.screenHeight(context) * 0.015,
          ),
          child: ChatMessageBubble(
            message: "Hey, how are you doing today?",
            type: AppConstants.messageTypeUser,
            timestamp: now.subtract(const Duration(minutes: 2)),
            showTimestamp: true,
            userAge: 25, // Dummy age for preview
          ),
        ),

        // AI message
        Padding(
          padding: EdgeInsets.only(
            bottom: AppResponsive.screenHeight(context) * 0.015,
          ),
          child: ChatMessageBubble(
            message:
                "I'm doing great, thank you for asking! How can I help you today?",
            type: AppConstants.messageTypeAI,
            timestamp: now.subtract(const Duration(minutes: 1)),
            showTimestamp: true,
          ),
        ),
      ],
    );
  }
}
