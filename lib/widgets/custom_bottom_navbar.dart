import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final int cartCount;

  const CustomBottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    this.cartCount = 0,
  });

  static const Color iconGray = Color(0xFF3E3D4A);
  static const Color pink = Color(0xFFF08B8B);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      height: 70,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildNavItem(
            index: 0,
            icon: const Icon(
              Icons.location_on_outlined,
              size: 25,
              color: iconGray,
            ),
            label: 'Location',
            highlighted: selectedIndex == 0,
          ),

          // Home (centrado y resaltado)
          _buildNavItem(
            index: 1,
            icon: const Icon(Icons.home, size: 25, color: pink),
            label: 'Home',
            highlighted:
                true, // siempre resaltado en la imagen; si quieres controlarlo usa selectedIndex
          ),

          // My Cart con badge
          _buildNavItem(
            index: 2,
            icon: const Icon(
              Icons.shopping_bag_outlined,
              size: 25,
              color: iconGray,
            ),
            label: 'My Cart',
            showBadge: false,
            badgeCount: cartCount,
            highlighted: selectedIndex == 2,
          ),

          // Me
          _buildNavItem(
            index: 3,
            icon: const Icon(Icons.person_outline, size: 25, color: iconGray),
            label: 'Me',
            highlighted: selectedIndex == 3,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required Widget icon,
    required String label,
    bool highlighted = false,
    bool showBadge = false,
    int badgeCount = 0,
  }) {
    final color = highlighted ? pink : iconGray;
    final labelStyle = TextStyle(
      color: highlighted ? pink : iconGray,
      fontSize: 11,
      fontWeight: FontWeight.w400,
      height: 1.1,
    );
    final coloredIcon = Icon((icon as Icon).icon, size: 25, color: color);

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onTap(index),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (highlighted)
                Center(child: coloredIcon)
              else if (showBadge)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: 52,
                      height: 44,
                      child: Center(child: coloredIcon),
                    ),
                    if (badgeCount > 0)
                      Positioned(
                        right: -4,
                        top: -6,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          constraints: BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          decoration: BoxDecoration(
                            color: pink,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              badgeCount > 99 ? '99+' : badgeCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                )
              else
                Center(child: coloredIcon),
              SizedBox(height: 5),
              Text(label, style: labelStyle),
            ],
          ),
        ),
      ),
    );
  }
}
