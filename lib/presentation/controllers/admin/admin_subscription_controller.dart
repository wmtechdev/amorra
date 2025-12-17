import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:amorra/data/models/subscription_model.dart';
import 'package:amorra/data/services/admin_service.dart';
import 'package:amorra/core/constants/app_constants.dart';
import 'package:amorra/presentation/controllers/admin/admin_base_controller.dart';

/// Admin Subscription Controller
/// Handles subscription management operations for admin dashboard
class AdminSubscriptionController extends AdminBaseController {
  final AdminService _adminService = AdminService();

  // State
  final RxList<SubscriptionModel> subscriptions = <SubscriptionModel>[].obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedFilter = 'all'.obs; // all, active, cancelled, expired

  // Filters
  final RxString filterStatus = 'all'.obs;
  final RxString filterPlanName = 'all'.obs;

  // Total count
  final RxInt totalSubscriptions = 0.obs;

  // Analytics
  final RxMap<String, dynamic> subscriptionAnalytics = <String, dynamic>{}.obs;

  // User emails map (userId -> email)
  final RxMap<String, String> userEmails = <String, String>{}.obs;

  // Stream subscription
  StreamSubscription<List<SubscriptionModel>>? _subscriptionsStreamSubscription;

  @override
  void onInit() {
    super.onInit();
    loadSubscriptionAnalytics();
    _setupFilters();
  }

  @override
  void onClose() {
    _subscriptionsStreamSubscription?.cancel();
    super.onClose();
  }

  /// Setup filters and load subscriptions
  void _setupFilters() {
    // Listen to filter changes
    ever(filterStatus, (_) => loadSubscriptions());
    ever(filterPlanName, (_) => loadSubscriptions());
    ever(searchQuery, (_) => _handleSearch());

    // Initial load
    loadSubscriptions();
  }

  /// Load subscriptions with current filters
  void loadSubscriptions() {
    try {
      setLoading(true);

      // Cancel existing stream
      _subscriptionsStreamSubscription?.cancel();

      // Build filters
      String? status;
      if (filterStatus.value != 'all') {
        status = filterStatus.value;
      } else if (selectedFilter.value != 'all') {
        status = selectedFilter.value;
      }

      String? planName;
      if (filterPlanName.value != 'all') {
        planName = filterPlanName.value;
      }

      // Setup stream
      _subscriptionsStreamSubscription = _adminService
          .getSubscriptionsStream(
            status: status,
            planName: planName,
          )
          .listen(
            (subscriptionList) {
              // Apply search filter if any
              if (searchQuery.value.isNotEmpty) {
                final query = searchQuery.value.toLowerCase();
                subscriptions.value = subscriptionList.where((sub) {
                  return sub.id.toLowerCase().contains(query) ||
                      sub.userId.toLowerCase().contains(query) ||
                      (sub.stripeSubscriptionId?.toLowerCase().contains(query) ?? false) ||
                      (sub.stripeCustomerId?.toLowerCase().contains(query) ?? false);
                }).toList();
              } else {
                subscriptions.value = subscriptionList;
              }

              totalSubscriptions.value = subscriptions.length;
              
              // Load user emails for subscriptions
              _loadUserEmails(subscriptionList);
              
              setLoading(false);
            },
            onError: (error) {
              setError(error.toString());
              setLoading(false);
              showError('Failed to load subscriptions', subtitle: error.toString());
            },
          );
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      showError('Failed to load subscriptions', subtitle: e.toString());
    }
  }

  /// Handle search
  void _handleSearch() {
    if (searchQuery.value.isEmpty) {
      loadSubscriptions();
    } else {
      // Filter existing subscriptions
      final query = searchQuery.value.toLowerCase();
      subscriptions.value = subscriptions.where((sub) {
        return sub.id.toLowerCase().contains(query) ||
            sub.userId.toLowerCase().contains(query) ||
            (sub.stripeSubscriptionId?.toLowerCase().contains(query) ?? false) ||
            (sub.stripeCustomerId?.toLowerCase().contains(query) ?? false);
      }).toList();
    }
  }

  /// Update subscription
  Future<bool> updateSubscription(
    String subscriptionId,
    Map<String, dynamic> updates,
  ) async {
    try {
      setLoading(true);
      await _adminService.updateSubscription(subscriptionId, updates);
      setLoading(false);
      showSuccess('Subscription updated successfully');
      loadSubscriptions(); // Refresh list
      return true;
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      showError('Failed to update subscription', subtitle: e.toString());
      return false;
    }
  }

  /// Cancel subscription
  Future<bool> cancelSubscription(String subscriptionId, {String? reason}) async {
    try {
      setLoading(true);
      await _adminService.cancelSubscription(subscriptionId, reason: reason);
      setLoading(false);
      showSuccess('Subscription cancelled successfully');
      loadSubscriptions(); // Refresh list
      loadSubscriptionAnalytics(); // Refresh analytics
      return true;
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      showError('Failed to cancel subscription', subtitle: e.toString());
      return false;
    }
  }

  /// Reactivate subscription
  Future<bool> reactivateSubscription(String subscriptionId) async {
    try {
      setLoading(true);
      await _adminService.reactivateSubscription(subscriptionId);
      setLoading(false);
      showSuccess('Subscription reactivated successfully');
      loadSubscriptions(); // Refresh list
      loadSubscriptionAnalytics(); // Refresh analytics
      return true;
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      showError('Failed to reactivate subscription', subtitle: e.toString());
      return false;
    }
  }

  /// Load subscription analytics
  Future<void> loadSubscriptionAnalytics() async {
    try {
      final analytics = await _adminService.getSubscriptionAnalytics();
      subscriptionAnalytics.value = analytics;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading subscription analytics: $e');
      }
    }
  }

  /// Set filter
  void setFilter(String filter) {
    selectedFilter.value = filter;
    loadSubscriptions();
  }

  /// Load user emails for subscriptions
  Future<void> _loadUserEmails(List<SubscriptionModel> subscriptionList) async {
    try {
      // Get unique user IDs
      final uniqueUserIds = subscriptionList
          .map((sub) => sub.userId)
          .where((userId) => userId.isNotEmpty)
          .toSet()
          .toList();

      // Filter out users we already have emails for
      final userIdsToFetch = uniqueUserIds
          .where((userId) => !userEmails.containsKey(userId))
          .toList();

      if (userIdsToFetch.isEmpty) return;

      // Batch fetch user emails
      for (final userId in userIdsToFetch) {
        try {
          final user = await _adminService.getUserById(userId);
          if (user != null && user.email != null) {
            userEmails[userId] = user.email!;
          } else {
            // Fallback to userId if email not found
            userEmails[userId] = userId;
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error fetching user email for $userId: $e');
          }
          // Fallback to userId on error
          userEmails[userId] = userId;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading user emails: $e');
      }
    }
  }

  /// Get user email by userId
  String getUserEmail(String userId) {
    return userEmails[userId] ?? userId;
  }

  /// Get status badge color
  String getStatusBadgeColor(String status) {
    switch (status) {
      case AppConstants.subscriptionStatusActive:
        return 'green';
      case AppConstants.subscriptionStatusCancelled:
        return 'red';
      case AppConstants.subscriptionStatusExpired:
        return 'orange';
      default:
        return 'gray';
    }
  }
}

