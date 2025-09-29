class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? profileImg;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profileImg,
    required this.createdAt,
    this.updatedAt,
  });

  // Factory constructor con validación y manejo de errores
  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: _validateString(json['id'], 'id'),
        name: _validateString(json['name'], 'name'),
        email: _validateEmail(json['email']),
        phone: json['phone']?.toString().trim(),
        profileImg: json['profileImg']?.toString().trim(),
        createdAt: _parseDateTime(json['createdAt'], 'createdAt'),
        updatedAt: json['updatedAt'] != null
            ? _parseDateTime(json['updatedAt'], 'updatedAt')
            : null,
      );
    } catch (e) {
      throw FormatException('Error parsing User from JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'updatedAt': updatedAt?.toUtc().toIso8601String(),
    };

    // Solo incluir campos opcionales si no son null
    if (phone != null && phone!.isNotEmpty) {
      map['phone'] = phone;
    }
    if (profileImg != null && profileImg!.isNotEmpty) {
      map['profileImg'] = profileImg;
    }
    if (updatedAt != null) {
      map['updatedAt'] = updatedAt!.toUtc().toIso8601String();
    }

    return map;
  }

  // Método para crear copia con cambios
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImg,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImg: profileImg ?? this.profileImg,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'User(id: $id, name: $name, email: $email, phone: $phone, profileImg: $profileImg, createdAt: $createdAt, updatedAt: $updatedAt)';

  // Métodos de validación estáticos
  static String _validateString(dynamic value, String fieldName) {
    if (value == null || value
        .toString()
        .trim()
        .isEmpty) {
      throw ArgumentError('$fieldName cannot be null or empty');
    }
    return value.toString().trim();
  }

  static String _validateEmail(dynamic value) {
    final email = _validateString(value, 'email');
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) {
      throw ArgumentError('Invalid email format: $email');
    }
    return email;
  }

  static DateTime _parseDateTime(dynamic value, String fieldName) {
    if (value == null) {
      throw ArgumentError('$fieldName cannot be null');
    }

    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        final maybeInt = int.tryParse(value);
        if (maybeInt != null) {
          return _fromEpochGuess(maybeInt);
        }
      }
      throw ArgumentError('Invalid $fieldName format: $value');
    } else if (value is int) {
      return _fromEpochGuess(value);
    } else {
      throw ArgumentError('Invalid $fieldName type: $value');
    }
  }

  // helper: detecta si es segundos (10 dígitos) o ms (13 dígitos)
  static DateTime _fromEpochGuess(int epoch) {
    if (epoch.abs() < 10000000000) {
      // probablemente segundos
      return DateTime.fromMillisecondsSinceEpoch(epoch * 1000, isUtc: true).toLocal();
    } else {
      // probablemente milisegundos
      return DateTime.fromMillisecondsSinceEpoch(epoch, isUtc: true).toLocal();
    }
  }
}

class Address {
  final String id;
  final String userId;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final double latitude;
  final double longitude;
  final String? apartmentNumber;
  final String? deliveryInstructions;
  final AddressType type;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Address({
    required this.id,
    required this.userId,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
    this.apartmentNumber,
    this.deliveryInstructions,
    required this.type,
    this.isDefault = false,
    required this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    try {
      return Address(
        id: _validateString(json['id'], 'id'),
        userId: _validateString(json['userId'], 'userId'),
        street: _validateString(json['street'], 'street'),
        city: _validateString(json['city'], 'city'),
        state: _validateString(json['state'], 'state'),
        zipCode: _validateString(json['zipCode'], 'zipCode'),
        latitude: _validateCoordinate(json['latitude'], 'latitude', -90, 90),
        longitude: _validateCoordinate(
            json['longitude'], 'longitude', -180, 180),
        apartmentNumber: json['apartmentNumber']?.toString().trim(),
        deliveryInstructions: json['deliveryInstructions']?.toString().trim(),
        type: _parseAddressType(json['type']),
        isDefault: json['isDefault'] == true,
        createdAt: _parseDateTime(json['createdAt'], 'createdAt'),
        updatedAt: json['updatedAt'] != null
            ? _parseDateTime(json['updatedAt'], 'updatedAt')
            : null,
      );
    } catch (e) {
      throw FormatException('Error parsing Address from JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'userId': userId,
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'latitude': latitude,
      'longitude': longitude,
      'type': type.name,
      'isDefault': isDefault,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };

    // Solo incluir campos opcionales si no son null o vacíos
    if (apartmentNumber != null && apartmentNumber!.isNotEmpty) {
      map['apartmentNumber'] = apartmentNumber;
    }
    if (deliveryInstructions != null && deliveryInstructions!.isNotEmpty) {
      map['deliveryInstructions'] = deliveryInstructions;
    }
    if (updatedAt != null) {
      map['updatedAt'] = updatedAt!.toUtc().toIso8601String();
    }

    return map;
  }

  Address copyWith({
    String? id,
    String? userId,
    String? street,
    String? city,
    String? state,
    String? zipCode,
    double? latitude,
    double? longitude,
    String? apartmentNumber,
    String? deliveryInstructions,
    AddressType? type,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Address(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      apartmentNumber: apartmentNumber ?? this.apartmentNumber,
      deliveryInstructions: deliveryInstructions ?? this.deliveryInstructions,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Address && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Address(id: $id, street: $street, city: $city)';

  // Métodos de validación estáticos
  static String _validateString(dynamic value, String fieldName) {
    if (value == null || value
        .toString()
        .trim()
        .isEmpty) {
      throw ArgumentError('$fieldName cannot be null or empty');
    }
    return value.toString().trim();
  }

  static double _validateCoordinate(dynamic value, String fieldName, double min, double max) {
    if (value == null) {
      throw ArgumentError('$fieldName cannot be null');
    }

    if (value is String && value.trim().isEmpty) {
      throw ArgumentError('$fieldName cannot be empty');
    }

    final raw = value is String ? value.replaceAll(',', '.').trim() : value.toString();
    final coordinate = double.tryParse(raw);
    if (coordinate == null) {
      throw ArgumentError('Invalid $fieldName format: $value');
    }
    if (coordinate < min || coordinate > max) {
      throw ArgumentError('$fieldName must be between $min and $max: $coordinate');
    }
    return coordinate;
  }

  static AddressType _parseAddressType(dynamic value) {
    if (value == null) return AddressType.other;

    final stringValue = value.toString().toLowerCase();
    return AddressType.values.firstWhere(
          (type) => type.name.toLowerCase() == stringValue,
      orElse: () => AddressType.other,
    );
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
}

// Clase base para manejar respuestas de API (opcional)
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse(
      success: true,
      data: data,
    );
  }

  factory ApiResponse.error(String message, [int? statusCode]) {
    return ApiResponse(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }
}