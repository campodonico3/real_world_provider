import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/discount_model.dart';
import 'dart:developer' as developer;

enum DiscountStatus { none, loading, applied, invalid, expired, belowMinimum }

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
  AppliedDiscount?
  _appliedDiscount; // Guarda el descuento aplicado (o null si no hay ninguno)
  DiscountStatus _status = DiscountStatus.none; // Guarda el estado de descuento
  String _errorMessage = ''; // Texto de error
  String _warningMessage = '';

  // Getters
  AppliedDiscount? get appliedDiscount => _appliedDiscount;

  DiscountStatus get status => _status;

  String get errorMessage => _errorMessage;

  String get warningMessage => _warningMessage;

  bool get hasDiscount => _appliedDiscount != null;

  // Calcular descuento para un total dado
  // ---> Nota: aquí devolvemos el monto ya "fijado" cuando se aplicó el cupón.
  // double calculateDiscountAmount(double originalTotal) {
  //   if (!hasDiscount) {
  //     return 0.0;
  //   }
  //   return originalTotal * (_appliedDiscount!.discountCode.percentage / 100);
  // }

  // 🆕
  double calculateDiscountAmount(double originalTotal) {
    if (!hasDiscount) {
      debugPrint('No tiene descuento ');
      return 0.0;
    }

    final discountCode = _appliedDiscount!.discountCode;

    // Validación Dinámica: Verificar si aún cumple con minAmount
    if (originalTotal < discountCode.minAmount) {
      // Actualizamos estado a "below minimum" pero NO eliminamos el cupón
      if (_status != DiscountStatus.belowMinimum) {
        _status = DiscountStatus.belowMinimum;
        _warningMessage =
            "Add \$${(discountCode.minAmount - originalTotal).toStringAsFixed(2)} more to use this discount";
        debugPrint(
          '[DiscountProvider] Discount suspended: below minimum amount',
        );

        // Notificar el cambio de estado
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
      }
      return 0.0;
    }

    // Descuento Válido: Calcular dinamicamente
    if (_status != DiscountStatus.applied) {
      _status = DiscountStatus.applied;
      _warningMessage = '';
      debugPrint('[DiscountProvider] - Discount reactivated');

      // Notificar el cambio de estado
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }

    final calculatedDiscount = originalTotal * (discountCode.percentage / 100);
    debugPrint(
      '[New] Discount calculated: \$${calculatedDiscount.toStringAsFixed(2)}',
    );
    return calculatedDiscount;
  }

  // Calcular el total final con el descuento aplicado
  double calculateFinalTotal(double originalTotal) {
    return originalTotal - calculateDiscountAmount(originalTotal);
  }

  // Aplicar el código de descuento
  Future<void> applyDiscountCode(String code, double cartTotal) async {
    // Evitar aplicaciones múltiples
    if (_status == DiscountStatus.loading) {
      debugPrint('[DiscountProvider] Already processing a discount code');
      return;
    }

    _status = DiscountStatus.loading;
    _errorMessage = '';
    _warningMessage = '';
    notifyListeners();

    debugPrint(
      '🔍 [DiscountProvider] Validating code="$code" for subtotal=\$${cartTotal.toStringAsFixed(2)}',
    );

    try {
      // Simulamos delay de validación como si fuera una llamada a API
      await Future.delayed(Duration(seconds: 2));
      debugPrint("⏳ Simulación de delay completada...");

      // Buscar el código en la "base de datos"
      DiscountCode? foundCode;
      try {
        foundCode = _availableCodes.firstWhere(
          (discount) => discount.code.toUpperCase() == code.toUpperCase(),
        );
      } catch (_) {
        foundCode = null;
      }

      // Validaciones de aplicación
      if (foundCode == null) {
        _status = DiscountStatus.invalid;
        _errorMessage = 'Invalid discount code';
        _appliedDiscount = null;
        debugPrint('[DiscountProvide] Code not found: $code');
      } else if (!foundCode.isActive) {
        _status = DiscountStatus.expired;
        _errorMessage = 'This discount code has expired';
        _appliedDiscount = null;
        debugPrint('[DiscountProvider] Code expired: ${foundCode.code}');
      } else if (cartTotal < foundCode.minAmount) {
        _status = DiscountStatus.invalid;
        _errorMessage =
            'Minimum order amount : \$${foundCode.minAmount.toStringAsFixed(2)}';
        _appliedDiscount = null;
        debugPrint(
          '[DiscountProvider] Below minimum: needs \$${foundCode.minAmount}, has \$${cartTotal.toStringAsFixed(2)}',
        );
      } else {
        // Código Válido: Aplicamos el descuento
        final calculatedDiscount = cartTotal * (foundCode.percentage / 100);
        _appliedDiscount = AppliedDiscount(
          discountCode: foundCode,
          discountAmount: calculatedDiscount, // Solo para referencia histórica
        );
        _status = DiscountStatus.applied;
        _errorMessage = '';
        _warningMessage = '';

        debugPrint(
          '[DiscountProvider] ✅ Code applied: ${foundCode.code} = -\$${appliedDiscount?.discountAmount}',
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
