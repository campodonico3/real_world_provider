// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:real_world_provider/providers/discount_provider.dart';
//
// import '../models/cart_model.dart';
// import '../providers/cart_provider.dart';
// import '../widgets/discount_widget.dart';
//
// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var cartProvider = Provider.of<CartProvider>(context);
//     var cartItems = cartProvider.items.values.toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Cart', style: TextStyle(color: Color(0xFF3D405B))),
//         // Agregamos el botón de vaciar el carrito
//         actions: [
//           // MOSTRAMOS EL BTN SOLO SI HAY ITEMS EN EL CARRITO
//           if (cartProvider.noVacia)
//             IconButton(
//               onPressed: () {
//                 cartProvider.clearCart();
//               },
//               tooltip: 'Clear all',
//               icon: Icon(Icons.clear_all_outlined, color: Color(0xFFF28482)),
//             ),
//         ],
//       ),
//       body: cartProvider.isEmpty
//           ? _buildEmptyCart(context)
//           : Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: cartItems.length,
//                     itemBuilder: (context, index) {
//                       CartItem cartItem = cartItems[index];
//                       return CartItemTile(cartItem: cartItem);
//                     },
//                   ),
//                 ),
//                 DiscountWidget(),
//
//                 _cartSummary(context),
//               ],
//             ),
//     );
//   }
//
//   Widget _buildEmptyCart(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
//             SizedBox(height: 16),
//             Text(
//               'Your cart is empty',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Color(0xFF3D405B),
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Add some delicious items to get started!',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => Navigator.pop(context),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFFF28482),
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               ),
//               child: Text('Continue Shopping'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _cartSummary(BuildContext context) {
//     // 🔍 LOG CADA VEZ QUE SE RECONSTRUYE
//     debugPrint(
//       '🏗️ [CartSummary] BUILD ejecutado - Time: ${DateTime.now().millisecondsSinceEpoch}',
//     );
//
//     return Consumer<CartProvider>(
//       builder: (context, cartProvider, child) {
//         final subTotal = cartProvider.totalPrice;
//
//         return Consumer<DiscountProvider>(
//           builder: (context, discountProvider, child) {
//             final discount = discountProvider.calculateDiscountAmount(subTotal);
//             final total = discountProvider.calculateFinalTotal(subTotal);
//
//             return Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Text(
//                     'Subtotal: \$${subTotal.toStringAsFixed(2)}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   if (discountProvider.hasDiscount) ...[
//                     Text(
//                       'Discount: -\$${discount.toStringAsFixed(2)}',
//                       style: TextStyle(fontSize: 16, color: Colors.red[700]),
//                     ),
//                     // Mostramos advertencia si el descuento está suspendido
//                     if (discountProvider.status == DiscountStatus.belowMinimum)
//                       Padding(
//                         padding: EdgeInsets.only(top: 4),
//                         child: Text(
//                           discountProvider.warningMessage,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.orange[700],
//                             fontStyle: FontStyle.italic,
//                           ),
//                         ),
//                       ),
//                   ],
//                   Divider(),
//                   Text(
//                     'Total: \$${total.toStringAsFixed(2)}',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
//
// class CartItemTile extends StatelessWidget {
//   final CartItem cartItem;
//
//   const CartItemTile({super.key, required this.cartItem});
//
//   @override
//   Widget build(BuildContext context) {
//     var cartProvider = Provider.of<CartProvider>(context, listen: false);
//
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(28),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0x66F2CC8F),
//             blurRadius: 32,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: Colors.transparent,
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.asset(cartItem.product.imageUrl!, fit: BoxFit.cover),
//             ),
//           ),
//           SizedBox(width: 16),
//
//           // Información del producto
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   cartItem.product.name,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Color(0xFF3D405B),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   '${cartItem.quantity} x \$${cartItem.product.price.toStringAsFixed(2)}',
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w300,
//                     color: Color(0xFFF28482),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Controles de cantidad
//           Column(
//             children: [
//               // Botones de cantidad
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Botón decrementar
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xFFF7EDE2),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: _QuantityButton(
//                         icon: Icons.remove,
//                         onPressed: () {
//                           cartProvider.decrementQuantity(cartItem.product.id);
//                         },
//                         backgroundColor: Colors.transparent,
//                         iconColor: Color(0xFFF28482),
//                       ),
//                     ),
//
//                     // Cantidad
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       child: Text(
//                         '${cartItem.quantity}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xFF3D405B),
//                         ),
//                       ),
//                     ),
//
//                     // Botón incrementar
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xFFF28482),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: _QuantityButton(
//                         icon: Icons.add,
//                         onPressed: () {
//                           cartProvider.incrementQuantity(cartItem.product.id);
//                         },
//                         backgroundColor: Colors.transparent,
//                         iconColor: Color(0xFFFFFFFF),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 8),
//
//               // Botón eliminar
//               // _QuantityButton(
//               //   icon: Icons.delete_rounded,
//               //   onPressed: () {
//               //
//               //   },
//               //   backgroundColor: Color(0xFFF28482).withOpacity(0.1),
//               //   iconColor: Color(0xFFF28482),
//               // ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _QuantityButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onPressed;
//   final Color backgroundColor;
//   final Color iconColor;
//
//   const _QuantityButton({
//     required this.icon,
//     required this.onPressed,
//     required this.backgroundColor,
//     required this.iconColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 32,
//       height: 32,
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         shape: BoxShape.circle,
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16),
//           onTap: onPressed,
//           child: Icon(
//             icon,
//             size: 18,
//             color: iconColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
