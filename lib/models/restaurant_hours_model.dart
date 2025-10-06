class RestaurantHoursModel {
  final int id;
  final int restaurantId;
  final int dayOfWeek; // 0 = Domingo, 6 = Sábado
  final String openTime;
  final String closeTime;
  final bool isClosed;
  final DateTime createdAt;

  const RestaurantHoursModel({
    required this.id,
    required this.restaurantId,
    required this.dayOfWeek,
    required this.openTime,
    required this.closeTime,
    required this.isClosed,
    required this.createdAt,
  });

  factory RestaurantHoursModel.fromJson(Map<String, dynamic> json) {
    return RestaurantHoursModel(
      id: json['id'] as int,
      restaurantId: json['restaurant_id'] as int,
      dayOfWeek: json['day_of_week'] as int,
      openTime: json['open_time'] as String,
      closeTime: json['close_time'] as String,
      isClosed: json['is_closed'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant_id': restaurantId,
      'day_of_week': dayOfWeek,
      'open_time': openTime,
      'close_time': closeTime,
      'is_closed': isClosed,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get dayName {
    const days = [
      'Domingo',
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado'
    ];
    return days[dayOfWeek];
  }

  String get schedule {
    if (isClosed) return 'Cerrado';
    return '$openTime - $closeTime';
  }

  RestaurantHoursModel copyWith({
    int? id,
    int? restaurantId,
    int? dayOfWeek,
    String? openTime,
    String? closeTime,
    bool? isClosed,
    DateTime? createdAt,
  }) {
    return RestaurantHoursModel(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      isClosed: isClosed ?? this.isClosed,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}