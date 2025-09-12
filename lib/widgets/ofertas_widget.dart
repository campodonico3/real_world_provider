import 'package:flutter/material.dart';

class Offers extends StatelessWidget {
  final Map<String, dynamic>? offerData;

  const Offers({super.key, this.offerData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Valores por defecto en caso de que offerData sea null o falten claves
    final String title1 = offerData?['title1'] ?? 'Default Title 1';
    final String title2 = offerData?['title2'] ?? 'Default Title 2';
    final String imageName = offerData?['image']; // La imagen puede ser opcional

    return Container(
      margin: EdgeInsets.only(right: 16, top: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            width: size.width * 0.9,
            height: 128,
            decoration: BoxDecoration(
              color: Color(0xFF84A59D),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  title2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 5,
            bottom: 28,
            child: Image.asset(imageName, height: 121),
          ),
        ],
      ),
    );
  }
}

List<Map<String, String>> allOffers = [
  {
    'title1': 'Free Donut!',
    'title2': 'For orders over \$20',
    'image': 'assets/images/donut.png', // Asegúrate que esta ruta es correcta
  },
  {
    'title1': '2x1 Coffee',
    'title2': 'Only on Mondays',
    'image': 'assets/images/coffe.png', // Ejemplo, crea esta imagen
  },
  {
    'title1': 'Weekend Special',
    'title2': 'Burger + Fries \$10',
    'image': 'assets/images/hamburger.png', // Ejemplo, crea esta imagen
  },
  // Puedes añadir más ofertas aquí
];
