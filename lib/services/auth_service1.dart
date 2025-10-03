import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _baseUrl = 'http://192.168.0.102:3000/api'; // Cambia por tu URL
  static const String _loginEndpoint = '/auth/login';
  static const String _registerEndpoint = '/auth/register';

  // Headers comunes
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Login del usuario
  static Future<ApiResponse<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    debugPrint('\n🔵 ===== INICIANDO LOGIN =====');
    debugPrint('📧 Email: $email');
    debugPrint('🔑 Password: ${password.isNotEmpty ? "✅ Proporcionado" : "❌ Vacío"}');
    debugPrint('🌐 URL: $_baseUrl$_loginEndpoint');

    try {
      final body = {
        'email': email.trim(),
        'password': password,
      };

      debugPrint('📦 Body a enviar: ${jsonEncode(body)}');
      debugPrint('⏳ Enviando request...');

      final response = await http.post(
        Uri.parse('$_baseUrl$_loginEndpoint'),
        headers: _headers,
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Timeout: La solicitud tardó demasiado'),
      );

      debugPrint('📨 Respuesta recibida!');
      debugPrint('📊 Status Code: ${response.statusCode}');
      debugPrint('📄 Body: ${response.body}');

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        final loginResponse = LoginResponse.fromJson(responseData['data']);

        // Guardar token en SharedPreferences
        await _saveToken(loginResponse.token);

        return ApiResponse.success(loginResponse);
      } else {
        return ApiResponse.error(
          responseData['message'] ?? 'Error en el login',
          response.statusCode,
        );
      }
    } on http.ClientException {
      return ApiResponse.error('Error de conexión. Verifica tu internet.');
    } catch (e) {
      return ApiResponse.error('Error inesperado: ${e.toString()}');
    }
  }

  /// Registro de nuevo usuario
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

      final response = await http.post(
        Uri.parse('$_baseUrl$_registerEndpoint'),
        headers: _headers,
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Timeout: La solicitud tardó demasiado'),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 201 && responseData['success'] == true) {
        final loginResponse = LoginResponse.fromJson(responseData['data']);

        // Guardar token en SharedPreferences
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
    return prefs.getString('auth_token');
  }

  /// Guardar token
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  /// Cerrar sesión (eliminar token)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  /// Obtener headers con autorización
  static Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    return {
      ..._headers,
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}

/// Clase para la respuesta del login
class LoginResponse {
  final User user;
  final String token;

  const LoginResponse({
    required this.user,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
    };
  }
}