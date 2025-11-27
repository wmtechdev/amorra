import 'package:get/get.dart';
import '../controllers/subscription/subscription_controller.dart';

/// Subscription Binding
/// Dependency injection for subscription-related controllers
class SubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    // Register controllers
    Get.lazyPut(() => SubscriptionController());
  }
}

