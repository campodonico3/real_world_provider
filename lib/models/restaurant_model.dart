import '';

import 'package:real_world_provider/models/user_model.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final String? logoUrl;
  final List<String> categories;
  final double rating;
  final int reviewCount;
  final int  estimatedDeliveryTime; // in minutes
  final double deliveryFee; // in dollars
  final double minimumOrderAmount; // in dollars
  final bool isOpen;
  final List<WorkingHours> workingHours;
  final Address address;
  final List<String> tags; // "Popular", "New", "Discount", etc.
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final String? phoneNumber;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    this.logoUrl,
    required this.categories,
    required this.rating,
    required this.reviewCount,
    required this.estimatedDeliveryTime,
    required this.deliveryFee,
    required this.minimumOrderAmount,
    required this.isOpen,
    required this.workingHours,
    required this.address,
    this.tags = const [],
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
    this.phoneNumber,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    try {
      return Restaurant(
        id: _validateString(json['id'], 'id'),
        name: _validateString(json['name'], 'name'),
        description: _validateString(json['description'], 'description'),
        imageUrl: _validateUrl(json['imageUrl']),
        logoUrl: _validateUrl(json['logoUrl']),
        categories: _parseStringList(json['categories'], 'categories'),
        rating: _validateRating(json['rating']),
        reviewCount: _validateNonNegativeInt(json['reviewCount'], 'reviewCount'),
        estimatedDeliveryTime: _validatePositiveInt(json['estimatedDeliveryTime'], 'estimatedDeliveryTime'),
        deliveryFee: _validateNonNegativeDouble(json['deliveryFee'], 'deliveryFee'),
        minimumOrderAmount: _validateNonNegativeDouble(json['minimumOrderAmount'], 'minimumOrderAmount'),
        isOpen: json['isOpen'] == true,
        workingHours: _parseWorkingHours(json['workingHours']),
        address: Address.fromJson(json['address'] ?? {}),
        tags: _parseStringList(json['tags']) ?? [],
        createdAt: _parseDateTime(json['createdAt'], 'createdAt'),
        updatedAt: json['updatedAt'] != null
            ? _parseDateTime(json['updatedAt'], 'updatedAt')
            : null,
        isActive: json['isActive'] ?? true,
        phoneNumber: json['phoneNumber']?.toString().trim(),
      );
    } catch (e) {
      throw FormatException('Error parsing Restaurant from JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'categories': categories,
      'rating': rating,
      'reviewCount': reviewCount,
      'estimatedDeliveryTime': estimatedDeliveryTime,
      'deliveryFee': deliveryFee,
      'minimumOrder': minimumOrderAmount,
      'isOpen': isOpen,
      'workingHours': workingHours.map((wh) => wh.toJson()).toList(),
      'address': address.toJson(),
      'tags': tags,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'isActive': isActive,
    };

    // Solo incluir campos opcionales si no son null o vacíos
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      map['imageUrl'] = imageUrl;
    }
    if (logoUrl != null && logoUrl!.isNotEmpty) {
      map['logoUrl'] = logoUrl;
    }
    if (updatedAt != null) {
      map['updatedAt'] = updatedAt!.toUtc().toIso8601String();
    }
    if (phoneNumber != null && phoneNumber!.isNotEmpty) {
      map['phoneNumber'] = phoneNumber;
    }

    return map;
  }

  Restaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? logoUrl,
    List<String>? categories,
    double? rating,
    int? reviewCount,
    int? estimatedDeliveryTime,
    double? deliveryFee,
    double? minimumOrderAmount,
    bool? isOpen,
    List<WorkingHours>? workingHours,
    Address? address,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    String? phoneNumber,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      logoUrl: logoUrl ?? this.logoUrl,
      categories: categories ?? this.categories,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      minimumOrderAmount: minimumOrderAmount ?? this.minimumOrderAmount,
      isOpen: isOpen ?? this.isOpen,
      workingHours: workingHours ?? this.workingHours,
      address: address ?? this.address,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Restaurant && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Restaurant(id: $id, name: $name, rating: $rating)';

  // Métodos helper específicos del negocio
  bool get hasImages => imageUrl != null || logoUrl != null;
  bool get isPopular => tags.contains('Popular') || rating >= 4.5;
  String get formattedDeliveryTime => '$estimatedDeliveryTime min';
  String get formattedDeliveryFee => deliveryFee > 0 ? '\$${deliveryFee.toStringAsFixed(2)}' : 'Gratis';

  // Métodos de validación estáticos
  static String _validateString(dynamic value, String fieldName) {
    if (value == null || value.toString().trim().isEmpty) {
      throw ArgumentError('$fieldName cannot be null or empty');
    }
    return value.toString().trim();
  }

  static String? _validateUrl(dynamic value) {
    if (value == null) return null;
    final url = value.toString().trim();
    if (url.isEmpty) return null;

    final uri = Uri.tryParse(url);
    if (uri == null || (!uri.hasScheme || (uri.scheme != 'http' && uri.scheme != 'https'))) {
      throw ArgumentError('Invalid URL format: $url');
    }
    return url;
  }

  static List<String> _parseStringList(dynamic value, [String? fieldName]) {
    if (value == null) return fieldName != null ? [] : [];

    if (value is List) {
      return value.map((e) => e.toString().trim()).where((s) => s.isNotEmpty).toList();
    } else if (value is String) {
      // En caso de que venga como string separado por comas
      return value.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    }

    if (fieldName != null) {
      throw ArgumentError('Invalid $fieldName format: $value');
    }
    return [];
  }

  static double _validateRating(dynamic value) {
    if (value == null) return 0.0;
    final rating = (value is num) ? value.toDouble() : double.tryParse(value.toString());

    if (rating == null) {
      throw ArgumentError('Invalid rating format: $value');
    }

    if (rating < 0.0 || rating > 5.0) {
      throw ArgumentError('Rating must be between 0.0 and 5.0: $rating');
    }

    return rating;
  }

  static int _validateNonNegativeInt(dynamic value, String fieldName) {
    if (value == null) return 0;
    final intValue = (value is num) ? value.toInt() : int.tryParse(value.toString());

    if (intValue == null) {
      throw ArgumentError('Invalid $fieldName format: $value');
    }

    if (intValue < 0) {
      throw ArgumentError('$fieldName cannot be negative: $intValue');
    }

    return intValue;
  }

  static int _validatePositiveInt(dynamic value, String fieldName) {
    final intValue = _validateNonNegativeInt(value, fieldName);

    if (intValue <= 0) {
      throw ArgumentError('$fieldName must be positive: $intValue');
    }

    return intValue;
  }

  static double _validateNonNegativeDouble(dynamic value, String fieldName) {
    if (value == null) return 0.0;
    final doubleValue = (value is num) ? value.toDouble() : double.tryParse(value.toString());

    if (doubleValue == null) {
      throw ArgumentError('Invalid $fieldName format: $value');
    }

    if (doubleValue < 0.0) {
      throw ArgumentError('$fieldName cannot be negative: $doubleValue');
    }

    return doubleValue;
  }

  static List<WorkingHours> _parseWorkingHours(dynamic value) {
    if (value == null) return [];

    if (value is List) {
      return value.map((wh) => WorkingHours.fromJson(wh)).toList();
    }

    throw ArgumentError('Invalid workingHours format: $value');
  }

  static DateTime _parseDateTime(dynamic value, String fieldName) {
    if (value == null) {
      throw ArgumentError('$fieldName cannot be null');
    }

    if (value is String) {
      return DateTime.parse(value);
    } else if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else {
      throw ArgumentError('Invalid $fieldName format: $value');
    }
  }
}


class WorkingHours {
  final DayOfWeek day;
  final String openTime; // Formato "HH:mm" / "09:00" format
  final String closeTime; // Formato "HH:mm" / "21:00" format
  final bool isClosed;

  const WorkingHours({
    required this.day,
    required this.openTime,
    required this.closeTime,
    this.isClosed = false,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> json) {
    try {
      return WorkingHours(
        day: _parseDayOfWeek(json['day']),
        openTime: _validateTimeString(json['openTime'], 'openTime'),
        closeTime: _validateTimeString(json['closeTime'], 'closeTime'),
        isClosed: json['isClosed'] == true,
      );
    } catch (e) {
      throw FormatException('Error parsing WorkingHours from JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day.name,
      'openTime': openTime,
      'closeTime': closeTime,
      'isClosed': isClosed,
    };
  }

  WorkingHours copyWith({
    DayOfWeek? day,
    String? openTime,
    String? closeTime,
    bool? isClosed,
  }) {
    return WorkingHours(
      day: day ?? this.day,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      isClosed: isClosed ?? this.isClosed,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkingHours &&
        other.day == day &&
        other.openTime == openTime &&
        other.closeTime == closeTime;
  }

  @override
  int get hashCode => Object.hash(day, openTime, closeTime);

  @override
  String toString() => 'WorkingHours(${day.displayName}: $openTime-$closeTime${isClosed ? " (Closed)" : ""})';

  // Métodos helper específicos del negocio
  String get displaySchedule {
    if (isClosed) return 'Cerrado';
    return '$openTime - $closeTime';
  }

  bool isOpenAt(String time) {
    if (isClosed) return false;
    return time.compareTo(openTime) >= 0 && time.compareTo(closeTime) <= 0;
  }

  static DayOfWeek _parseDayOfWeek(dynamic value) {
    if (value == null) throw ArgumentError('day cannot be null');

    final stringValue = value.toString().toLowerCase();
    return DayOfWeek.values.firstWhere(
          (day) => day.name.toLowerCase() == stringValue,
      orElse: () => throw ArgumentError('Invalid day format: $value'),
    );
  }

  static String _validateTimeString(dynamic value, String fieldName) {
    if (value == null) throw ArgumentError('$fieldName cannot be null');

    final timeString = value.toString().trim();
    final timeRegex = RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$');

    if (!timeRegex.hasMatch(timeString)) {
      throw ArgumentError('Invalid $fieldName format (expected HH:mm): $timeString');
    }

    return timeString;
  }
}

enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String get displayName {
    switch (this) {
      case DayOfWeek.monday:
        return 'Lunes';
      case DayOfWeek.tuesday:
        return 'Martes';
      case DayOfWeek.wednesday:
        return 'Miércoles';
      case DayOfWeek.thursday:
        return 'Jueves';
      case DayOfWeek.friday:
        return 'Viernes';
      case DayOfWeek.saturday:
        return 'Sábado';
      case DayOfWeek.sunday:
        return 'Domingo';
    }
  }

  String get shortName {
    switch (this) {
      case DayOfWeek.monday:
        return 'Lun';
      case DayOfWeek.tuesday:
        return 'Mar';
      case DayOfWeek.wednesday:
        return 'Mié';
      case DayOfWeek.thursday:
        return 'Jue';
      case DayOfWeek.friday:
        return 'Vie';
      case DayOfWeek.saturday:
        return 'Sáb';
      case DayOfWeek.sunday:
        return 'Dom';
    }
  }

  bool get isWeekend => this == DayOfWeek.saturday || this == DayOfWeek.sunday;
}

class RestaurantCategory {
  final String id;
  final String name;
  final String? iconUrl;
  final String? imageUrl;
  final int sortOrder; // Orden de clasificación en la app
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const RestaurantCategory({
    required this.id,
    required this.name,
    this.iconUrl,
    this.imageUrl,
    required this.sortOrder,
    this.description,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });

  factory RestaurantCategory.fromJson(Map<String, dynamic> json) {
    try {
      return RestaurantCategory(
        id: _validateString(json['id'], 'id'),
        name: _validateString(json['name'], 'name'),
        iconUrl: _validateUrl(json['iconUrl']),
        imageUrl: _validateUrl(json['imageUrl']),
        sortOrder: _validateNonNegativeInt(json['sortOrder'], 'sortOrder'),
        description: json['description']?.toString().trim(),
        isActive: json['isActive'] ?? true,
        createdAt: _parseDateTime(json['createdAt'], 'createdAt'),
        updatedAt: json['updatedAt'] != null
            ? _parseDateTime(json['updatedAt'], 'updatedAt')
            : null,
      );
    } catch (e) {
      throw FormatException('Error parsing RestaurantCategory from JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'sortOrder': sortOrder,
      'isActive': isActive,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };

    // Solo incluir campos opcionales si no son null o vacíos
    if (iconUrl != null && iconUrl!.isNotEmpty) {
      map['iconUrl'] = iconUrl;
    }
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      map['imageUrl'] = imageUrl;
    }
    if (description != null && description!.isNotEmpty) {
      map['description'] = description;
    }
    if (updatedAt != null) {
      map['updatedAt'] = updatedAt!.toUtc().toIso8601String();
    }

    return map;
  }

  RestaurantCategory copyWith({
    String? id,
    String? name,
    String? iconUrl,
    String? imageUrl,
    int? sortOrder,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RestaurantCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      iconUrl: iconUrl ?? this.iconUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      sortOrder: sortOrder ?? this.sortOrder,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RestaurantCategory && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'RestaurantCategory(id: $id, name: $name, sortOrder: $sortOrder)';

  // Métodos helper específicos del negocio
  bool get hasIcon => iconUrl != null && iconUrl!.isNotEmpty;
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  static String _validateString(dynamic value, String fieldName) {
    if (value == null || value.toString().trim().isEmpty) {
      throw ArgumentError('$fieldName cannot be null or empty');
    }
    return value.toString().trim();
  }

  static String? _validateUrl(dynamic value) {
    if (value == null) return null;
    final url = value.toString().trim();
    if (url.isEmpty) return null;

    final uri = Uri.tryParse(url);
    if (uri == null || (!uri.hasScheme || (uri.scheme != 'http' && uri.scheme != 'https'))) {
      throw ArgumentError('Invalid URL format: $url');
    }
    return url;
  }

  static int _validateNonNegativeInt(dynamic value, String fieldName) {
    if (value == null) return 0;
    final intValue = (value is num) ? value.toInt() : int.tryParse(value.toString());

    if (intValue == null) {
      throw ArgumentError('Invalid $fieldName format: $value');
    }

    if (intValue < 0) {
      throw ArgumentError('$fieldName cannot be negative: $intValue');
    }

    return intValue;
  }

  static DateTime _parseDateTime(dynamic value, String fieldName) {
    if (value == null) {
      throw ArgumentError('$fieldName cannot be null');
    }

    if (value is String) {
      return DateTime.parse(value);
    } else if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else {
      throw ArgumentError('Invalid $fieldName format: $value');
    }
  }

}