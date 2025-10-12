import 'package:http/http.dart' as http;

import '../api/api_response.dart';

class ApiExceptionHandler {
  static ApiResponse<T> handleError<T>(dynamic error) {
    if (error is http.ClientException) {
      return ApiResponse.error('Error de conexión. Verifica tu internet.');
    }
    return ApiResponse.error('Error inesperado: ${error.toString()}');
  }

  static Exception handleTimeout() {
    return Exception('Timeout: La solicitud tardó demasiado');
  }
}