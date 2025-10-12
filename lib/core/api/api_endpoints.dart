import 'api_config.dart';

class ApiEndpoints {
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String restaurantCategories = '/restaurant-categories';

  static String getUrl(String endpoint) {
    return '${ApiConfig.baseUrl}$endpoint';
  }
}