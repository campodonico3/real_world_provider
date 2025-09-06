import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_world_provider/providers/discount_provider.dart';

import '../models/cart_model.dart';
import '../providers/cart_provider.dart';
import '../widgets/discount_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var cartItems = cartProvider.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        // Agregamos el botón de vaciar el carrito
        actions: [
          // MOSTRAMOS EL BTN SOLO SI HAY ITEMS EN EL CARRITO
          if (cartProvider.noVacia)
            IconButton(
              onPressed: () {
                cartProvider.clearCart();
              },
              tooltip: 'Clear all',
              icon: Icon(Icons.clear_all_outlined),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                CartItem cartItem = cartItems[index];
                return CartItemTile(cartItem: cartItem);
              },
            ),
          ),
          DiscountWidget(),

          _cartSummary(context),
        ],
      ),
    );
  }

  Widget _cartSummary(BuildContext context) {
    return Consumer2<CartProvider, DiscountProvider>(
      builder: (context, cartProvider, discountProvider, child) {
        // 🔍 LOG CADA VEZ QUE SE RECONSTRUYE
        debugPrint('🏗️ [CartSummary] BUILD ejecutado - Time: ${DateTime.now().millisecondsSinceEpoch}');

        final subTotal = cartProvider.totalPrice;
        final discount = discountProvider.calculateDiscountAmount(subTotal);
        final total = discountProvider.calculateFinalTotal(subTotal);

        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Subtotal: \$${subTotal.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
              if (discountProvider.hasDiscount)
                Text(
                  'Discount: -\$${discount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, color: Colors.red[700]),
                ),
              Divider(),
              Text('Total: \$${total.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                ),)
            ],
          ),
        );
      },
    );
  }
}

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;

  const CartItemTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);

    return ListTile(
      title: Text(cartItem.product.name),
      subtitle: Text(
        '${cartItem.quantity} x \$${cartItem.product.price.toStringAsFixed(2)}',
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          cartProvider.removeFromCart(cartItem.product.id);
        },
      ),
    );
  }
}
