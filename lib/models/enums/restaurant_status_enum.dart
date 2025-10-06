enum RestaurantStatus {
  active,
  inactive,
  suspended;

  String get displayName {
    switch (this) {
      case RestaurantStatus.active:
        return 'Activo';
      case RestaurantStatus.inactive:
        return 'Inactivo';
      case RestaurantStatus.suspended:
        return 'Suspendido';
    }
  }

  static RestaurantStatus fromString(String value) {
    return RestaurantStatus.values.firstWhere(
          (e) => e.name == value,
      orElse: () => RestaurantStatus.inactive,
    );
  }
}