import 'enums/address_type_enum.dart';

class AddressModel {
  final int id;
  final int userId;
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

  const AddressModel({
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
    required this.isDefault,
    required this.createdAt,
    this.updatedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zip_code'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      apartmentNumber: json['apartment_number'] as String?,
      deliveryInstructions: json['delivery_instructions'] as String?,
      type: AddressType.fromString(json['type'] as String),
      isDefault: json['is_default'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'street': street,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'latitude': latitude,
      'longitude': longitude,
      'apartment_number': apartmentNumber,
      'delivery_instructions': deliveryInstructions,
      'type': type.name,
      'is_default': isDefault,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  String get fullAddress {
    final parts = [street];
    if (apartmentNumber != null && apartmentNumber!.isNotEmpty) {
      parts.add('Apto. $apartmentNumber');
    }
    parts.addAll([city, state, zipCode]);
    return parts.join(', ');
  }

  AddressModel copyWith({
    int? id,
    int? userId,
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
    return AddressModel(
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
}