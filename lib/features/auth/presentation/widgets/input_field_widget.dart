import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final String? hintText;
  final bool enabled;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final int? maxLines; // Control de altura del input
  final int? maxLength; // Límite de caracteres
  final TextCapitalization textCapitalization; //Capitalización automática (mayúsculas)
  final FocusNode? focusNode;

  const InputField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffix,
    this.prefix,
    this.hintText,
    this.enabled = true,
    this.onTap,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: label,
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        onTap: onTap,
        onChanged: onChanged,
        maxLines: maxLines,
        maxLength: maxLength,
        textCapitalization: textCapitalization,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 18,
          ),
          filled: true,
          fillColor: enabled
              ? const Color(0xFFF3F4F6)
              : Colors.grey.shade100,
          hintText: hintText ?? '',
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            //color: Colors.grey.shade500, // **
          ),
          prefixIcon: prefix,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 44,
            minHeight: 44,
          ),
          suffixIcon: suffix,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 44,
            minHeight: 44,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(
              color: Color(0xFFF28B82),
              width: 1.4,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.4,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.4,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
          counterText: maxLength != null ? null : '',
        ),
      ),
    );
  }
}