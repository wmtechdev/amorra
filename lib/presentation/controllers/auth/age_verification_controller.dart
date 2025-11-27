import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../base_controller.dart';
import '../../../core/constants/app_constants.dart';

/// Age Verification Controller
/// Handles age verification logic
class AgeVerificationController extends BaseController {
  final _storage = GetStorage();

  final RxInt age = 0.obs;
  final RxBool isVerified = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkVerificationStatus();
  }

  /// Check if user is already verified
  void checkVerificationStatus() {
    final verified = _storage.read<bool>(AppConstants.storageKeyAgeVerified) ?? false;
    isVerified.value = verified;
  }

  /// Verify age
  Future<bool> verifyAge(int userAge) async {
    try {
      if (userAge < AppConstants.minimumAge) {
        setError(AppConstants.errorAgeVerification);
        showError(AppConstants.errorAgeVerification);
        return false;
      }

      age.value = userAge;
      isVerified.value = true;

      // Save verification status
      await _storage.write(AppConstants.storageKeyAgeVerified, true);
      await _storage.write('user_age', userAge);

      showSuccess(AppConstants.successAgeVerified);
      return true;
    } catch (e) {
      setError(e.toString());
      showError('Verification failed: ${e.toString()}');
      return false;
    }
  }

  /// Get stored age
  int? getStoredAge() {
    return _storage.read<int>('user_age');
  }
}

