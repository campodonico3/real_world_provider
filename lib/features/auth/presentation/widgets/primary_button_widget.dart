import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final bool enabled;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final Widget? icon;
  final bool fullWidth;
  final double elevation;
  final BorderSide? border;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.enabled = true,
    this.width,
    this.height = 52,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.borderRadius = 28,
    this.icon,
    this.fullWidth = false,
    this.elevation = 2,
    this.border,
  });

  /// Constructor para botón secundario/outlined
  const PrimaryButton.outlined({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.enabled = true,
    this.width,
    this.height = 52,
    this.padding,
    this.backgroundColor = Colors.transparent,
    this.textColor = const Color(0xFFF28B82),
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.borderRadius = 28,
    this.icon,
    this.fullWidth = false,
    this.elevation = 0,
  }) : border = const BorderSide(color: Color(0xFFF28B82), width: 1.5);

  /// Constructor para botón de texto
  const PrimaryButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.enabled = true,
    this.width,
    this.height = 48,
    this.padding,
    this.backgroundColor = Colors.transparent,
    this.textColor = const Color(0xFFF28B82),
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.borderRadius = 28,
    this.icon,
    this.fullWidth = false,
    this.elevation = 0,
  }) : border = null;

  @override
  Widget build(BuildContext context) {
    final isEnabled = enabled && !loading && onPressed != null;

    // Colores por defecto
    final defaultBackgroundColor = backgroundColor ?? const Color(0xFFF28B82);
    final defaultTextColor = textColor ?? Colors.white;

    Widget buttonChild = loading
        ? SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          defaultTextColor.withOpacity(0.8),
        ),
      ),
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: isEnabled
                  ? defaultTextColor
                  : defaultTextColor.withOpacity(0.6),
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );

    Widget button;

    if (border != null) {
      // Botón outlined
      button = OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: isEnabled
              ? defaultBackgroundColor
              : defaultBackgroundColor.withOpacity(0.1),
          foregroundColor: defaultTextColor,
          disabledForegroundColor: defaultTextColor.withOpacity(0.5),
          elevation: isEnabled ? elevation : 0,
          side: isEnabled
              ? border
              : BorderSide(
            color: border!.color.withOpacity(0.3),
            width: border!.width,
          ),
          padding: padding ?? const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          minimumSize: Size(
            width ?? (fullWidth ? double.infinity : 0),
            height!,
          ),
        ),
        child: buttonChild,
      );
    } else {
      // Botón filled
      button = ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? defaultBackgroundColor
              : defaultBackgroundColor.withOpacity(0.6),
          foregroundColor: defaultTextColor,
          disabledBackgroundColor: defaultBackgroundColor.withOpacity(0.3),
          disabledForegroundColor: defaultTextColor.withOpacity(0.5),
          elevation: isEnabled ? elevation : 0,
          shadowColor: defaultBackgroundColor.withOpacity(0.3),
          padding: padding ?? const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          minimumSize: Size(
            width ?? (fullWidth ? double.infinity : 0),
            height!,
          ),
        ),
        child: buttonChild,
      );
    }

    // Agregar efectos de interacción
    button = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      child: button,
    );

    // Envolver en Semantics para accesibilidad
    button = Semantics(
      button: true,
      enabled: isEnabled,
      child: button,
    );

    return fullWidth
        ? SizedBox(
      width: double.infinity,
      child: button,
    )
        : button;
  }
}