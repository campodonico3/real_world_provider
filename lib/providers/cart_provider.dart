// import 'package:flutter/foundation.dart';
//
// import '../models/cart_model.dart';
// import '../models/product_model.dart';
//
// class CartProvider with ChangeNotifier {
//   final Map<String, CartItem> _items = {};
//
//   Map<String, CartItem> get items => _items;
//
//   void addToCart(Product product) {
//     if (_items.containsKey(product.id)) {
//       _items.update(
//         product.id,
//         (existingItem) => CartItem(
//           product: existingItem.product,
//           quantity: existingItem.quantity + 1,
//         ),
//       );
//     } else {
//       _items.putIfAbsent(product.id, () => CartItem(product: product));
//     }
//     notifyListeners();
//   }
//
//   // Incrementar la cantidad de un producto específico
//   void incrementQuantity(String productId) {
//     if (_items.containsKey(productId)) {
//       _items.update(
//         productId,
//         (existingItem) => CartItem(
//           product: existingItem.product,
//           quantity: existingItem.quantity + 1,
//         ),
//       );
//       notifyListeners();
//     }
//   }
//
//   // Decrementar la cantidad de un producto específico
//   void decrementQuantity(String productId) {
//     if (_items.containsKey(productId)) {
//       if (_items[productId]!.quantity > 1) {
//         // Si hay mas de 1, solo  reduce la cantidad
//         _items.update(
//           productId,
//           (existingItem) => CartItem(
//             product: existingItem.product,
//             quantity: existingItem.quantity - 1,
//           ),
//         );
//       } else {
//         // Si solo queda 1 item, eliminamos el producto completamente
//         _items.remove(productId);
//       }
//       notifyListeners();
//     }
//   }
//
//   // Añadir cantidad específica al carrito
//   void addToCartWithQuantity(Product product, int quantity) {
//     if (quantity <= 0) return;
//     if (_items.containsKey(product.id)) {
//       _items.update(
//         product.id,
//         (existingItem) => CartItem(
//           product: existingItem.product,
//           quantity: existingItem.quantity + quantity,
//         ),
//       );
//     } else {
//       _items.putIfAbsent(
//         product.id,
//         () => CartItem(product: product, quantity: quantity),
//       );
//     }
//     notifyListeners();
//   }
//
//   // Actualizar cantidad específica
//   void updateQuantity(String productId, int newQuantity) {
//     if (newQuantity <= 0) {
//       removeFromCart(productId);
//       return;
//     }
//     if (_items.containsKey(productId)) {
//       _items.update(
//         productId,
//             (existingItem) =>
//             CartItem(product: existingItem.product, quantity: newQuantity),
//       );
//       notifyListeners();
//     }
//   }
//
//   // Función para obtener la cantidad de un produto específico
//   int getQuantityForProduct(String productId){
//     return _items.containsKey(productId) ? _items[productId]!.quantity : 0;
//   }
//
//   // Función para verificar si el producto está en el carrito
//   bool isInCart(String productId) {
//     return _items.containsKey(productId);
//   }
//
//   void removeFromCart(String productId) {
//     if (_items.containsKey(productId)) {
//       _items.remove(productId);
//       notifyListeners();
//     }
//   }
//
//   // Función para vaciar el carrito por completo
//   void clearCart() {
//     _items.clear();
//     notifyListeners();
//   }
//
//   double get subtotal => _items.values.fold(
//     0.0,
//     (sum, cartItem) => sum + cartItem.product.price * cartItem.quantity,
//   );
//
//   double get totalPrice => subtotal;
//   bool get isEmpty => _items.isEmpty;
//   int get itemCount => _items.length;
//   bool get noVacia => _items.isNotEmpty;
// }
