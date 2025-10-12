import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:real_world_provider/core/api/api_config.dart';
import 'package:real_world_provider/core/api/api_endpoints.dart';
import 'package:real_world_provider/core/constants/storage_keys.dart';
import 'package:real_world_provider/core/utils/api_exception_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/api/api_response.dart';
import '../models/user_model.dart';

class AuthService {
  static Future<ApiResponse<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    debugPrint('\n🔵 ===== INICIANDO LOGIN =====');
    debugPrint('📧 Email: $email');
    debugPrint(
      '🔑 Password: ${password.isNotEmpty ? "✅ Proporcionado" : "❌ Vacío"}',
    );
    debugPrint('🌐 URL: ${ApiEndpoints.getUrl(ApiEndpoints.login)}');

    try {
      final body = {'email': email.trim(), 'password': password};

      debugPrint('📦 Body a enviar: ${jsonEncode(body)}');
      debugPrint('⏳ Enviando request...');

      final response = await http
          .post(
            Uri.parse(ApiEndpoints.getUrl(ApiEndpoints.login)),
            headers: ApiConfig.headers,
            body: jsonEncode(body),
          )
          .timeout(
            ApiConfig.requestTimeout,
            onTimeout: () => throw ApiExceptionHandler.handleTimeout(),
          );

      debugPrint('📨 Respuesta recibida!');
      debugPrint('📊 Status Code: ${response.statusCode}');
      debugPrint('📄 Body: ${response.body}');

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        final loginResponse = LoginResponse.fromJson(responseData['data']);
        await _saveToken(loginResponse.token);
        return ApiResponse.success(loginResponse);
      } else {
        return ApiResponse.error(
          responseData['message'] ?? 'Error en el login',
          response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('Error inesperado: ${e.toString()}');
    }
  }

  static Future<ApiResponse<LoginResponse>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final body = {
        'name': name.trim(),
        'email': email.trim(),
        'password': password,
        if (phone != null && phone.trim().isNotEmpty) 'phone': phone.trim(),
      };

      final response = await http
          .post(
            Uri.parse(ApiEndpoints.getUrl(ApiEndpoints.register)),
            headers: ApiConfig.headers,
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                throw Exception('Timeout: La solicitud tardó demasiado'),
          );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 201 && responseData['success'] == true) {
        final loginResponse = LoginResponse.fromJson(responseData['data']);

        await _saveToken(loginResponse.token);

        return ApiResponse.success(loginResponse);
      } else {
        return ApiResponse.error(
          responseData['message'] ?? 'Error en el registro',
          response.statusCode,
        );
      }
    } on http.ClientException {
      return ApiResponse.error('Error de conexión. Verifica tu internet.');
    } catch (e) {
      return ApiResponse.error('Error inesperado: ${e.toString()}');
    }
  }

  /// Verificar si el usuario está autenticado
  static Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Obtener token guardado
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.authToken);
  }

  /// Guardar token
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(StorageKeys.authToken, token);
  }

  /// Cerrar sesión (eliminar token)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(StorageKeys.authToken);
    await prefs.remove(StorageKeys.authUser);
  }

  /// Obtener headers con autorización
  static Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    return {
      ...ApiConfig.headers,
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Guardar usuario
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString(StorageKeys.authUser, userJson);
  }

  // Obtener usuario guardado
  static Future<UserModel?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(StorageKeys.authUser);
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }
}

/// Clase para la respuesta del login
class LoginResponse {
  final UserModel user;
  final String token;

  const LoginResponse({required this.user, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: UserModel.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'token': token};
  }
}
