import 'package:get/get.dart';
import '../controllers/chat/chat_controller.dart';
import '../../domain/services/chat_service.dart';
import '../../data/repositories/chat_repository.dart';

/// Chat Binding
/// Dependency injection for chat-related controllers
class ChatBinding extends Bindings {
  @override
  void dependencies() {
    // Register repositories
    Get.lazyPut(() => ChatRepository());
    
    // Register services
    Get.lazyPut(() => ChatService());
    
    // Register controllers
    Get.lazyPut(() => ChatController());
  }
}

