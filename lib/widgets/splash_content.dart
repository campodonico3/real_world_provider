import 'package:flutter/material.dart';

import '../core/utils/size_config.dart';

class SplashContent extends StatelessWidget {
  final String text, description, image;

  const SplashContent({
    super.key,
    required this.text,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: 3),
        Text(
          'DELIVERY REQUE',
          style: TextStyle(
            fontSize: SizeConfig().getProportionateScreenHeight(26),
          ),
        ),
        Text(text, textAlign: TextAlign.center),
        Spacer(flex: 1),
        Image.asset(
          image,
          height: SizeConfig().getProportionateScreenHeight(300),
          width: SizeConfig().getProportionateScreenWidth(235),
        ),
        Text(description, textAlign: TextAlign.center),
      ],
    );
  }
}
