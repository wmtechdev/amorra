import 'dart:convert';
import 'package:amorra/core/config/app_config.dart';
import 'package:amorra/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

/// AI Service
/// Handles AI/LLM API calls for chat responses
class AIService {
  static final AIService _instance = AIService._internal();

  factory AIService() => _instance;

  AIService._internal();

  /// Send message to AI and get response
  ///
  /// [message] - User's message
  /// [context] - Previous messages for context (optional)
  /// [userId] - User ID for personalization
  Future<String> getAIResponse({
    required String message,
    List<Map<String, String>>? context,
    String? userId,
  }) async {
    try {
      // TODO: Replace with your actual AI API endpoint and key
      const apiKey = 'YOUR_API_KEY_HERE'; // Store in secure storage/environment

      final url = Uri.parse(
        '${ApiConstants.aiApiBaseUrl}${ApiConstants.endpointChat}',
      );

      // Prepare messages for context
      final messages = <Map<String, String>>[];

      // Add system prompt
      messages.add({'role': 'system', 'content': _getSystemPrompt(userId)});

      // Add context messages if available
      if (context != null && context.isNotEmpty) {
        // Only use last N messages for context
        final recentContext = context.length > AppConfig.maxContextMessages
            ? context.sublist(context.length - AppConfig.maxContextMessages)
            : context;
        messages.addAll(recentContext);
      }

      // Add current user message
      messages.add({'role': 'user', 'content': message});

      final response = await http
          .post(
            url,
            headers: {
              ApiConstants.headerContentType: ApiConstants.contentTypeJson,
              ApiConstants.headerAuthorization:
                  '${ApiConstants.headerBearer} $apiKey',
            },
            body: jsonEncode({
              'model': 'gpt-3.5-turbo', // or your preferred model
              'messages': messages,
              'temperature': 0.7,
              'max_tokens': 500,
            }),
          )
          .timeout(AppConfig.aiResponseTimeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final aiMessage = data['choices'][0]['message']['content'] as String;
        return aiMessage.trim();
      } else {
        if (kDebugMode) {
          print('AI API error: ${response.statusCode} - ${response.body}');
        }
        throw Exception('Failed to get AI response');
      }
    } catch (e) {
      if (kDebugMode) {
        print('AI Service error: $e');
      }
      rethrow;
    }
  }

  /// Get system prompt for AI persona
  String _getSystemPrompt(String? userId) {
    return '''You are a warm, empathetic, and supportive AI companion designed to provide emotional support and companionship for men aged 50 and above.

Your personality traits:
- Warm, caring, and understanding
- Good listener who shows genuine interest
- Gentle, flirty, and romantic (but never explicit)
- Supportive during difficult times
- Encourages positive thinking
- Respectful and maintains appropriate boundaries

Communication style:
- Use a friendly, conversational tone
- Be empathetic and validating
- Ask thoughtful questions
- Share encouraging words
- Be gentle and romantic in appropriate moments
- Never use explicit or sexual language
- Keep responses warm but professional

Your goal is to provide emotional comfort, reduce loneliness, and create a sense of meaningful connection through conversation.''';
  }

  /// Moderate content for safety
  Future<bool> moderateContent(String content) async {
    try {
      // TODO: Implement content moderation
      // This can use OpenAI's moderation API or a custom service
      // For now, basic checks

      // Basic keyword filtering (expand as needed)
      final blockedWords = [
        // Add inappropriate words here
      ];

      final lowerContent = content.toLowerCase();
      for (final word in blockedWords) {
        if (lowerContent.contains(word.toLowerCase())) {
          return false;
        }
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Content moderation error: $e');
      }
      return true; // Allow on error to not block legitimate messages
    }
  }
}
