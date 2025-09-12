import 'package:flutter/material.dart';

/// Estado simple inmutable que representa cantidad y precio total (string ya formateado).
class OrderState {
  final int amount;
  final String totalPrice;

  const OrderState({
    required this.amount,
    required this.totalPrice,
  });

  OrderState copyWith({int? amount, String? totalPrice}) {
    return OrderState(
      amount: amount ?? this.amount,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

/// Barra principal con selector y botón "Add to Cart".
class OrderActionBar extends StatelessWidget {
  final OrderState state;
  final VoidCallback onAddItemClicked;
  final VoidCallback onRemoveItemClicked;
  final VoidCallback onCheckOutClicked;
  final double height;
  final BorderRadius borderRadius;
  final double elevation;

  const OrderActionBar({
    super.key,
    required this.state,
    required this.onAddItemClicked,
    required this.onRemoveItemClicked,
    required this.onCheckOutClicked,
    this.height = 76.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(28)),
    this.elevation = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // Surface-like container with elevation
    return Material(
      elevation: elevation,
      color: colorScheme.surface,
      borderRadius: borderRadius,
      child: Container(
        height: height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: borderRadius,
        ),
        child: Row(
          children: [
            // Selector ocupa la mitad
            Expanded(
              flex: 1,
              child: Selector(
                amount: state.amount,
                onAddItemClicked: onAddItemClicked,
                onRemoveItemClicked: onRemoveItemClicked,
              ),
            ),

            const SizedBox(width: 8),

            // Botón de carrito ocupa la otra mitad
            Expanded(
              flex: 1,
              child: CartButton(
                totalPrice: state.totalPrice,
                onClicked: onCheckOutClicked,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Contenedor con borde redondeado y dentro los botones +/- y el número.
class Selector extends StatelessWidget {
  final int amount;
  final VoidCallback onAddItemClicked;
  final VoidCallback onRemoveItemClicked;

  const Selector({
    super.key,
    required this.amount,
    required this.onAddItemClicked,
    required this.onRemoveItemClicked,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = Color(0xFFF28482);

    return Container(
      // garantiza que el contenido tenga un área definida
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectorButton(
              icon: Icons.remove,
              backgroundColor: Color(0xFFF7EDE2),
              iconColor: Color(0xFFF28482),
              onPressed: onRemoveItemClicked,
            ),
            const SizedBox(width: 16),
            Text(
              amount.toString(),
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(width: 16),
            SelectorButton(
              icon: Icons.add,
              backgroundColor: Color(0xFFF28482),
              iconColor: theme.colorScheme.onSecondary,
              onPressed: onAddItemClicked,
            ),
          ],
        ),
      ),
    );
  }
}

/// Botón circular pequeño con ripple
class SelectorButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onPressed;
  final double size;
  final double iconSize;

  const SelectorButton({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onPressed,
    this.size = 32,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    // Usamos Material + InkWell para el efecto ripple sobre fondo circular
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}

/// Botón grande a la derecha — clickable, con texto superior y precio abajo.
class CartButton extends StatelessWidget {
  final String totalPrice;
  final VoidCallback onClicked;
  final BorderRadius borderRadius;

  const CartButton({
    super.key,
    required this.totalPrice,
    required this.onClicked,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Color(0xFFF28482),
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onClicked,
        borderRadius: borderRadius,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add to Cart',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                totalPrice,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
