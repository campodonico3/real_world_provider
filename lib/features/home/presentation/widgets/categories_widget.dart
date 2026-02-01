import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color color;

  const CategoriesWidget({
    super.key,
    required this.title,
    required this.imagePath,
    this.color = const Color(0xFFFFEF92),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        padding: EdgeInsets.only(top: 16),
        width: 104,
        height: 128,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Spacer(),
                Text(
                  title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                Spacer(),
              ],
            ),
            Positioned(
              left: 25,
              bottom: -12,
              child: Image.asset(
                imagePath,
                height: 104,
                width: 106,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
