import 'package:flutter/foundation.dart';
import '../../data/models/chat_message_model.dart';
import '../../data/repositories/chat_repository.dart';
import '../../data/services/ai_service.dart';
import '../../core/config/app_config.dart';
import '../../core/constants/app_constants.dart';

/// Chat Service
/// Business logic for chat operations
class ChatService {
  final ChatRepository _chatRepository = ChatRepository();
  final AIService _aiService = AIService();

  /// Send message and get AI response
  Future<ChatMessageModel> sendMessage({
    required String userId,
    required String message,
  }) async {
    try {
      // Validate message
      if (message.trim().isEmpty) {
        throw Exception('Message cannot be empty');
      }

      if (message.length > AppConfig.maxMessageLength) {
        throw Exception('Message is too long');
      }

      // Moderate content
      final isSafe = await _aiService.moderateContent(message);
      if (!isSafe) {
        throw Exception('Message contains inappropriate content');
      }

      // Create user message
      final userMessage = ChatMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        message: message.trim(),
        type: AppConstants.messageTypeUser,
        timestamp: DateTime.now(),
      );

      // Save user message
      await _chatRepository.saveMessage(userMessage);

      // Get recent messages for context
      final recentMessages = await _chatRepository.getRecentMessages(
        userId,
        AppConfig.maxContextMessages,
      );

      // Prepare context for AI
      final context = recentMessages.map((msg) {
        return {
          'role': msg.type == AppConstants.messageTypeUser ? 'user' : 'assistant',
          'content': msg.message,
        };
      }).toList();

      // Get AI response
      final aiResponseText = await _aiService.getAIResponse(
        message: message.trim(),
        context: context,
        userId: userId,
      );

      // Create AI message
      final aiMessage = ChatMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        message: aiResponseText,
        type: AppConstants.messageTypeAI,
        timestamp: DateTime.now(),
      );

      // Save AI message
      await _chatRepository.saveMessage(aiMessage);

      return aiMessage;
    } catch (e) {
      if (kDebugMode) {
        print('Send message error: $e');
      }
      rethrow;
    }
  }

  /// Get messages stream
  Stream<List<ChatMessageModel>> getMessagesStream(String userId) {
    return _chatRepository.getMessagesStream(userId);
  }

  /// Get recent messages
  Future<List<ChatMessageModel>> getRecentMessages(
    String userId,
    int limit,
  ) async {
    return await _chatRepository.getRecentMessages(userId, limit);
  }
}

