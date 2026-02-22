import 'package:flutter/cupertino.dart';
import 'package:real_world_provider/core/api/api_response.dart';
import 'package:real_world_provider/features/auth/data/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/storage_keys.dart';
import '../models/user_model.dart';

class AuthRepository {
  final AuthService _authService;

  // Constructor con inyección de dependencias
  AuthRepository({AuthService? authService})
    : _authService = authService ?? AuthService();

  Future<ApiResponse<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final validationError = _validateLoginInput(email, password);
      if (validationError != null) {
        return ApiResponse.error(validationError);
      }

      final response = await _authService.login(
        email: email,
        password: password,
      );

      if (response.success) {
        debugPrint('[AuthRepository] - Login exitoso');
      } else {
        debugPrint('[AuthRepository] - Error en el login: ${response.message}');
      }

      return response;
    } catch (e) {
      debugPrint('💥 [AuthRepository] Error inesperado en login: $e');
      return ApiResponse.error('Error inesperado: ${e.toString()}');
    }
  }

  /// Registro de nuevo usuario
  ///
  /// Crea una nueva cuenta y obtiene token de autenticación
  Future<ApiResponse<LoginResponse>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      debugPrint('📝 [AuthRepository] Iniciando registro para: $email');

      // Validaciones
      final validationError = _validateRegisterInput(name, email, password);
      if (validationError != null) {
        debugPrint('❌ [AuthRepository] Validación fallida: $validationError');
        return ApiResponse.error(validationError);
      }

      // Llamar al servicio
      final response = await _authService.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );

      if (response.success) {
        debugPrint('✅ [AuthRepository] Registro exitoso');
      } else {
        debugPrint('❌ [AuthRepository] Registro fallido: ${response.message}');
      }

      return response;
    } catch (e, stackTrace) {
      debugPrint('💥 [AuthRepository] Error inesperado en registro: $e');
      debugPrint('📚 StackTrace: $stackTrace');

      return ApiResponse.error(
        'Error inesperado al registrarse. Por favor, intenta nuevamente.',
      );
    }
  }

  /// Cerrar sesión
  ///
  /// Limpia el token y datos del usuario localmente
  /// TODO: Llamar endpoint del backend cuando esté disponible
  Future<void> logout() async {
    try {
      debugPrint('👋 Cerrando sesión...');

      // Limpiar datos locales
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(StorageKeys.authToken);
      await prefs.remove(StorageKeys.authUser);

      // TODO: Llamar endpoint del backend
      // await _dioClient.post(_logoutEndpoint);

      debugPrint('✅ Sesión cerrada correctamente');
    } catch (e) {
      debugPrint('⚠️ Error al cerrar sesión: $e');
      // Continuar aunque falle, lo importante es limpiar localmente
    }
  }

  // ==================== GESTIÓN DE TOKEN ====================

  /// Guardar token en SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(StorageKeys.authToken, token);
    debugPrint('🔑 Token guardado: $token');
  }

  /// Obtener token guardado
  Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(StorageKeys.authToken);
    } catch (e) {
      debugPrint('⚠️ Error obteniendo token: $e');
      return null;
    }
  }

  /// Verificar si hay token válido
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // ==================== GESTIÓN DE USUARIO ====================

  /// Guardar usuario en SharedPreferences
  Future<void> saveUser(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = user.toJson();
      await prefs.setString(StorageKeys.authUser, userJson.toString());
      debugPrint('👤 Usuario guardado: ${user.name}');
    } catch (e) {
      debugPrint('⚠️ Error guardando usuario: $e');
    }
  }

  /// Obtener usuario guardado
  Future<UserModel?> getSavedUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userString = prefs.getString(StorageKeys.authUser);

      if (userString != null && userString.isNotEmpty) {
        // TODO: Parsear correctamente el JSON
        // Por ahora retornamos null, implementar cuando sea necesario
        debugPrint('⚠️ getSavedUser necesita implementación de parsing');
        return null;
      }

      return null;
    } catch (e) {
      debugPrint('⚠️ Error obteniendo usuario guardado: $e');
      return null;
    }
  }

  /// Validar datos de login
  String? _validateLoginInput(String email, String password) {
    if (email.trim().isEmpty) {
      return 'El correo electrónico es requerido';
    }

    if (!_isValidEmail(email)) {
      return 'El correo electrónico no es válido';
    }

    if (password.isEmpty) {
      return 'La contraseña es requerida';
    }

    if (password.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }

    return null; // Sin errores
  }

  /// Validar datos de registro
  String? _validateRegisterInput(String name, String email, String password) {
    if (name.trim().isEmpty) {
      return 'El nombre es requerido';
    }

    if (name.trim().length < 2) {
      return 'El nombre debe tener al menos 2 caracteres';
    }

    if (email.trim().isEmpty) {
      return 'El correo electrónico es requerido';
    }

    if (!_isValidEmail(email)) {
      return 'El correo electrónico no es válido';
    }

    if (password.isEmpty) {
      return 'La contraseña es requerida';
    }

    if (password.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }

    // Opcional: Validar complejidad de contraseña
    if (!_hasMinimumPasswordStrength(password)) {
      return 'La contraseña debe contener al menos una letra y un número';
    }

    return null; // Sin errores
  }

  /// Validar formato de email
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email.trim());
  }

  /// Validar fortaleza mínima de contraseña
  bool _hasMinimumPasswordStrength(String password) {
    final hasLetter = password.contains(RegExp(r'[a-zA-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    return hasLetter && hasNumber;
  }
}
