import 'package:flutter/cupertino.dart';
import 'package:real_world_provider/features/auth/data/repositories/auth_repository.dart';
import 'package:real_world_provider/features/auth/data/services/auth_service.dart';

import '../data/models/user_model.dart';

enum AuthStatus {
  /// Estado inicial (verificando sesión guardada)
  uninitialized,

  /// Usuario autenticado correctamente
  authenticated,

  /// Usuario no autenticado
  unauthenticated,

  /// En proceso de autenticación (login/register)
  authenticating,
}

class AuthProvider with ChangeNotifier {
  final AuthRepository _repository;

  // Estados
  AuthStatus _status = AuthStatus.uninitialized;
  UserModel? _user;
  String? _token;
  String? _errorMessage;

  // ==================== CONSTRUCTOR ====================
  AuthProvider({AuthRepository? repository})
    : _repository = repository ?? AuthRepository() {
    _checkAuthStatus();
  }

  // ==================== GETTERS ====================
  AuthStatus get status => _status;

  UserModel? get user => _user;

  String? get token => _token;

  String? get errorMessage => _errorMessage;

  bool get isAuthenticated => _status == AuthStatus.authenticated;

  bool get isLoading => _status == AuthStatus.authenticating;

  bool get isUninitialized => _status == AuthStatus.uninitialized;

  // ==================== MÉTODOS DE AUTENTICACIÓN ====================

  // Verificar si hay una sesión activa guardada
  Future<void> _checkAuthStatus() async {
    try {
      debugPrint('🔍 Verificando estado de autenticación...');

      final savedToken = await _repository.getToken();

      if (savedToken != null && savedToken.isNotEmpty) {
        _token = savedToken;

        // Cargar datos del usuario desde SharedPreferences
        final savedUser = await AuthService.getSavedUser();

        if (savedUser != null) {
          _user = savedUser;
          _status = AuthStatus.authenticated;
          debugPrint('✅ Session restaurada: ${savedUser.email}');
        } else {
          // Si hay token pero no usuario, limpiar todo
          await _repository.logout();
          _status = AuthStatus.unauthenticated;
          debugPrint('⚠️ Token sin usauario, limpiando sesión');
        }
      } else {
        _status = AuthStatus.unauthenticated;
        debugPrint('⚠️ No hay sesión guardada');
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error checking auth status: $e');
      _status = AuthStatus.unauthenticated;
      notifyListeners();
    }
  }

  // Login de usuario
  Future<bool> login({required String email, required String password}) async {
    _setLoading();

    try {
      debugPrint('🔐 Intentando login...');

      final response = await _repository.login(
        email: email,
        password: password,
      );

      if (response.success && response.data != null) {
        _user = response.data!.user;
        _token = response.data!.token;
        _status = AuthStatus.authenticated;
        _errorMessage = null;

        debugPrint('✅ Login exitoso: ${_user!.name}');
        notifyListeners();
        return true;
      } else {
        _setError(response.message ?? 'Error en el login');
        return false;
      }
    } catch (e) {
      debugPrint('💥 Error inesperado en login: $e');
      _setError('Error de conexión: ${e.toString()}');
      return false;
    }
  }

  /// Registro de nuevo usuario
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    _setLoading();

    try {
      debugPrint('📝 Intentando registro...');

      final response = await _repository.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );

      if (response.success && response.data != null) {
        _user = response.data!.user;
        _token = response.data!.token;
        _status = AuthStatus.authenticated;
        _errorMessage = null;

        debugPrint('✅ Registro exitoso: ${_user!.name}');
        notifyListeners();
        return true;
      } else {
        _setError(response.message ?? 'Error en el registro');
        return false;
      }
    } catch (e) {
      debugPrint('💥 Error inesperado en registro: $e');
      _setError('Error de conexión: ${e.toString()}');
      return false;
    }
  }

  /// Cerrar sesión
  Future<void> logout() async {
    try {
      debugPrint('👋 Cerrando sesión...');

      await _repository.logout();
      _clearUserData();

      debugPrint('✅ Sesión cerrada correctamente');
    } catch (e) {
      debugPrint('⚠️ Error durante logout: $e');
      // Limpiar datos locales aunque falle la petición
      _clearUserData();
    }
  }

  /// Actualizar datos del usuario
  void updateUser(UserModel updatedUser) {
    _user = updatedUser;
    // Persistir cambios en SharedPreferences
    // AuthService.saveUser(updatedUser);
    notifyListeners();
  }

  /// Limpiar mensaje de error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // ==================== MÉTODOS PRIVADOS ====================
  void _setLoading() {
    _status = AuthStatus.authenticating;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String error) {
    _status = AuthStatus.unauthenticated;
    _errorMessage = error;
    _user = null;
    _token = null;
    notifyListeners();
  }

  void _clearUserData() {
    _status = AuthStatus.unauthenticated;
    _user = null;
    _token = null;
    _errorMessage = null;
    notifyListeners();
  }
}
