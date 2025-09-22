import 'package:flutter/material.dart';

class Destination {
  const Destination({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}

const destinations = [
  Destination(label: 'Location', icon: Icons.location_on_outlined),
  Destination(label: 'Home', icon: Icons.home),
  Destination(label: 'My Cart', icon: Icons.shopping_bag_outlined),
  Destination(label: 'Me', icon: Icons.person_outline),
];