class DiscountCode {
  final String code;
  final double percentage;
  final double minAmount;
  final String description;
  final bool isActive;

  DiscountCode({
    required this.code,
    required this.percentage,
    this.minAmount = 0.0,
    required this.description,
    this.isActive = true,
  });
}

// Estado del descuento aplicado
class AppliedDiscount {
  final DiscountCode discountCode;
  final double discountAmount;

  AppliedDiscount({
    required this.discountCode,
    required this.discountAmount,
  });
}

