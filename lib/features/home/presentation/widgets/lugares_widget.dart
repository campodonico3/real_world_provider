import 'package:flutter/material.dart';

class Places extends StatelessWidget {
  final Map<String, dynamic>? offerData;

  const Places({super.key, this.offerData});

  @override
  Widget build(BuildContext context) {
    final String imageName = offerData?['image_place'];

    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: Container(
        height: 70,
        width: 70,
        margin: EdgeInsets.only(right: 16,),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(imageName),
            fit: BoxFit.cover,
          ),
          border: BoxBorder.all(color: Colors.grey.shade400, width: 2)
        ),
      ),
    );
  }
}

List<Map<String, String>> allPlaces = [
  {
    'id_place': '1',
    'name_place': 'KelyMar',
    'category_place': 'Pollería - Chifa',
    'image_place': 'assets/images/kelymar.png',
  },
  {
    'id_place': '2',
    'name_place': 'Requep',
    'category_place': 'Postrería',
    'image_place': 'assets/images/requep.jpg',
  },
  {
    'id_place': '3',
    'name_place': 'Triple porción wok',
    'category_place': 'Pollería - Chifa',
    'image_place': 'assets/images/triple_porcion_wok.jpg',
  },
  {
    'id_place': '4',
    'name_place': 'En su punto',
    'category_place': 'Pizzería',
    'image_place': 'assets/images/en_su_punto.png',
  },
  {
    'id_place': '5',
    'name_place': 'Tasty',
    'category_place': 'Cafetería',
    'image_place': 'assets/images/tasty.jpg',
  },
  {
    'id_place': '6',
    'name_place': 'Tatos',
    'category_place': 'Licorería',
    'image_place': 'assets/images/tatos.png',
  },
  {
    'id_place': '7',
    'name_place': 'Tio Broaster',
    'category_place': 'Comida rápida mexico/peruana',
    'image_place': 'assets/images/tio_broaster.jpg',
  },
];
