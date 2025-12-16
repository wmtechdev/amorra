import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:amorra/data/models/user_model.dart';
import 'package:amorra/data/services/admin_service.dart';
import 'package:amorra/presentation/controllers/base_controller.dart';

/// Admin User Controller
/// Handles user management operations for admin dashboard
class AdminUserController extends BaseController {
  final AdminService _adminService = AdminService();

  // State
  final RxList<UserModel> users = <UserModel>[].obs;
  final Rx<UserModel?> selectedUser = Rx<UserModel?>(null);
  final RxString searchQuery = ''.obs;
  final RxString selectedFilter = 'all'.obs; // all, blocked, active, subscribed, free

  // Filters
  final RxBool filterBlocked = false.obs;
  final RxString filterSubscriptionStatus = 'all'.obs;
  final RxBool filterOnboardingCompleted = false.obs;
  final RxBool filterAgeVerified = false.obs;

  // Pagination
  final RxInt currentPage = 0.obs;
  final RxInt itemsPerPage = 25.obs;
  final RxInt totalUsers = 0.obs;

  // Analytics
  final RxMap<String, dynamic> userAnalytics = <String, dynamic>{}.obs;

  // Stream subscription
  StreamSubscription<List<UserModel>>? _usersStreamSubscription;

  @override
  void onInit() {
    super.onInit();
    loadUserAnalytics();
    _setupFilters();
  }

  @override
  void onClose() {
    _usersStreamSubscription?.cancel();
    super.onClose();
  }

  /// Setup filters and load users
  void _setupFilters() {
    // Listen to filter changes
    ever(filterBlocked, (_) => loadUsers());
    ever(filterSubscriptionStatus, (_) => loadUsers());
    ever(filterOnboardingCompleted, (_) => loadUsers());
    ever(filterAgeVerified, (_) => loadUsers());
    ever(searchQuery, (_) => _handleSearch());

    // Initial load
    loadUsers();
  }

  /// Load users with current filters
  void loadUsers() {
    try {
      setLoading(true);

      // Cancel existing stream
      _usersStreamSubscription?.cancel();

      // Build filters
      bool? isBlocked;
      if (filterBlocked.value) {
        isBlocked = true;
      } else if (selectedFilter.value == 'blocked') {
        isBlocked = true;
      } else if (selectedFilter.value == 'active') {
        isBlocked = false;
      }

      String? subscriptionStatus;
      if (filterSubscriptionStatus.value != 'all') {
        subscriptionStatus = filterSubscriptionStatus.value;
      } else if (selectedFilter.value == 'subscribed') {
        subscriptionStatus = 'active';
      } else if (selectedFilter.value == 'free') {
        subscriptionStatus = 'free';
      }

      bool? isOnboardingCompleted;
      if (filterOnboardingCompleted.value) {
        isOnboardingCompleted = true;
      }

      bool? isAgeVerified;
      if (filterAgeVerified.value) {
        isAgeVerified = true;
      }

      // Setup stream
      _usersStreamSubscription = _adminService
          .getUsersStream(
            isBlocked: isBlocked,
            subscriptionStatus: subscriptionStatus,
            isOnboardingCompleted: isOnboardingCompleted,
            isAgeVerified: isAgeVerified,
          )
          .listen(
            (userList) {
              // Apply search filter if any
              if (searchQuery.value.isNotEmpty) {
                final query = searchQuery.value.toLowerCase();
                users.value = userList.where((user) {
                  return user.name.toLowerCase().contains(query) ||
                      (user.email?.toLowerCase().contains(query) ?? false) ||
                      user.id.toLowerCase().contains(query);
                }).toList();
              } else {
                users.value = userList;
              }

              totalUsers.value = users.length;
              setLoading(false);
            },
            onError: (error) {
              setError(error.toString());
              setLoading(false);
              showError('Failed to load users', subtitle: error.toString());
            },
          );
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      showError('Failed to load users', subtitle: e.toString());
    }
  }

  /// Handle search
  void _handleSearch() {
    if (searchQuery.value.isEmpty) {
      loadUsers();
    } else {
      // Filter existing users
      final query = searchQuery.value.toLowerCase();
      users.value = users.where((user) {
        return user.name.toLowerCase().contains(query) ||
            (user.email?.toLowerCase().contains(query) ?? false) ||
            user.id.toLowerCase().contains(query);
      }).toList();
    }
  }

  /// Search users
  Future<void> searchUsers(String query) async {
    try {
      if (query.isEmpty) {
        loadUsers();
        return;
      }

      setLoading(true);
      final results = await _adminService.searchUsers(query);
      users.value = results;
      totalUsers.value = results.length;
      setLoading(false);
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      showError('Search failed', subtitle: e.toString());
    }
  }

  /// Select user
  void selectUser(UserModel user) {
    selectedUser.value = user;
  }

  /// Clear selected user
  void clearSelectedUser() {
    selectedUser.value = null;
  }

  /// Update user
  Future<bool> updateUser(String userId, Map<String, dynamic> updates) async {
    try {
      setLoading(true);
      await _adminService.updateUser(userId, updates);
      setLoading(false);
      showSuccess('User updated successfully');
      loadUsers(); // Refresh list
      return true;
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      showError('Failed to update user', subtitle: e.toString());
      return false;
    }
  }

  /// Block user
  Future<bool> blockUser(String userId, {String? reason}) async {
    try {
      setLoading(true);
      await _adminService.blockUser(userId, reason: reason);
      setLoading(false);
      showSuccess('User blocked successfully');
      loadUsers(); // Refresh list
      return true;
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      showError('Failed to block user', subtitle: e.toString());
      return false;
    }
  }

  /// Unblock user
  Future<bool> unblockUser(String userId) async {
    try {
      setLoading(true);
      await _adminService.unblockUser(userId);
      setLoading(false);
      showSuccess('User unblocked successfully');
      loadUsers(); // Refresh list
      return true;
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      showError('Failed to unblock user', subtitle: e.toString());
      return false;
    }
  }

  /// Delete user
  Future<bool> deleteUser(String userId) async {
    try {
      setLoading(true);
      await _adminService.deleteUser(userId);
      setLoading(false);
      showSuccess('User deleted successfully');
      loadUsers(); // Refresh list
      return true;
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      showError('Failed to delete user', subtitle: e.toString());
      return false;
    }
  }

  /// Grant free trial
  Future<bool> grantFreeTrial(String userId, {int days = 7}) async {
    try {
      setLoading(true);
      await _adminService.grantFreeTrial(userId, days: days);
      setLoading(false);
      showSuccess('Free trial granted successfully');
      loadUsers(); // Refresh list
      return true;
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      showError('Failed to grant free trial', subtitle: e.toString());
      return false;
    }
  }

  /// Load user analytics
  Future<void> loadUserAnalytics() async {
    try {
      final analytics = await _adminService.getUserAnalytics();
      userAnalytics.value = analytics;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading user analytics: $e');
      }
    }
  }

  /// Set filter
  void setFilter(String filter) {
    selectedFilter.value = filter;
    loadUsers();
  }

  /// Clear filters
  void clearFilters() {
    filterBlocked.value = false;
    filterSubscriptionStatus.value = 'all';
    filterOnboardingCompleted.value = false;
    filterAgeVerified.value = false;
    searchQuery.value = '';
    selectedFilter.value = 'all';
    loadUsers();
  }

  /// Get paginated users
  List<UserModel> get paginatedUsers {
    final start = currentPage.value * itemsPerPage.value;
    final end = (start + itemsPerPage.value).clamp(0, users.length);
    return users.sublist(start.clamp(0, users.length), end);
  }

  /// Go to next page
  void nextPage() {
    if ((currentPage.value + 1) * itemsPerPage.value < users.length) {
      currentPage.value++;
    }
  }

  /// Go to previous page
  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  /// Set items per page
  void setItemsPerPage(int items) {
    itemsPerPage.value = items;
    currentPage.value = 0; // Reset to first page
  }
}

