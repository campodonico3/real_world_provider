import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world_provider/core/router/routers.dart';
import 'package:real_world_provider/screens/sign_in_screen.dart';
import 'package:real_world_provider/screens/sign_up_screen.dart';

import '../../layout/layout_scaffold.dart';
import '../../screens/cart_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/product_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.login,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const SignInScreen(),
     ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) => const SignUpScreen(),
    ),
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            LayoutScaffold(navigationShell: navigationShell),
        branches: [
          // Rama 0: Location
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.locationPage,
                builder: (context, state) => const ProductScreen(),
              ),
            ],
          ),

          // Rama 1: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.homePage,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // Rama 2: My Cart
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.myCartPage,
                builder: (context, state) => const CartScreen(),
              ),
            ],
          ),

          // Rama 3: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profilePage,
                builder: (context, state) => const CartScreen(),
              ),
            ],
          ),
        ]
    ),
  ],
);