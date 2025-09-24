import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;
  bool _loading = false;
  bool _accepted = false;

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
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    await Future.delayed(const Duration(seconds: 5));

    setState(() => _loading = false);

    if (mounted) {
      debugPrint('Aqui la simulación de sesión iniciada');
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
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: _emailValidator,
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
                            onPressed: _submit,
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
