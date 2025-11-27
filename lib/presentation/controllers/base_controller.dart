import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

/// Base Controller
/// Base class for all controllers with common functionality
abstract class BaseController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  /// Set loading state
  void setLoading(bool value) {
    isLoading.value = value;
  }

  /// Set error message
  void setError(String message) {
    errorMessage.value = message;
    if (kDebugMode) {
      print('Controller Error: $message');
    }
  }

  /// Clear error
  void clearError() {
    errorMessage.value = '';
  }

  /// Show error snackbar
  void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  /// Show success snackbar
  void showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void onClose() {
    clearError();
    super.onClose();
  }
}

