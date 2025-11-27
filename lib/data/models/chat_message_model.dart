import 'base_model.dart';

/// Chat Message Model
/// Represents a chat message structure
class ChatMessageModel extends BaseModel {
  final String id;
  final String userId;
  final String message;
  final String type; // 'user' or 'ai' or 'system'
  final DateTime timestamp;
  final bool isTyping;
  final Map<String, dynamic>? metadata;

  ChatMessageModel({
    required this.id,
    required this.userId,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isTyping = false,
    this.metadata,
  });

  /// Create ChatMessageModel from Firestore document
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? 'user',
      timestamp: json['timestamp']?.toDate() ?? DateTime.now(),
      isTyping: json['isTyping'] ?? false,
      metadata: json['metadata'],
    );
  }

  /// Convert ChatMessageModel to JSON for Firestore
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'message': message,
      'type': type,
      'timestamp': timestamp,
      'isTyping': isTyping,
      'metadata': metadata,
    };
  }

  /// Create a copy with updated fields
  ChatMessageModel copyWith({
    String? id,
    String? userId,
    String? message,
    String? type,
    DateTime? timestamp,
    bool? isTyping,
    Map<String, dynamic>? metadata,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isTyping: isTyping ?? this.isTyping,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return ChatMessageModel.fromJson(json);
  }
}

