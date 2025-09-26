import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/router/routers.dart';
import '../core/utils/size_config.dart';
import '../widgets/splash_content.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to delivery app",
      "image": "assets/images/onboarding_1.png",
      "description":
          "“Entrega rápida, caliente y segura. Solo pide y nosotros llegamos hasta ti.”",
    },
    {
      "text": "We help people conect with store",
      "image": "assets/images/onboarding_2-removebg-preview.png",
      "description":
          "“Explora el menú, elige tu comida favorita y confirma en segundos”",
    },
    {
      "text": "We show the easy way to shop. Just stay at home with us",
      "image": "assets/images/onboarding_3-removebg-preview.png",
      "description": "“Seguimiento en tiempo real hasta tu puerta”",
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFF5E2),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    text: splashData[index]['text']!,
                    image: splashData[index]['image']!,
                    description: splashData[index]['description']!,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig().getProportionateScreenWidth(20),
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(flex: 3,),
                      SizedBox(
                        width: double.infinity,
                        height: SizeConfig().getProportionateScreenHeight(46),
                        child: FloatingActionButton(
                          onPressed: () {
                            GoRouter.of(context).push(Routes.login);
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          backgroundColor: Color(0xFFF28482),
                          foregroundColor: Color(0xFFFFFFF2),
                          child: Text('Siguiente'),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Color(0xFFF28482) : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
