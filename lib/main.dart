import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_world_provider/providers/auth_provider.dart';
import 'package:real_world_provider/providers/cart_provider.dart';
import 'package:real_world_provider/providers/discount_provider.dart';
import 'package:real_world_provider/providers/product_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'core/router/router.dart';
import 'core/theme/app_colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        // 0. Provider de autenticación
        ChangeNotifierProvider(create: (context) => AuthProvider()),

        // 1. ProductProvider (independiente)
        //ChangeNotifierProvider(create: (context) => ProductProvider()),

        // 2. CartProvider (independiente)
        //ChangeNotifierProvider(create: (context) => CartProvider()),

        // 3. DiscountProvider (DEPENDE de CartProvider)
        // ChangeNotifierProxyProvider<CartProvider, DiscountProvider>(
        //   create: (context) => DiscountProvider(null),
        //   // Primera creación sin dependencia
        //   update: (context, cartProvider, previousDiscount) {
        //     // Si ya existe un DiscountProvider, lo mantenemos pero actualizamos la dependecia
        //     if (previousDiscount != null) {
        //       return DiscountProvider(cartProvider);
        //     }
        //     // Si es la primera vez, creamos uno nuevo
        //     return DiscountProvider(cartProvider);
        //   },
        // ),
      ],
      child: Builder(
        builder: (context) {
          final authProvider = context.watch<AuthProvider>();
          final appRouter = createRouter(authProvider);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Unbounded',
              textTheme: const TextTheme(
                bodyLarge: TextStyle(fontWeight: FontWeight.w400), // Regular
                bodyMedium: TextStyle(fontWeight: FontWeight.w500), // Medium
                titleLarge: TextStyle(fontWeight: FontWeight.w700), // Bold
              ),
              useMaterial3: true,
              extensions: <ThemeExtension<dynamic>>[
                const AppColors(
                  background: Colors.white,
                  onBackground: kDark,
                  surface: Colors.white,
                  onSurface: kDark,
                  secondarySurface: kPink,
                  onSecondarySurface: Colors.white,
                  regularSurface: kYellowLight,
                  onRegularSurface: kDark,
                  actionSurface: kPeach,
                  onActionSurface: kPink,
                  highlightSurface: kGreen,
                  onHighlightSurface: Colors.white,
                ),
              ],
            ),
            routerConfig: appRouter,
          );
        },
      ),
    ),
  );
}
