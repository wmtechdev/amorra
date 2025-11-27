import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../base_controller.dart';

/// Auth Controller
/// Handles authentication logic and state
class AuthController extends BaseController {
  final AuthRepository _authRepository = AuthRepository();

  // State
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthState();
  }

  /// Check authentication state
  Future<void> checkAuthState() async {
    try {
      setLoading(true);
      final user = await _authRepository.getCurrentUser();
      currentUser.value = user;
      isAuthenticated.value = user != null;
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  /// Sign in with email and password
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      setLoading(true);
      clearError();

      final user = await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      currentUser.value = user;
      isAuthenticated.value = true;
      showSuccess('Welcome back!');

      return true;
    } catch (e) {
      setError(e.toString());
      showError('Sign in failed: ${e.toString()}');
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Sign up with email and password
  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      setLoading(true);
      clearError();

      final user = await _authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );

      currentUser.value = user;
      isAuthenticated.value = true;
      showSuccess('Account created successfully!');

      return true;
    } catch (e) {
      setError(e.toString());
      showError('Sign up failed: ${e.toString()}');
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      setLoading(true);
      await _authRepository.signOut();
      currentUser.value = null;
      isAuthenticated.value = false;
      showSuccess('Signed out successfully');
    } catch (e) {
      setError(e.toString());
      showError('Sign out failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  /// Update user
  Future<void> updateUser(UserModel user) async {
    try {
      setLoading(true);
      await _authRepository.updateUser(user);
      currentUser.value = user;
      showSuccess('Profile updated successfully');
    } catch (e) {
      setError(e.toString());
      showError('Update failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }
}

