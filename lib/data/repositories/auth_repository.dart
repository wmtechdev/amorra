import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';
import '../../core/constants/app_constants.dart';

/// Auth Repository
/// Handles authentication-related data operations
class AuthRepository {
  final FirebaseService _firebaseService = FirebaseService();

  /// Sign in with email and password
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Sign in failed: User is null');
      }

      // Get user data from Firestore
      final userDoc = await _firebaseService
          .collection(AppConstants.collectionUsers)
          .doc(credential.user!.uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>?;
        return UserModel.fromJson({
          'id': credential.user!.uid,
          ...?userData,
        });
      } else {
        // Create user document if it doesn't exist
        final userModel = UserModel(
          id: credential.user!.uid,
          email: credential.user!.email,
          name: credential.user!.displayName ?? '',
          createdAt: DateTime.now(),
        );
        await createUser(userModel);
        return userModel;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Sign in error: $e');
      }
      rethrow;
    }
  }

  /// Sign up with email and password
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential =
          await _firebaseService.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Sign up failed: User is null');
      }

      // Create user document
      final userModel = UserModel(
        id: credential.user!.uid,
        email: email,
        name: name,
        createdAt: DateTime.now(),
      );

      await createUser(userModel);
      return userModel;
    } catch (e) {
      if (kDebugMode) {
        print('Sign up error: $e');
      }
      rethrow;
    }
  }

  /// Create user document in Firestore
  Future<void> createUser(UserModel user) async {
    try {
      await _firebaseService
          .collection(AppConstants.collectionUsers)
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Create user error: $e');
      }
      rethrow;
    }
  }

  /// Get current user
  Future<UserModel?> getCurrentUser() async {
    try {
      final userId = _firebaseService.currentUserId;
      if (userId == null) return null;

      final userDoc = await _firebaseService
          .collection(AppConstants.collectionUsers)
          .doc(userId)
          .get();

      if (!userDoc.exists) return null;

      final userData = userDoc.data() as Map<String, dynamic>?;
      return UserModel.fromJson({
        'id': userId,
        ...?userData,
      });
    } catch (e) {
      if (kDebugMode) {
        print('Get current user error: $e');
      }
      return null;
    }
  }

  /// Update user document
  Future<void> updateUser(UserModel user) async {
    try {
      await _firebaseService
          .collection(AppConstants.collectionUsers)
          .doc(user.id)
          .update(user.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Update user error: $e');
      }
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _firebaseService.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('Sign out error: $e');
      }
      rethrow;
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseService.auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      if (kDebugMode) {
        print('Reset password error: $e');
      }
      rethrow;
    }
  }
}

