import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/foundation.dart';

/// Stripe Service
/// Handles Stripe payment integration
class StripeService {
  static final StripeService _instance = StripeService._internal();
  factory StripeService() => _instance;
  StripeService._internal();

  /// Initialize Stripe with publishable key
  Future<void> initialize(String publishableKey) async {
    try {
      Stripe.publishableKey = publishableKey;
      // Stripe also requires merchant identifier for iOS
      await Stripe.instance.applySettings();
      if (kDebugMode) {
        print('Stripe initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Stripe initialization error: $e');
      }
      rethrow;
    }
  }

  /// Create payment intent
  /// Call your backend to create payment intent
  Future<String> createPaymentIntent({
    required double amount,
    required String currency,
    required String userId,
  }) async {
    try {
      // TODO: Call your backend API to create payment intent
      // This should be done on your server for security
      // Example:
      // final response = await http.post(
      //   Uri.parse('${ApiConstants.baseUrl}/create-payment-intent'),
      //   body: jsonEncode({
      //     'amount': (amount * 100).toInt(), // Stripe uses cents
      //     'currency': currency,
      //     'userId': userId,
      //   }),
      // );
      // final data = jsonDecode(response.body);
      // return data['clientSecret'];
      
      throw UnimplementedError('Payment intent creation should be done on backend');
    } catch (e) {
      if (kDebugMode) {
        print('Create payment intent error: $e');
      }
      rethrow;
    }
  }

  /// Confirm payment with payment sheet
  Future<bool> confirmPayment({
    required String clientSecret,
  }) async {
    try {
      // Create payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Amorra',
        ),
      );

      // Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      return true;
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Stripe payment error: ${e.error.message}');
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Payment confirmation error: $e');
      }
      return false;
    }
  }

  /// Create subscription
  /// This should also be done on backend
  Future<String> createSubscription({
    required String customerId,
    required String priceId,
  }) async {
    try {
      // TODO: Call your backend API to create subscription
      // This should be done on your server for security
      throw UnimplementedError('Subscription creation should be done on backend');
    } catch (e) {
      if (kDebugMode) {
        print('Create subscription error: $e');
      }
      rethrow;
    }
  }

  /// Handle Stripe redirect (for 3D Secure)
  /// Note: Implement based on your Stripe SDK version requirements
  Future<void> handleStripeRedirect(String url) async {
    try {
      // Stripe handleURLCallback signature varies by SDK version
      // Check your flutter_stripe package version for correct usage
      // Common patterns:
      // - await Stripe.instance.handleURLCallback(Uri.parse(url));
      // - await Stripe.instance.handleURLCallback(url);
      if (kDebugMode) {
        print('Stripe redirect handler - URL: $url');
        print('TODO: Implement handleURLCallback based on your Stripe SDK version');
      }
      // Uncomment and adjust based on your Stripe SDK version:
      // await Stripe.instance.handleURLCallback(Uri.parse(url));
    } catch (e) {
      if (kDebugMode) {
        print('Stripe redirect error: $e');
      }
      rethrow;
    }
  }
}

