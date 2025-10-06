enum AddressType {
  home,
  work,
  other;

  String get displayName {
    switch (this) {
      case AddressType.home:
        return 'Casa';
      case AddressType.work:
        return 'Trabajo';
      case AddressType.other:
        return 'Otro';
    }
  }

  static AddressType fromString(String value) {
    return AddressType.values.firstWhere(
          (e) => e.name == value,
      orElse: () => AddressType.other,
    );
  }
}