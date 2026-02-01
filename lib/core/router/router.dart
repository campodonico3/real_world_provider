import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world_provider/core/router/routers.dart';
import 'package:real_world_provider/features/auth/providers/auth_provider.dart';
import 'package:real_world_provider/features/auth/presentation/screens/otp_screen.dart';
import 'package:real_world_provider/features/profile/presentation/screens/profile_screen.dart';
import 'package:real_world_provider/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:real_world_provider/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:real_world_provider/features/auth/presentation/screens/splash_screen.dart';

import '../../layout/layout_scaffold.dart';
import '../../screens/cart_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../screens/product_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter createRouter(AuthProvider authProvider) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: authProvider.isAuthenticated ? Routes.homePage : Routes.login,
    refreshListenable: authProvider,
    redirect: (context, state) {
      final bool isAuthenticated = authProvider.isAuthenticated;
      final String location = state.matchedLocation;

      debugPrint('🔄 Router Redirect - Auth: $isAuthenticated, Location: $location');

      final bool isAuthFlow = location == Routes.login ||
          location == Routes.register ||
          location == Routes.otp ||
          location == Routes.splash;

      // Si no está autenticado y no está en flujo de auth, redirigir a login
      if (!isAuthenticated && !isAuthFlow) {
        debugPrint('➡️ Redirigiendo a login (no autenticado)');
        return Routes.login;
      }

      // Si está autenticado y está en flujo de auth, redirigir a home
      if (isAuthenticated &&
          (location == Routes.login ||
              location == Routes.register ||
              location == Routes.otp ||
              location == Routes.splash)) {
        debugPrint('➡️ Redirigiendo a home (ya autenticado)');
        return Routes.homePage;
      }

      // Si está en splash y no autenticado
      if (!isAuthenticated && location == Routes.splash) {
        debugPrint('➡️ Redirigiendo a login desde splash');
        return Routes.login;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: Routes.otp,
        builder: (context, state) => const OtpScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => LayoutScaffold(navigationShell: navigationShell),
        branches: [
          // Rama 0: Location
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.locationPage,
                builder: (context, state) => const HomeScreen(),
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
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // Rama 3: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profilePage,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
