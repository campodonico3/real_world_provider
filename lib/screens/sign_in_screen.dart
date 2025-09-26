import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world_provider/widgets/input_field_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/router/routers.dart';
import '../widgets/primary_button_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

  Future<void> _submit() async {
    // if (!_formKey.currentState!.validate()) return;
    // setState(() => _loading = true);

    await Future.delayed(const Duration(seconds: 5));

    // setState(() => _loading = false);

    if (mounted) {
      debugPrint('Aqui la simulación de sesión iniciada');
      GoRouter.of(context).go('/home');
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
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.back),
                  splashRadius: 24,
                  tooltip: 'Atrás',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Text(
                'Únete a nuestra comunidad y encuentra tu antojo.',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 28),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          debugPrint('Aquí abrir recuperación de contraseña');
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            label: 'Continue',
                            loading: _loading,
                            enabled: !_loading,
                            onPressed: _submit,
                            width: width,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.black)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'O',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.black)),
                      ],
                    ),
                    SizedBox(height: 16),
                    SocialButton(
                      label: 'Continuar con Google',
                      leading: SvgPicture.asset(
                        'assets/images/icon_google.svg',
                        width: 20,
                        height: 20,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login con Google (simulado)'),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    SocialButton(
                      label: 'Continuar con Apple',
                      leading: SvgPicture.asset(
                        'assets/images/icon_apple.svg',
                        width: 20,
                        height: 20,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login con Google (simulado)'),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          '¿No tienes una cuenta?',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        TextButton(
                          onPressed: () {
                            debugPrint('Redirigir a screen de registro');
                            GoRouter.of(context).push('/register');
                          },
                          child: Text(
                            'Registrarse',
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

class SocialButton extends StatelessWidget {
  final String label;
  final Widget leading;
  final VoidCallback onTap;

  const SocialButton({
    super.key,
    required this.label,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leading,
              const SizedBox(width: 12),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class AppColors {
  static const primary = Color(0xFFF28B82);
  static const background = Color(0xFFFFF8F6);
  static const input = Color(0xFFF3F4F6);
  static const textDark = Color(0xFF2A3544);
  static const muted = Color(0xFF9FBFCB);
  static const danger = Color(0xFFEE6B6B);
}
