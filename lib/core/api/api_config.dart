class ApiConfig {
  static const String baseUrl = 'http://192.168.0.103:3000/api';

  static const Duration requestTimeout = Duration(seconds: 10);

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}