import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_world_provider/providers/cart_provider.dart';
import 'package:real_world_provider/providers/product_provider.dart';
import 'package:real_world_provider/screens/cart_screen.dart';
import 'package:real_world_provider/screens/product_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => ProductScreen(),
          '/cart': (context) => CartScreen(),
        },
      ),
    ),
  );
}
