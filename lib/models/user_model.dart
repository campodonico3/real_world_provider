import 'package:flutter/cupertino.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? profileImg;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profileImg,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      debugPrint('[UserModel] - 📦 Parseando UserModel: $json');

      return UserModel(
        id: _parseInt(json['id']),
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String?,
        profileImg: json['profile_Img'] as String?,
        createdAt: _parseRequiredDateTime(
          json['created_at'] ?? json['createdAt'],
          fieldName: 'created_at',
        ),
        updatedAt: _parseDateTime(json['updated_at'] ?? json['updatedAt']),
      );
    } catch (e) {
      debugPrint('❌ Error parseando UserModel: $e');
      debugPrint('📄 JSON recibido: $json');
      debugPrint('📚 StackTrace: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_img': profileImg,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? profileImg,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImg: profileImg ?? this.profileImg,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper para parsear int de forma segura
  static int _parseInt(dynamic value) {
    if (value == null) {
      debugPrint('⚠️ ID es null, usando 0 como fallback');
      return 0;
    }
    if (value is int) return value;
    if (value is String){
      final parsed = int.tryParse(value);
      if (parsed != null) return parsed;
      debugPrint('⚠️ No se pudo parsear ID, usando 0 como fallback');
      return 0;
    }
    debugPrint('⚠️ Tipo de ID inválido: ${value.runtimeType}, usando 0');
    return 0;
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        debugPrint('[UserModel] - ⚠️ Error parseando fecha: $value');
        return null;
      }
    }

    debugPrint('[UserModel] - ⚠️ Tipo de fecha inválido: ${value.runtimeType}');
    return null;
  }

  static DateTime _parseRequiredDateTime(dynamic value, {
    String fieldName = 'date',
  }) {
    final parsed = _parseDateTime(value);
    if (parsed != null) {
      return parsed;
    }
    debugPrint(
        '[UserModel] - Campo requerido "$fieldName" no válido o ausente: $value');
    throw const FormatException('Invalid required DateTime value');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.id == id &&
        other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;

  @override
  String toString() => 'UserModel(id: $id, name: $name, email: $email)';
}