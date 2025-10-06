enum PaymentMethod {
  cash,
  card,
  yape,
  plin,
  digitalWallet;

  String get displayName {
    switch (this) {
      case PaymentMethod.cash:
        return 'Efectivo';
      case PaymentMethod.card:
        return 'Tarjeta';
      case PaymentMethod.yape:
        return 'Yape';
      case PaymentMethod.plin:
        return 'Plin';
      case PaymentMethod.digitalWallet:
        return 'Billetera Digital';
    }
  }

  static PaymentMethod fromString(String value) {
    final camelCase = value.replaceAllMapped(
      RegExp(r'_([a-z])'),
          (match) => match.group(1)!.toUpperCase(),
    );
    return PaymentMethod.values.firstWhere(
          (e) => e.name == camelCase,
      orElse: () => PaymentMethod.cash,
    );
  }
}