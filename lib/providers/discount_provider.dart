// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import '../models/discount_model.dart';
// import 'dart:developer' as developer;
//
// import 'cart_provider.dart';
//
// enum DiscountStatus { none, loading, applied, invalid, expired, belowMinimum }
//
// class DiscountProvider with ChangeNotifier {
//   // Referenciamos a CartProvider para escuchar cambios autoamticamente
//   final CartProvider? _cartProvider;
//
//   // Constructor que recibe CartProvider
//   DiscountProvider (this._cartProvider){
//     // Escuchar cambios en el carrito automaticamente
//     _cartProvider?.addListener(_onCartChanged);
//   }
//
//   @override
//   void dispose() {
//     _cartProvider?.addListener(_onCartChanged);
//     super.dispose();
//   }
//
//   // Base de datos simulada de códigos de descuento
//   final List<DiscountCode> _availableCodes = [
//     DiscountCode(
//       code: 'SAVE10',
//       percentage: 10.0,
//       description: 'Save 10% on orders over \$50',
//     ),
//     DiscountCode(
//       code: 'WELCOME20',
//       percentage: 20.0,
//       minAmount: 50.0,
//       description: 'Save 20% on orders over \$50',
//     ),
//     DiscountCode(
//       code: 'STUDENT15',
//       percentage: 5.0,
//       description: '15% off for students',
//     ),
//   ];
//
//   // Estado del descuento
//   AppliedDiscount? _appliedDiscount; // Guarda el descuento aplicado (o null si no hay ninguno)
//   DiscountStatus _status = DiscountStatus.none; // Guarda el estado de descuento
//   String _errorMessage = ''; // Texto de error
//   String _warningMessage = '';
//
//   // Getters
//   AppliedDiscount? get appliedDiscount => _appliedDiscount;
//
//   DiscountStatus get status => _status;
//
//   String get errorMessage => _errorMessage;
//
//   String get warningMessage => _warningMessage;
//
//   bool get hasDiscount => _appliedDiscount != null;
//
//   // Calcular descuento para un total dado
//   // ---> Nota: aquí devolvemos el monto ya "fijado" cuando se aplicó el cupón.
//   // double calculateDiscountAmount(double originalTotal) {
//   //   if (!hasDiscount) {
//   //     return 0.0;
//   //   }
//   //   return originalTotal * (_appliedDiscount!.discountCode.percentage / 100);
//   // }
//
//   // 🆕 Método Automático: Se ejecuta cuando cambia el carrito (Con ChangeNotifierProxyProvider)
//   void _onCartChanged() {
//     if (!hasDiscount && _cartProvider == null) {
//       return;
//     }
//
//     debugPrint('🔄 [DiscountProvider] CartChanged - Recalculating discount...');
//
//     final currentTotal = _cartProvider!.subtotal;
//     final discountCode = _appliedDiscount!.discountCode;
//
//     // Validación automática del monto mínimo
//     if (currentTotal < discountCode.minAmount) {
//       if (_status != DiscountStatus.belowMinimum) {
//         _status = DiscountStatus.belowMinimum;
//         _warningMessage = 'Add \$${(discountCode.minAmount - currentTotal).toStringAsFixed(2)} more to use this discount';
//         debugPrint('[DiscountProvider] Auto-suspended: below minimum amount');
//         // No llamamos notifyListeners() aquí porque ya se notificará automaticamente
//       }
//     } else {
//       if (_status != DiscountStatus.applied) {
//         _status = DiscountStatus.applied;
//         _warningMessage = '';
//         debugPrint('[DiscountProvider] Auto-reactivated discount');
//       }
//     }
//
//   }
//
//   // Calcular descuento (sin validaciones dinámicas, ya las meneja _onCartChanged)
//   double calculateDiscountAmount(double originalTotal) {
//     if (!hasDiscount) {
//       return 0.0;
//     }
//
//     final discountCode = _appliedDiscount!.discountCode;
//
//     // Si está suspendido, no aplicar descuento
//     if (_status == DiscountStatus.belowMinimum) {
//       return 0.0;
//     }
//
//     return originalTotal * (discountCode.percentage / 100);
//   }
//
//   // Calcular el total final con el descuento aplicado
//   double calculateFinalTotal(double originalTotal) {
//     return originalTotal - calculateDiscountAmount(originalTotal);
//   }
//
//   // Aplicar el código de descuento
//   Future<void> applyDiscountCode(String code) async {
//     if (_cartProvider == null) {
//       debugPrint('[DiscountProvider] CartProvider is null');
//       return;
//     }
//
//     final cartTotal = _cartProvider.subtotal;
//
//     // Evitar aplicaciones múltiples
//     if (_status == DiscountStatus.loading) {
//       debugPrint('[DiscountProvider] Already processing a discount code');
//       return;
//     }
//
//     _status = DiscountStatus.loading;
//     _errorMessage = '';
//     _warningMessage = '';
//     notifyListeners();
//
//     debugPrint(
//       '🔍 [DiscountProvider] Validating code="$code" for subtotal=\$${cartTotal.toStringAsFixed(2)}',
//     );
//
//     try {
//       // Simulamos delay de validación como si fuera una llamada a API
//       await Future.delayed(Duration(seconds: 2));
//       debugPrint("⏳ Simulación de delay completada...");
//
//       // Buscar el código en la "base de datos"
//       DiscountCode? foundCode;
//       try {
//         foundCode = _availableCodes.firstWhere(
//           (discount) => discount.code.toUpperCase() == code.toUpperCase(),
//         );
//       } catch (_) {
//         foundCode = null;
//       }
//
//       // Validaciones de aplicación
//       if (foundCode == null) {
//         _status = DiscountStatus.invalid;
//         _errorMessage = 'Invalid discount code';
//         _appliedDiscount = null;
//         debugPrint('[DiscountProvide] Code not found: $code');
//       } else if (!foundCode.isActive) {
//         _status = DiscountStatus.expired;
//         _errorMessage = 'This discount code has expired';
//         _appliedDiscount = null;
//         debugPrint('[DiscountProvider] Code expired: ${foundCode.code}');
//       } else if (cartTotal < foundCode.minAmount) {
//         _status = DiscountStatus.invalid;
//         _errorMessage =
//             'Minimum order amount : \$${foundCode.minAmount.toStringAsFixed(2)}';
//         _appliedDiscount = null;
//         debugPrint(
//           '[DiscountProvider] Below minimum: needs \$${foundCode.minAmount}, has \$${cartTotal.toStringAsFixed(2)}',
//         );
//       } else {
//         // Código Válido: Aplicamos el descuento
//         final calculatedDiscount = cartTotal * (foundCode.percentage / 100);
//         _appliedDiscount = AppliedDiscount(
//           discountCode: foundCode,
//           discountAmount: calculatedDiscount, // Solo para referencia histórica
//         );
//         _status = DiscountStatus.applied;
//         _errorMessage = '';
//         _warningMessage = '';
//
//         debugPrint(
//           '[DiscountProvider] ✅ Code applied: ${foundCode.code} = -\$${appliedDiscount?.discountAmount}',
//         );
//       }
//     } catch (e, stackTrace) {
//       // 🚨 Manejo seguro de errores inesperados
//       _status = DiscountStatus.invalid;
//       _errorMessage = 'Unexpected error while applying discount';
//       _appliedDiscount = null;
//       debugPrint("❌ Error inesperado: $e");
//       debugPrint("📄 StackTrace: $stackTrace");
//     }
//     notifyListeners();
//   }
//
//   // 🗑️ Remover descuento
//   void removeDiscount() {
//     debugPrint("🗑️ Eliminando descuento aplicado");
//     _appliedDiscount = null;
//     _status = DiscountStatus.none;
//     _errorMessage = '';
//     notifyListeners();
//   }
//
//   // 🎯 Obtener códigos disponibles para debbuging
//   List<DiscountCode> get availableCodes => _availableCodes;
// }
