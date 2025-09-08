import 'package:flutter/material.dart';

const Color kPink = Color(0xFFF28482);
const Color kGreen = Color(0xFF84A59D);
const Color kYellow = Color(0xFFF7EDE2);
const Color kYellowLight = Color(0xFFFFFFF2);
const Color kDark = Color(0xFF3D405B);
const Color kPeach = Color(0xFFF5CAC3);

class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color secondarySurface;
  final Color onSecondarySurface;
  final Color regularSurface;
  final Color onRegularSurface;
  final Color actionSurface;
  final Color onActionSurface;
  final Color highlightSurface;
  final Color onHighlightSurface;

  const AppColors({
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.secondarySurface,
    required this.onSecondarySurface,
    required this.regularSurface,
    required this.onRegularSurface,
    required this.actionSurface,
    required this.onActionSurface,
    required this.highlightSurface,
    required this.onHighlightSurface,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? secondarySurface,
    Color? onSecondarySurface,
    Color? regularSurface,
    Color? onRegularSurface,
    Color? actionSurface,
    Color? onActionSurface,
    Color? highlightSurface,
    Color? onHighlightSurface,
  }) {
    return AppColors(
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      secondarySurface: secondarySurface ?? this.secondarySurface,
      onSecondarySurface: onSecondarySurface ?? this.onSecondarySurface,
      regularSurface: regularSurface ?? this.regularSurface,
      onRegularSurface: onRegularSurface ?? this.onRegularSurface,
      actionSurface: actionSurface ?? this.actionSurface,
      onActionSurface: onActionSurface ?? this.onActionSurface,
      highlightSurface: highlightSurface ?? this.highlightSurface,
      onHighlightSurface: onHighlightSurface ?? this.onHighlightSurface,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      secondarySurface: Color.lerp(
        secondarySurface,
        other.secondarySurface,
        t,
      )!,
      onSecondarySurface: Color.lerp(
        onSecondarySurface,
        other.onSecondarySurface,
        t,
      )!,
      regularSurface: Color.lerp(regularSurface, other.regularSurface, t)!,
      onRegularSurface: Color.lerp(
        onRegularSurface,
        other.onRegularSurface,
        t,
      )!,
      actionSurface: Color.lerp(actionSurface, other.actionSurface, t)!,
      onActionSurface: Color.lerp(onActionSurface, other.onActionSurface, t)!,
      highlightSurface: Color.lerp(
        highlightSurface,
        other.highlightSurface,
        t,
      )!,
      onHighlightSurface: Color.lerp(
        onHighlightSurface,
        other.onHighlightSurface,
        t,
      )!,
    );
  }
}
