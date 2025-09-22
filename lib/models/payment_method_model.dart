class PaymentMethod {
  final String id;
  final PaymentType type;
  final String displayName;
  final String? lastFourDigits;
  final String? expiryDate;
  final bool isDefault;

  const PaymentMethod({
    required this.id,
    required this.type,
    required this.displayName,
    this.lastFourDigits,
    this.expiryDate,
    this.isDefault = false,
  });
}

enum PaymentType {
  creditCard,
  debitCard,
  cash,
  digitalWallet,
  bankTransfer
}