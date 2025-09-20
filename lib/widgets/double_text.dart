import 'package:flutter/material.dart';

class AppDoubleText extends StatelessWidget {
  const AppDoubleText({
    super.key,
    required this.bigText,
    required this.smallText,
    required this.fun,
  });
  final String bigText;
  final String smallText;
  final VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(bigText, style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3D405B),
        )),
        InkWell(
          onTap: fun,
          child: Text(
            smallText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500
            ).copyWith(color: Color(0xFF687daf)),
          ),
        ),
      ],
    );
  }
}
