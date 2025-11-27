import 'package:get/get.dart';
import '../controllers/auth/auth_controller.dart';
import '../../domain/services/chat_service.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/chat_repository.dart';

/// Auth Binding
/// Dependency injection for auth-related controllers
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Register repositories
    Get.lazyPut(() => AuthRepository());
    
    // Register services
    Get.lazyPut(() => ChatRepository());
    Get.lazyPut(() => ChatService());
    
    // Register controllers
    Get.lazyPut(() => AuthController());
  }
}

