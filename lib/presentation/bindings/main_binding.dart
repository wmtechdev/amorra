import 'package:get/get.dart';
import 'package:amorra/presentation/controllers/main/main_navigation_controller.dart';
import 'package:amorra/presentation/controllers/home/home_controller.dart';
import 'package:amorra/presentation/controllers/auth/auth_controller.dart';
import 'package:amorra/presentation/controllers/subscription/subscription_controller.dart';
import 'package:amorra/presentation/controllers/profile/profile_controller.dart';
import 'package:amorra/presentation/controllers/chat/chat_controller.dart';
import 'package:amorra/presentation/controllers/auth/profile_setup/profile_setup_controller.dart';
import 'package:amorra/domain/services/chat_service.dart';
import 'package:amorra/data/repositories/chat_repository.dart';

/// Main Navigation Binding
/// Dependency injection for main navigation
class MainBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure AuthController is available (might already exist from AuthBinding)
    if (!Get.isRegistered<AuthController>()) {
      Get.lazyPut(() => AuthController());
    }

    // Register ChatRepository and ChatService if not already registered
    if (!Get.isRegistered<ChatRepository>()) {
      Get.lazyPut(() => ChatRepository());
    }
    if (!Get.isRegistered<ChatService>()) {
      Get.lazyPut(() => ChatService());
    }

    // Ensure SubscriptionController is available
    if (!Get.isRegistered<SubscriptionController>()) {
      Get.lazyPut(() => SubscriptionController());
    }

    // Register all main navigation controllers
    Get.lazyPut(() => MainNavigationController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => ProfileController());
    
    // Register ProfileSetupController for bottom sheet updates
    Get.lazyPut(() => ProfileSetupController());
  }
}
