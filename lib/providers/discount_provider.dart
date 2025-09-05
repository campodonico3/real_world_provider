import 'package:flutter/foundation.dart';
import '../models/discount_model.dart';
import 'dart:developer' as developer;

enum DiscountStatus { none, loading, applied, invalid, expired }

class DiscountProvider with ChangeNotifier {
  // Base de datos simulada de códigos de descuento
  final List<DiscountCode> _availableCodes = [
    DiscountCode(
      code: 'SAVE10',
      percentage: 10.0,
      description: 'Save 10% on orders over \$50',
    ),
    DiscountCode(
      code: 'WELCOME20',
      percentage: 20.0,
      minAmount: 50.0,
      description: 'Save 20% on orders over \$50',
    ),
    DiscountCode(
      code: 'STUDENT15',
      percentage: 5.0,
      description: '15% off for students',
    ),
  ];

  // Estado del descuento
  AppliedDiscount? _appliedDiscount; // Guarda el descuento aplicado (o null si no hay ninguno)
  DiscountStatus _status = DiscountStatus.none; // Guarda el estado de descuento
  String _errorMessage = ''; // Texto de error

  // Getters
  AppliedDiscount? get appliedDiscount => _appliedDiscount;
  DiscountStatus get status => _status;
  String get errorMessage => _errorMessage;
  bool get hasDiscount => _appliedDiscount != null;

  // Calcular descuento para un total dado
  // ---> Nota: aquí devolvemos el monto ya "fijado" cuando se aplicó el cupón.
  double calculateDiscountAmount(double originalTotal) {
    if (!hasDiscount) {
      if (kDebugMode) {
        debugPrint(
          '[DiscountProvider] calculateDiscountAmount called but no discount',
        );
      }
      return 0.0;
    }
    return originalTotal * (_appliedDiscount!.discountCode.percentage / 100);
  }

  // Calcular el total final con el descuento aplicado
  double calculateFinalTotal(double originalTotal) {
    return originalTotal - calculateDiscountAmount(originalTotal);
  }

  // Aplicar el código de descuento
  Future<void> applyDiscountCode(String code, double cartTotal) async {
    debugPrint(
      "🔍 [DiscountProvider] - Iniciando validación del código: $code con carrito = $cartTotal",
    );

    _status = DiscountStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      // Simulamos delay de validación como si fuera una llamada a API
      await Future.delayed(Duration(seconds: 2));
      debugPrint("⏳ Simulación de delay completada...");

      // Buscar el código en la "base de datos"
      final discountCode = _availableCodes.firstWhere(
        (discount) => discount.code.toUpperCase() == code.toUpperCase(),
        orElse: () {
          debugPrint("❌ Código no encontrado: $code");
          return DiscountCode(code: '', percentage: 0, description: '');
        },
      );

      // Validar código
      if (discountCode.code.isEmpty) {
        _status = DiscountStatus.invalid;
        _errorMessage = 'Invalid discount code';
        _appliedDiscount = null;
        debugPrint("⚠️ Código inválido: $code");
      } else if (!discountCode.isActive) {
        _status = DiscountStatus.expired;
        _errorMessage = 'This discount code has expired';
        _appliedDiscount = null;
        debugPrint("⛔ Código expirado: ${discountCode.code}");
      } else if (cartTotal < discountCode.minAmount) {
        _status = DiscountStatus.invalid;
        _errorMessage =
            'Minimum order amount: \$${discountCode.minAmount.toStringAsFixed(2)}';
        _appliedDiscount = null;
        debugPrint("⚠️ No cumple monto mínimo: ${discountCode.minAmount}");
      } else {
        // ✅ Código válido
        _status = DiscountStatus.applied;
        _errorMessage = '';
        _appliedDiscount = AppliedDiscount(
          discountCode: discountCode,
          discountAmount: calculateDiscountAmount(cartTotal),
        );
        debugPrint(
          "✅ Código aplicado: ${discountCode.code}",
        );
      }
    } catch (e, stackTrace) {
      // 🚨 Manejo seguro de errores inesperados
      _status = DiscountStatus.invalid;
      _errorMessage = 'Unexpected error while applying discount';
      _appliedDiscount = null;
      debugPrint("❌ Error inesperado: $e");
      debugPrint("📄 StackTrace: $stackTrace");
    }

    notifyListeners();
  }

  // 🗑️ Remover descuento
  void removeDiscount() {
    debugPrint("🗑️ Eliminando descuento aplicado");
    _appliedDiscount = null;
    _status = DiscountStatus.none;
    _errorMessage = '';
    notifyListeners();
  }

  // 🎯 Obtener códigos disponibles para debbuging
  List<DiscountCode> get availableCodes => _availableCodes;
}
