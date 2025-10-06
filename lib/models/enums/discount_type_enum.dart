enum DiscountType {
  percentage,
  fixed;

  String get displayName {
    switch (this) {
      case DiscountType.percentage:
        return 'Porcentaje';
      case DiscountType.fixed:
        return 'Monto fijo';
    }
  }

  static DiscountType fromString(String value) {
    return DiscountType.values.firstWhere(
          (e) => e.name == value,
      orElse: () => DiscountType.fixed,
    );
  }
}