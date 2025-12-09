import 'package:amorra/data/models/base_model.dart';

/// Subscription Model
/// Represents subscription data structure
class SubscriptionModel extends BaseModel {
  final String id;
  final String userId;
  final String status; // 'free', 'active', 'cancelled', 'expired'
  final String? stripeSubscriptionId;
  final String? stripeCustomerId;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? cancelledAt;
  final double? price;
  final String? planName;
  final DateTime createdAt;
  final DateTime? updatedAt;

  SubscriptionModel({
    required this.id,
    required this.userId,
    required this.status,
    this.stripeSubscriptionId,
    this.stripeCustomerId,
    this.startDate,
    this.endDate,
    this.cancelledAt,
    this.price,
    this.planName,
    required this.createdAt,
    this.updatedAt,
  });

  /// Check if subscription is active
  bool get isActive =>
      status == 'active' &&
      (endDate == null || endDate!.isAfter(DateTime.now()));

  /// Create SubscriptionModel from Firestore document
  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      status: json['status'] ?? 'free',
      stripeSubscriptionId: json['stripeSubscriptionId'],
      stripeCustomerId: json['stripeCustomerId'],
      startDate: json['startDate']?.toDate(),
      endDate: json['endDate']?.toDate(),
      cancelledAt: json['cancelledAt']?.toDate(),
      price: json['price']?.toDouble(),
      planName: json['planName'],
      createdAt: json['createdAt']?.toDate() ?? DateTime.now(),
      updatedAt: json['updatedAt']?.toDate(),
    );
  }

  /// Convert SubscriptionModel to JSON for Firestore
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status,
      'stripeSubscriptionId': stripeSubscriptionId,
      'stripeCustomerId': stripeCustomerId,
      'startDate': startDate,
      'endDate': endDate,
      'cancelledAt': cancelledAt,
      'price': price,
      'planName': planName,
      'createdAt': createdAt,
      'updatedAt': updatedAt ?? DateTime.now(),
    };
  }

  /// Create a copy with updated fields
  SubscriptionModel copyWith({
    String? id,
    String? userId,
    String? status,
    String? stripeSubscriptionId,
    String? stripeCustomerId,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? cancelledAt,
    double? price,
    String? planName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      stripeSubscriptionId: stripeSubscriptionId ?? this.stripeSubscriptionId,
      stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      price: price ?? this.price,
      planName: planName ?? this.planName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return SubscriptionModel.fromJson(json);
  }
}
