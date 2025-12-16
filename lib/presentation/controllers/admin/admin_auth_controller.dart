import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:amorra/data/services/admin_auth_service.dart';
import 'package:amorra/presentation/controllers/base_controller.dart';

/// Admin Auth Controller
/// Handles admin authentication state and operations
class AdminAuthController extends BaseController {
  final AdminAuthService _adminAuthService = AdminAuthService();

  // State
  final RxBool isAuthenticated = false.obs;
  final RxBool isAdmin = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkAuthState();
    _setupAuthListener();
  }

  /// Setup auth state listener
  void _setupAuthListener() {
    _adminAuthService.authStateChanges.listen((user) async {
      isAuthenticated.value = user != null;
      if (user != null) {
        // Check if user is admin
        final adminStatus = await _adminAuthService.isAdmin();
        isAdmin.value = adminStatus;

        if (!adminStatus) {
          // User is not admin, sign them out
          await signOut();
          showError('Access Denied', subtitle: 'This account is not authorized as admin.');
        }
      } else {
        isAdmin.value = false;
      }
    });
  }

  /// Check current auth state
  Future<void> _checkAuthState() async {
    try {
      final user = _adminAuthService.currentAdmin;
      isAuthenticated.value = user != null;

      if (user != null) {
        final adminStatus = await _adminAuthService.isAdmin();
        isAdmin.value = adminStatus;

        if (!adminStatus) {
          await signOut();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error checking auth state: $e');
      }
    }
  }

  /// Sign in admin
  Future<bool> signIn(String email, String password) async {
    try {
      setLoading(true);
      await _adminAuthService.signInAdmin(email, password);

      // Verify admin status
      final adminStatus = await _adminAuthService.isAdmin();
      if (!adminStatus) {
        await signOut();
        showError('Access Denied', subtitle: 'This account is not authorized as admin.');
        return false;
      }

      isAuthenticated.value = true;
      isAdmin.value = true;
      setLoading(false);
      showSuccess('Signed in successfully');
      return true;
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      showError('Sign in failed', subtitle: errorMessage);
      return false;
    }
  }

  /// Sign out admin
  Future<void> signOut() async {
    try {
      setLoading(true);
      await _adminAuthService.signOut();
      isAuthenticated.value = false;
      isAdmin.value = false;
      setLoading(false);
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      showError('Sign out failed', subtitle: e.toString());
    }
  }

  /// Get current admin email
  String? get currentAdminEmail => _adminAuthService.currentAdmin?.email;
}

