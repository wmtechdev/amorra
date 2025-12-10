import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:amorra/core/config/routes.dart';
import 'package:amorra/core/utils/app_texts/app_texts.dart';
import 'package:amorra/data/services/firebase_service.dart';
import 'package:amorra/core/constants/app_constants.dart';
import 'package:amorra/presentation/controllers/base_controller.dart';


/// Profile Setup Controller
/// Handles profile setup form state and validation
class ProfileSetupController extends BaseController {
  final FirebaseService _firebaseService = FirebaseService();
  final _storage = GetStorage();

  // Animation state
  final RxBool showUpdateAnimation = false.obs;

  // Form state
  final RxString selectedTone = ''.obs;
  final RxList<String> selectedTopicsToAvoid = <String>[].obs;
  final RxString selectedRelationshipStatus = ''.obs;
  final RxString selectedSupportType = ''.obs;
  
  // New fields
  final RxString selectedSexualOrientation = ''.obs;
  final RxString selectedInterestedIn = ''.obs;
  final RxString selectedDailyRoutine = ''.obs;
  final RxString selectedAiCommunication = ''.obs;
  final RxList<String> selectedBiggestChallenge = <String>[].obs;
  final RxString selectedTimeDedication = ''.obs;
  final RxString selectedAiToolsFamiliarity = ''.obs;
  final RxString selectedStressResponse = ''.obs;
  final RxString selectedAiHonesty = ''.obs;

  // Error states (for AppTextField-style error display)
  final RxString toneError = ''.obs;
  final RxString topicsToAvoidError = ''.obs;
  final RxString relationshipStatusError = ''.obs;
  final RxString supportTypeError = ''.obs;
  final RxString sexualOrientationError = ''.obs;
  final RxString interestedInError = ''.obs;
  final RxString dailyRoutineError = ''.obs;
  final RxString aiCommunicationError = ''.obs;
  final RxString biggestChallengeError = ''.obs;
  final RxString timeDedicationError = ''.obs;
  final RxString aiToolsFamiliarityError = ''.obs;
  final RxString stressResponseError = ''.obs;
  final RxString aiHonestyError = ''.obs;

  // Available options
  final List<String> toneOptions = [
    AppTexts.conversationToneGentle,
    AppTexts.conversationToneSlightlyFlirty,
    AppTexts.conversationToneMorePractical,
  ];

  final List<String> topicsToAvoidOptions = [
    AppTexts.topicPolitics,
    AppTexts.topicReligion,
    AppTexts.topicHealthIssues,
    AppTexts.topicWorkStress,
    AppTexts.topicFamilyIssues,
    AppTexts.topicFinancialWorries,
  ];

  final List<String> relationshipStatusOptions = [
    AppTexts.relationshipStatusSingle,
    AppTexts.relationshipStatusDivorced,
    AppTexts.relationshipStatusWidowed,
    AppTexts.relationshipStatusOther,
  ];

  final List<String> supportTypeOptions = [
    AppTexts.supportTypeSupportiveFriend,
    AppTexts.supportTypeRomanticPartner,
    AppTexts.supportTypeCaringListener,
    AppTexts.supportTypeMentor,
    AppTexts.supportTypeCompanion,
  ];

  // New options
  final List<String> sexualOrientationOptions = [
    AppTexts.sexualOrientationStraight,
    AppTexts.sexualOrientationGay,
    AppTexts.sexualOrientationBisexual,
    AppTexts.sexualOrientationAsexual,
    AppTexts.sexualOrientationDemisexual,
    AppTexts.sexualOrientationQueer,
  ];

  final List<String> interestedInOptions = [
    AppTexts.interestedInWomen,
    AppTexts.interestedInMen,
    AppTexts.interestedInBoth,
  ];

  final List<String> dailyRoutineOptions = [
    AppTexts.dailyRoutineMostlyActive,
    AppTexts.dailyRoutineModeratelyActive,
    AppTexts.dailyRoutineSedentary,
    AppTexts.dailyRoutineIrregular,
  ];

  final List<String> aiCommunicationOptions = [
    AppTexts.aiCommunicationDirect,
    AppTexts.aiCommunicationSupportive,
    AppTexts.aiCommunicationAnalytical,
    AppTexts.aiCommunicationConcise,
  ];

  final List<String> biggestChallengeOptions = [
    AppTexts.biggestChallengeStress,
    AppTexts.biggestChallengeHealthFitness,
    AppTexts.biggestChallengeMotivation,
    AppTexts.biggestChallengeWorkPressure,
    AppTexts.biggestChallengeEnergyLevels,
    AppTexts.biggestChallengeOther,
  ];

  final List<String> timeDedicationOptions = [
    AppTexts.timeDedicationLessThan5,
    AppTexts.timeDedication5To15,
    AppTexts.timeDedication15To30,
    AppTexts.timeDedication30Plus,
  ];

  final List<String> aiToolsFamiliarityOptions = [
    AppTexts.aiToolsFamiliarityBeginner,
    AppTexts.aiToolsFamiliarityIntermediate,
    AppTexts.aiToolsFamiliarityAdvanced,
    AppTexts.aiToolsFamiliarityNotSure,
  ];

  final List<String> stressResponseOptions = [
    AppTexts.stressResponseCalm,
    AppTexts.stressResponseOverwhelmed,
    AppTexts.stressResponseAvoid,
    AppTexts.stressResponseDepends,
  ];

  final List<String> aiHonestyOptions = [
    AppTexts.aiHonestyVeryDirect,
    AppTexts.aiHonestyBalanced,
    AppTexts.aiHonestyGentle,
    AppTexts.aiHonestyDepends,
  ];

  @override
  void onInit() {
    super.onInit();
    loadExistingPreferences();
  }

  /// Load existing preferences from Firestore (if any)
  Future<void> loadExistingPreferences() async {
    try {
      final currentUser = _firebaseService.currentUser;
      if (currentUser == null) return;

      // Load existing preferences from Firestore subcollection
      final prefDoc = await _firebaseService
          .collection(AppConstants.collectionUsers)
          .doc(currentUser.uid)
          .collection(AppConstants.collectionUserPreferences)
          .doc(currentUser.uid)
          .get();

      if (prefDoc.exists && prefDoc.data() != null) {
        final prefs = prefDoc.data()!;
        selectedTone.value = prefs['conversationTone'] ?? '';
        selectedTopicsToAvoid.value = List<String>.from(prefs['topicsToAvoid'] ?? []);
        selectedRelationshipStatus.value = prefs['relationshipStatus'] ?? '';
        selectedSupportType.value = prefs['supportType'] ?? '';
        selectedSexualOrientation.value = prefs['sexualOrientation'] ?? '';
        selectedInterestedIn.value = prefs['interestedIn'] ?? '';
        selectedDailyRoutine.value = prefs['dailyRoutine'] ?? '';
        selectedAiCommunication.value = prefs['aiCommunication'] ?? '';
        selectedBiggestChallenge.value = List<String>.from(prefs['biggestChallenge'] ?? []);
        selectedTimeDedication.value = prefs['timeDedication'] ?? '';
        selectedAiToolsFamiliarity.value = prefs['aiToolsFamiliarity'] ?? '';
        selectedStressResponse.value = prefs['stressResponse'] ?? '';
        selectedAiHonesty.value = prefs['aiHonesty'] ?? '';
        
        if (kDebugMode) {
          print('✅ Loaded existing preferences from Firestore');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading preferences: $e');
      }
    }
  }

  /// Update selected tone
  void updateTone(String? tone) {
    selectedTone.value = tone ?? '';
    // Clear error when user selects a value
    if (tone != null && tone.isNotEmpty) {
      toneError.value = '';
    }
  }

  /// Toggle topic to avoid
  void toggleTopicToAvoid(String topic) {
    final currentList = List<String>.from(selectedTopicsToAvoid);
    if (currentList.contains(topic)) {
      currentList.remove(topic);
    } else {
      currentList.add(topic);
    }
    // Use assignAll to trigger reactivity properly
    selectedTopicsToAvoid.assignAll(currentList);
    // Clear error when user selects at least one topic
    if (selectedTopicsToAvoid.isNotEmpty) {
      topicsToAvoidError.value = '';
    }
  }

  /// Update relationship status
  void updateRelationshipStatus(String? status) {
    selectedRelationshipStatus.value = status ?? '';
    // Clear error when user selects a value
    if (status != null && status.isNotEmpty) {
      relationshipStatusError.value = '';
    }
  }

  /// Update support type
  void updateSupportType(String? supportType) {
    selectedSupportType.value = supportType ?? '';
    // Clear error when user selects a value
    if (supportType != null && supportType.isNotEmpty) {
      supportTypeError.value = '';
    }
  }

  /// Update sexual orientation
  void updateSexualOrientation(String? orientation) {
    selectedSexualOrientation.value = orientation ?? '';
    if (orientation != null && orientation.isNotEmpty) {
      sexualOrientationError.value = '';
    }
  }

  /// Update interested in
  void updateInterestedIn(String? option) {
    selectedInterestedIn.value = option ?? '';
    if (option != null && option.isNotEmpty) {
      interestedInError.value = '';
    }
  }

  /// Update daily routine
  void updateDailyRoutine(String? routine) {
    selectedDailyRoutine.value = routine ?? '';
    if (routine != null && routine.isNotEmpty) {
      dailyRoutineError.value = '';
    }
  }

  /// Update AI communication style
  void updateAiCommunication(String? style) {
    selectedAiCommunication.value = style ?? '';
    if (style != null && style.isNotEmpty) {
      aiCommunicationError.value = '';
    }
  }

  /// Toggle biggest challenge
  void toggleBiggestChallenge(String challenge) {
    final currentList = List<String>.from(selectedBiggestChallenge);
    if (currentList.contains(challenge)) {
      currentList.remove(challenge);
    } else {
      currentList.add(challenge);
    }
    // Use assignAll to trigger reactivity properly
    selectedBiggestChallenge.assignAll(currentList);
    if (selectedBiggestChallenge.isNotEmpty) {
      biggestChallengeError.value = '';
    }
  }

  /// Update time dedication
  void updateTimeDedication(String? time) {
    selectedTimeDedication.value = time ?? '';
    if (time != null && time.isNotEmpty) {
      timeDedicationError.value = '';
    }
  }

  /// Update AI tools familiarity
  void updateAiToolsFamiliarity(String? familiarity) {
    selectedAiToolsFamiliarity.value = familiarity ?? '';
    if (familiarity != null && familiarity.isNotEmpty) {
      aiToolsFamiliarityError.value = '';
    }
  }

  /// Update stress response
  void updateStressResponse(String? response) {
    selectedStressResponse.value = response ?? '';
    if (response != null && response.isNotEmpty) {
      stressResponseError.value = '';
    }
  }

  /// Update AI honesty preference
  void updateAiHonesty(String? honesty) {
    selectedAiHonesty.value = honesty ?? '';
    if (honesty != null && honesty.isNotEmpty) {
      aiHonestyError.value = '';
    }
  }

  /// Validate form
  /// Returns true if all required fields are valid
  /// Sets error messages in AppTextField style
  bool validateForm() {
    bool isValid = true;

    // Clear all errors first
    toneError.value = '';
    topicsToAvoidError.value = '';
    relationshipStatusError.value = '';
    supportTypeError.value = '';
    sexualOrientationError.value = '';
    interestedInError.value = '';
    dailyRoutineError.value = '';
    aiCommunicationError.value = '';
    biggestChallengeError.value = '';
    timeDedicationError.value = '';
    aiToolsFamiliarityError.value = '';
    stressResponseError.value = '';
    aiHonestyError.value = '';

    // Validate conversationTone (required)
    if (selectedTone.value.isEmpty) {
      toneError.value = 'Please select your preferred conversation tone';
      isValid = false;
    }

    // Validate topicsToAvoid (required)
    if (selectedTopicsToAvoid.isEmpty) {
      topicsToAvoidError.value = 'Please select at least one topic to avoid';
      isValid = false;
    }

    // Validate relationshipStatus (required)
    if (selectedRelationshipStatus.value.isEmpty) {
      relationshipStatusError.value = 'Please select your relationship status';
      isValid = false;
    }

    // Validate supportType (required)
    if (selectedSupportType.value.isEmpty) {
      supportTypeError.value = 'Please select the type of support you are looking for';
      isValid = false;
    }

    // Validate sexualOrientation (required)
    if (selectedSexualOrientation.value.isEmpty) {
      sexualOrientationError.value = 'Please select your sexual orientation';
      isValid = false;
    }

    // Validate interestedIn (required)
    if (selectedInterestedIn.value.isEmpty) {
      interestedInError.value = 'Please select who you are interested in';
      isValid = false;
    }

    // Validate dailyRoutine (optional - no validation needed)

    // Validate aiCommunication (required)
    if (selectedAiCommunication.value.isEmpty) {
      aiCommunicationError.value = 'Please select your preferred communication style';
      isValid = false;
    }

    // Validate biggestChallenge (required)
    if (selectedBiggestChallenge.isEmpty) {
      biggestChallengeError.value = 'Please select at least one challenge';
      isValid = false;
    }

    // Validate timeDedication (required)
    if (selectedTimeDedication.value.isEmpty) {
      timeDedicationError.value = 'Please select how much time you can dedicate';
      isValid = false;
    }

    // Validate aiToolsFamiliarity (required)
    if (selectedAiToolsFamiliarity.value.isEmpty) {
      aiToolsFamiliarityError.value = 'Please select your familiarity with AI tools';
      isValid = false;
    }

    // Validate stressResponse (required)
    if (selectedStressResponse.value.isEmpty) {
      stressResponseError.value = 'Please select how you respond to stress';
      isValid = false;
    }

    // Validate aiHonesty (required)
    if (selectedAiHonesty.value.isEmpty) {
      aiHonestyError.value = 'Please select how honest you want the AI to be';
      isValid = false;
    }

    return isValid;
  }

  /// Update preferences (for bottom sheet updates, doesn't navigate)
  Future<void> updatePreferences() async {
    if (!validateForm()) {
      return;
    }

    try {
      setLoading(true);
      clearError();

      final currentUser = _firebaseService.currentUser;
      if (currentUser == null) {
        showError(
          'Authentication Required',
          subtitle: 'Please sign in to save your preferences',
        );
        setLoading(false);
        return;
      }

      // Prepare preferences map
      final preferences = {
        'conversationTone': selectedTone.value,
        'topicsToAvoid': selectedTopicsToAvoid.toList(),
        'relationshipStatus': selectedRelationshipStatus.value,
        'supportType': selectedSupportType.value,
        'sexualOrientation': selectedSexualOrientation.value,
        'interestedIn': selectedInterestedIn.value,
        'dailyRoutine': selectedDailyRoutine.value,
        'aiCommunication': selectedAiCommunication.value,
        'biggestChallenge': selectedBiggestChallenge.toList(),
        'timeDedication': selectedTimeDedication.value,
        'aiToolsFamiliarity': selectedAiToolsFamiliarity.value,
        'stressResponse': selectedStressResponse.value,
        'aiHonesty': selectedAiHonesty.value,
        'updatedAt': DateTime.now().toIso8601String(),
      };

      // Save to Firestore
      await _savePreferencesToFirestore(currentUser.uid, preferences);

      if (kDebugMode) {
        print('✅ Profile preferences updated');
      }

      // Show Lottie animation
      showUpdateAnimation.value = true;

      // Wait for animation to complete (typically 2-3 seconds)
      await Future.delayed(const Duration(seconds: 3));

      // Hide animation
      showUpdateAnimation.value = false;

      // Close bottom sheet
      try {
        if (Get.isBottomSheetOpen == true) {
          Get.back();
        } else if (Get.context != null && Navigator.of(Get.context!).canPop()) {
          Navigator.of(Get.context!).pop();
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error closing bottom sheet: $e');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating preferences: $e');
      }
      showError(
        'Update Failed',
        subtitle: 'We couldn\'t update your preferences. Please try again.',
      );
    } finally {
      setLoading(false);
    }
  }

  /// Save preferences and navigate to main
  Future<void> savePreferences() async {
    if (!validateForm()) {
      return;
    }

    try {
      setLoading(true);
      clearError();

      final currentUser = _firebaseService.currentUser;
      if (currentUser == null) {
        showError(
          'Authentication Required',
          subtitle: 'Please sign in to save your preferences',
        );
        setLoading(false);
        return;
      }

      // Prepare preferences map
      final preferences = {
        'conversationTone': selectedTone.value,
        'topicsToAvoid': selectedTopicsToAvoid.toList(),
        'relationshipStatus': selectedRelationshipStatus.value,
        'supportType': selectedSupportType.value,
        'sexualOrientation': selectedSexualOrientation.value,
        'interestedIn': selectedInterestedIn.value,
        'dailyRoutine': selectedDailyRoutine.value,
        'aiCommunication': selectedAiCommunication.value,
        'biggestChallenge': selectedBiggestChallenge.toList(),
        'timeDedication': selectedTimeDedication.value,
        'aiToolsFamiliarity': selectedAiToolsFamiliarity.value,
        'stressResponse': selectedStressResponse.value,
        'aiHonesty': selectedAiHonesty.value,
        'updatedAt': DateTime.now().toIso8601String(),
      };

      // TODO: Replace with actual API call to save preferences
      // This will call ProfileApiService.savePreferences() when API is integrated
      await _savePreferencesToFirestore(currentUser.uid, preferences);

      // Mark profile setup as completed in local storage
      await _storage.write(AppConstants.storageKeyProfileSetupCompleted, true);

      if (kDebugMode) {
        print('✅ Profile setup completed and saved');
      }

      showSuccess(
        'Preferences Saved!',
        subtitle: 'Your preferences have been saved successfully',
      );

      // Wait a bit for user to see success message
      await Future.delayed(const Duration(milliseconds: 500));

      // Check if onboarding is completed in Firebase (source of truth)
      final firebaseUser = _firebaseService.currentUser;
      bool onboardingCompleted = false;
      
      if (firebaseUser != null) {
        try {
          // Check user document in Firestore for onboarding status
          final userDoc = await _firebaseService
              .collection(AppConstants.collectionUsers)
              .doc(firebaseUser.uid)
              .get();
          
          if (userDoc.exists && userDoc.data() != null) {
            final userData = userDoc.data() as Map<String, dynamic>?;
            onboardingCompleted = userData?['isOnboardingCompleted'] ?? false;
          }
        } catch (e) {
          if (kDebugMode) {
            print('⚠️ Error checking onboarding status: $e');
          }
          // If error, check local storage as fallback
          onboardingCompleted = _storage.read<bool>(AppConstants.storageKeyOnboardingCompleted) ?? false;
        }
      } else {
        // Fallback to local storage if no user
        onboardingCompleted = _storage.read<bool>(AppConstants.storageKeyOnboardingCompleted) ?? false;
      }
      
      if (onboardingCompleted) {
        // Onboarding already completed, navigate to main app
        if (kDebugMode) {
          print('✅ Onboarding already completed, navigating to main app');
        }
        Get.offAllNamed(AppRoutes.mainNavigation);
      } else {
        // Navigate to onboarding (after profile setup)
        if (kDebugMode) {
          print('📚 Navigating to onboarding after profile setup');
        }
        Get.offAllNamed(AppRoutes.onboarding);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving preferences: $e');
      }
      showError(
        'Save Failed',
        subtitle: 'We couldn\'t save your preferences. Please try again.',
      );
    } finally {
      setLoading(false);
    }
  }

  /// Save preferences to Firestore subcollection
  /// Saves to users/{userId}/preferences/{userId}
  /// TODO: Replace with ProfileApiService when API is integrated
  Future<void> _savePreferencesToFirestore(
    String userId,
    Map<String, dynamic> preferences,
  ) async {
    try {
      // Save to subcollection: users/{userId}/preferences/{userId}
      // Using set() with merge: true to create or update (overwrites existing)
      await _firebaseService
          .collection(AppConstants.collectionUsers)
          .doc(userId)
          .collection(AppConstants.collectionUserPreferences)
          .doc(userId)
          .set({
        'userId': userId,
        ...preferences,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (kDebugMode) {
        print('✅ Preferences saved to Firestore subcollection: users/$userId/preferences/$userId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error saving preferences to Firestore: $e');
      }
      rethrow;
    }
  }
}

