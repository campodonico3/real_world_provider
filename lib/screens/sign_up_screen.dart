import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:real_world_provider/screens/sign_in_screen.dart';

import '../widgets/input_field_widget.dart';
import '../widgets/primary_button_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showPassword = false;
  bool _loading = false;
  bool _accepted = false;

  String baseUrl = "http://192.168.0.102:3000/api/auth";

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _usernameValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Ingresa tu nombre de usuario';
    if (v.trim().length < 3) return 'Mínimo 3 caracteres';
    return null;
  }

  String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Ingresa tu correo';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(v.trim())) return 'Correo no válido';
    return null;
  }

  String? _passwordValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Ingresa tu contraseña';
    if (v.trim().length < 8) return 'Mínimo 8 caracteres';
    return null;
  }

  String? _confirmPasswordValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Confirma tu contraseña';
    if (v != _passwordController.text) return 'Las contraseñas no coinciden';
    return null;
  }

  Future<void> _submit() async {
    debugPrint('=== INICIO DEL PROCESO DE REGISTRO ===');

    // Validar formulario
    debugPrint('📋 Validando formulario...');
    if (!_formKey.currentState!.validate()) {
      debugPrint('❌ Validación del formulario falló');
      return;
    }
    debugPrint('✅ Formulario válido');

    // NUEVO: Validar que se aceptaron los términos
    debugPrint('📝 Verificando aceptación de términos...');
    if (!_accepted) {
      debugPrint('❌ Términos y condiciones no aceptados');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes aceptar los términos y condiciones'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    debugPrint('✅ Términos aceptados');

    setState(() => _loading = true);
    debugPrint('⏳ Loading activado');

    try {
      // NUEVO: Preparar los datos para enviar
      final requestBody = {
        'name': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
        'password': _passwordController.text,
        // 'phone': null, // Opcional: añade un campo de teléfono si lo necesitas
      };

      debugPrint('📦 Datos preparados para enviar:');
      debugPrint('   - Name: ${requestBody['name']}');
      debugPrint('   - Email: ${requestBody['email']}');
      debugPrint('   - Password: ${requestBody['password']?.replaceAll(RegExp(r'.'), '*')}');

      // NUEVO: Hacer la petición POST al endpoint de registro
      final url = '$baseUrl/register';
      debugPrint('🌐 Enviando petición POST a: $url');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      debugPrint('📨 Respuesta recibida:');
      debugPrint('   - Status Code: ${response.statusCode}');
      debugPrint('   - Body: ${response.body}');

      final responseData = json.decode(response.body);
      debugPrint('📄 Datos parseados: $responseData');

      if (response.statusCode == 201 && responseData['success'] == true) {
        debugPrint('✅ REGISTRO EXITOSO');

        // NUEVO: Registro exitoso
        final userEmail = responseData['data']['user']['email'];
        debugPrint('👤 Usuario registrado: $userEmail');

        // NUEVO: Guardar el token (puedes usar SharedPreferences o un provider)
        final token = responseData['data']['token'];
        debugPrint('🔑 Token recibido: ${token.substring(0, 20)}...');

        if (mounted) {
          debugPrint('📱 Widget montado, mostrando SnackBar y redirigiendo...');

          // NUEVO: Mostrar mensaje de éxito
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message'] ?? 'Registro exitoso'),
              backgroundColor: Colors.green,
            ),
          );

          // NUEVO: Redirigir al login o a la pantalla principal
          debugPrint('🔄 Redirigiendo a /login');
          GoRouter.of(context).go('/login');

          // Opción 2: Si quieres que inicie sesión automáticamente,
          // redirige a la pantalla principal y guarda el token
          // GoRouter.of(context).go('/home');
        } else {
          debugPrint('⚠️ Widget no montado, saltando UI updates');
        }
      } else {
        // NUEVO: Manejar errores del servidor
        debugPrint('❌ ERROR DEL SERVIDOR');
        debugPrint('   - Status Code: ${response.statusCode}');
        debugPrint('   - Success: ${responseData['success']}');

        final errorMessage = responseData['message'] ?? 'Error al registrar usuario';
        debugPrint('   - Mensaje: $errorMessage');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e, stackTrace) {
      // NUEVO: Manejar errores de conexión
      debugPrint('💥 ERROR DE CONEXIÓN O EXCEPCIÓN');
      debugPrint('   - Error: $e');
      debugPrint('   - StackTrace: $stackTrace');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error de conexión. Verifica tu internet.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      // NUEVO: Detener el loading
      debugPrint('🏁 Finalizando proceso...');
      if (mounted) {
        setState(() => _loading = false);
        debugPrint('⏹️ Loading desactivado');
      }
      debugPrint('=== FIN DEL PROCESO DE REGISTRO ===\n');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tamaños adaptativos para pantallas 390x844 y 428x926
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final horizontalPadding = width >= 420
        ? 28.0
        : 20.0; // 10% del ancho de la pantalla

    return Scaffold(
      backgroundColor: Color(0xFFFFF7EE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: const Icon(CupertinoIcons.back),
                  splashRadius: 24,
                  tooltip: 'Atrás',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Create Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Text(
                'Únete a nuestra comunidad y encuentra tu antojo.',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    InputField(
                      label: 'Enter your username',
                      hintText: 'Enter your username',
                      keyboardType: TextInputType.text,
                      controller: _usernameController,
                      validator: _usernameValidator,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    InputField(
                      label: 'Enter your email',
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: _emailValidator,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    InputField(
                      label: 'Contraseña',
                      hintText: 'Introduce tu contraseña',
                      controller: _passwordController,
                      obscureText: !_showPassword,
                      validator: _passwordValidator,
                      suffix: IconButton(
                        onPressed: () =>
                            setState(() => _showPassword = !_showPassword),
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        tooltip: _showPassword
                            ? 'Ocultar contraseña'
                            : 'Mostrar contraseña',
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    InputField(
                      label: 'Contraseña',
                      hintText: 'Confirm your password',
                      controller: _confirmPasswordController,
                      obscureText: !_showPassword,
                      validator: _confirmPasswordValidator,
                      suffix: IconButton(
                        onPressed: () =>
                            setState(() => _showPassword = !_showPassword),
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        tooltip: _showPassword
                            ? 'Ocultar contraseña'
                            : 'Mostrar contraseña',
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: 22,
                          height: 22,
                          child: Checkbox(
                            value: _accepted,
                            onChanged: (v) {
                              setState(() {
                                _accepted = v ?? false;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            activeColor: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'By agreeing to the terms and conditions, you are entering into a legally binding contract with the service provider.',
                            style: TextStyle(
                              color: Color(0xFF9FA6AE),
                              fontSize: 13,
                              height: 1.3,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            label: 'Continue',
                            loading: _loading,
                            enabled: !_loading,
                            onPressed: () => _submit(),
                            width: width,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          'Already have an account?',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        TextButton(
                          onPressed: () {
                            debugPrint('Redirigir a screen de login');
                            GoRouter.of(context).push('/login');
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
