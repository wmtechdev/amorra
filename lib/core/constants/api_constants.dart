/// API Constants
/// Contains API endpoints and configuration
class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://api.amorra.app'; // Replace with actual API URL
  static const String aiApiBaseUrl = 'https://api.openai.com/v1'; // Replace with your AI provider

  // API Endpoints
  static const String endpointChat = '/chat/completions';
  static const String endpointModeration = '/moderations';

  // Headers
  static const String headerContentType = 'Content-Type';
  static const String headerAuthorization = 'Authorization';
  static const String headerBearer = 'Bearer';
  static const String contentTypeJson = 'application/json';

  // Request Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Retry Configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
}

