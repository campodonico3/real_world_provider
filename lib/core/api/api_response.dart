import 'package:dio/dio.dart';
import 'package:real_world_provider/core/network/dio_exception_handler.dart';

class ApiResponse<T> {
  final bool success; // -> Indica si la petición fue exitosa
  final T? data; // -> Datos de respuesta (null si hubo error)
  final String? message; // -> Mensaje descriptivo (error p éxito)
  final int? statusCode; // -> Código de estado HTTP (error p éxito)
  final Map<String, dynamic>? metadata; // -> Datos adicionales (error p éxito)

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
    this.metadata,
  });

  factory ApiResponse.success(
    T data, {
    String? message,
    int? statusCode,
    Map<String, dynamic>? metadata,
  }) {
    return ApiResponse(
      success: true,
      data: data,
      message: message ?? 'Operación',
      statusCode: statusCode,
      metadata: metadata,
    );
  }

  factory ApiResponse.error(
    String message, [
    int? statusCode,
    Map<String, dynamic>? metadata,
  ]) {
    return ApiResponse(
      success: false,
      message: message,
      statusCode: statusCode,
      metadata: metadata,
    );
  }

  factory ApiResponse.fromDioResponse(
    Response response,
    T Function(dynamic json) fromJson,
  ) {
    try {
      final responseData = response.data;

      // Caso 1: Respuesta con estructura {success, data, message}
      if (responseData is Map<String, dynamic>) {
        final success = responseData['success'] as bool? ?? true;
        final message = responseData['message'] as String?;
        final data = responseData['data'];

        if (success && data != null) {
          return ApiResponse.success(
            fromJson(data),
            message: message,
            statusCode: response.statusCode,
            metadata: {
              'headers': response.headers.map,
              'timestamp': DateTime.now().toIso8601String(),
            },
          );
        } else {
          return ApiResponse.error(
            message ?? 'Error en la respuesta del servidor',
            response.statusCode,
          );
        }
      }

      // Caso 2: Respuesta directa (sin wrapper)
      return ApiResponse.success(
        fromJson(responseData),
        statusCode: response.statusCode,
        metadata: {
          'headers': response.headers.map,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      return ApiResponse.error(
        'Error al procesar la respuesta: ${e.toString()}',
        response.statusCode,
      );
    }
  }

  factory ApiResponse.fromDioError(DioException error) {
    return DioExceptionHandler.handleError<T>(error);
  }

  // Serialización
  // Convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'data': data,
      'message': message,
      'statusCode': statusCode,
      'metadata': metadata,
    };
  }

  @override
  String toString() {
    return 'ApiResponse{success: $success, data: $data, message: $message, statusCode: $statusCode, metadata: $metadata}';
  }
}
