import 'package:flutter/material.dart';

class AppTypography {
  final TextStyle headLine;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle body;
  final TextStyle bodySmall;
  final TextStyle label;

  const AppTypography({
    required this.headLine,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.body,
    required this.bodySmall,
    required this.label,
  });
}

/// Instancia global con los estilos — usa la familia 'Unbounded' definida en pubspec.yaml
const AppTypography appTypography = AppTypography(
  headLine: TextStyle(
    fontFamily: 'Unbounded',
    fontSize: 32.0,
    fontWeight: FontWeight.normal, // Normal
  ),
  titleLarge: TextStyle(
    fontFamily: 'Unbounded',
    fontSize: 24.0,
    fontWeight: FontWeight.normal,
  ),
  titleMedium: TextStyle(
    fontFamily: 'Unbounded',
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
  ),
  titleSmall: TextStyle(
    fontFamily: 'Unbounded',
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  ),
  body: TextStyle(
    fontFamily: 'Unbounded',
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
  ),
  bodySmall: TextStyle(
    fontFamily: 'Unbounded',
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
  ),
  label: TextStyle(
    fontFamily: 'Unbounded',
    fontSize: 11.0,
    fontWeight: FontWeight.w300, // Light
  ),
);

/// Alternativa: convertir a TextTheme si prefieres integrarlo en ThemeData
TextTheme get appTextTheme => TextTheme(
  displayLarge: appTypography.headLine,
  headlineSmall: appTypography.titleLarge,
  titleLarge: appTypography.titleMedium,
  titleMedium: appTypography.titleSmall,
  bodyLarge: appTypography.body,
  bodySmall: appTypography.bodySmall,
  labelSmall: appTypography.label,
);
