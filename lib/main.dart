import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_world_provider/providers/cart_provider.dart';
import 'package:real_world_provider/providers/discount_provider.dart';
import 'package:real_world_provider/providers/product_provider.dart';
import 'package:real_world_provider/screens/cart_screen.dart';
import 'package:real_world_provider/screens/product_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // 1. ProductProvider (independiente)
        ChangeNotifierProvider(create: (context) => ProductProvider()),

        // 2. CartProvider (independiente)
        ChangeNotifierProvider(create: (context) => CartProvider()),

        // 3. DiscountProvider (DEPENDE de CartProvider)
        ChangeNotifierProxyProvider<CartProvider, DiscountProvider>(
            create: (context) => DiscountProvider(null), // Primera creación sin dependencia
            update: (context, cartProvider, previousDiscount) {
              // Si ya existe un DiscountProvider, lo mantenemos pero actualizamos la dependecia
              if (previousDiscount != null) {
                return DiscountProvider(cartProvider);
              }
              // Si es la primera vez, creamos uno nuevo
              return DiscountProvider(cartProvider);
            },
        ),
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
