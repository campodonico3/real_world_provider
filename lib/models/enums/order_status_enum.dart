enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  onDelivery,
  delivered,
  cancelled,
  rejected;

  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pendiente';
      case OrderStatus.confirmed:
        return 'Confirmado';
      case OrderStatus.preparing:
        return 'En preparación';
      case OrderStatus.ready:
        return 'Listo';
      case OrderStatus.onDelivery:
        return 'En camino';
      case OrderStatus.delivered:
        return 'Entregado';
      case OrderStatus.cancelled:
        return 'Cancelado';
      case OrderStatus.rejected:
        return 'Rechazado';
    }
  }

  static OrderStatus fromString(String value) {
    // Convertir snake_case a camelCase
    final camelCase = value.replaceAllMapped(
      RegExp(r'_([a-z])'),
          (match) => match.group(1)!.toUpperCase(),
    );
    return OrderStatus.values.firstWhere(
          (e) => e.name == camelCase,
      orElse: () => OrderStatus.pending,
    );
  }
}