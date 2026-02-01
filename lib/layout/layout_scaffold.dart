import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_bottom_navbar.dart';

class LayoutScaffold extends StatelessWidget {
  const LayoutScaffold({required this.navigationShell, Key? key,}) : super(key: key ?? const ValueKey<String>('LayoutScaffold'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBody: true,
    body: navigationShell,
    bottomNavigationBar: SafeArea(
      child: CustomBottomNavbar(
        selectedIndex: navigationShell.currentIndex, // 1
        onTap: navigationShell.goBranch,
        cartCount: 5, // Tiene que ser dinámico
      ),
    ),
  );
}