import 'package:get/get.dart';

/// App Routes
/// Centralized route definitions for GetX navigation
class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String ageVerification = '/age-verification';
  static const String onboarding = '/onboarding';
  static const String chat = '/chat';
  static const String subscription = '/subscription';
  static const String subscriptionPlans = '/subscription-plans';
  static const String payment = '/payment';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String adminDashboard = '/admin-dashboard';

  /// Get all routes
  static List<GetPage> getRoutes() {
    return [
      // Routes will be added here as views are created
      // Example:
      // GetPage(
      //   name: splash,
      //   page: () => SplashView(),
      //   binding: SplashBinding(),
      // ),
    ];
  }
}

