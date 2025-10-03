import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';
import '../services/auth_service1.dart';

enum AuthStatus {
  uninitialized,
  authenticated,
  unauthenticated,
  authenticating,
}

class AuthProvider with ChangeNotifier {
  AuthStatus _status = AuthStatus.uninitialized;
  User? _user;
  String? _token;
  String? _errorMessage;

  // Getters
  AuthStatus get status => _status;
  User? get user => _user;
  String? get token => _token;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isLoading => _status == AuthStatus.authenticating;

  // Constructor - Verificar si hay sesión guardada
  AuthProvider() {
    _checkAuthStatus();
  }

  // Verificar si hay una sesión activa guardada
  Future<void> _checkAuthStatus() async {
    try {
      final savedToken = await AuthService.getToken();
      if (savedToken != null && savedToken.isNotEmpty) {
        _token = savedToken;
        _status = AuthStatus.authenticated;
        // Aquí podrías llamar a una API para obtener los datos del usuario
        // o guardar los datos del usuario en SharedPreferences también
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _status = AuthStatus.unauthenticated;
    }
  }

  // Login de usuario
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading();

    try {
      final response = await AuthService.login(
        email: email,
        password: password,
      );

      if (response.success && response.data != null) {
        _user = response.data!.user;
        _token = response.data!.token;
        _status = AuthStatus.authenticated;
        _errorMessage = null;
        notifyListeners();
        return true;
      } else {
        _setError(response.message ?? 'Error en el login');
        return false;
      }
    } catch (e) {
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
      final response = await AuthService.register(
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
        notifyListeners();
        return true;
      } else {
        _setError(response.message ?? 'Error en el registro');
        return false;
      }
    } catch (e) {
      _setError('Error de conexión: ${e.toString()}');
      return false;
    }
  }

  /// Cerrar sesión
  Future<void> logout() async {
    try {
      await AuthService.logout();
      _clearUserData();
    } catch (e) {
      debugPrint('Error during logout: $e');
      _clearUserData(); // Limpiar datos locales aunque falle
    }
  }

  /// Actualizar datos del usuario
  void updateUser(User updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }

  /// Limpiar mensaje de error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Métodos privados
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