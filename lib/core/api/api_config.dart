class ApiConfig {
  // Constructor privado para evitar instancias
  ApiConfig._();

  // URLs
  static const String baseUrl = 'http://192.168.0.103:3000/api';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  // Headers por defecto para todas las peticiones
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Client-Platform': 'Flutter',
    'X-Client': '1.0.0',
  };

  // ==================== RETRY CONFIG ====================
  
  /// Número máximo de reintentos en caso de error
  static const int maxRetries = 3;

  /// Delay entre reintentos (se multiplica exponencialmente)
  /// Retry 1: 1 segundo
  /// Retry 2: 2 segundos
  /// Retry 3: 4 segundos
  static const Duration retryDelay = Duration(seconds: 1);

  static const String logLevel = 'all';

  // Habiliar logs de perticiones solo en desarrollo
  static const bool enableLogging = true; // false -> PRODUCCIÓN
}