import 'package:flutter/foundation.dart';

class RestaurantCategoryModel {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final String? iconUrl;
  final bool isActive;
  final int displayOrder;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const RestaurantCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.iconUrl,
    required this.isActive,
    required this.displayOrder,
    required this.createdAt,
    this.updatedAt,
  });

  factory RestaurantCategoryModel.fromJson(Map<String, dynamic> json) {
    try {
      return RestaurantCategoryModel(
        id: _parseInt(json['id']),
        name: json['name'] as String,
        slug: json['slug'] as String,
        description: json['description'] as String?,
        iconUrl: json['icon_Url'] as String?,
        isActive: json['is_Active'] as bool,
        displayOrder: json['display_Order'] as int? ?? 0,
        createdAt: _parseDateTime(json['created_at'] ?? json['createdAt']) ?? DateTime.now(),
        updatedAt: _parseDateTime(json['updated_at'] ?? json['updatedAt']),
      );
    } catch (e) {
      debugPrint('[RestaurantCategory] - ❌ Error parseando: $e');
      debugPrint('[RestaurantCategory] - 📄 JSON: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'icon_url': iconUrl,
      'is_active': isActive,
      'display_order': displayOrder,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  RestaurantCategoryModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? iconUrl,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RestaurantCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      isActive: isActive ?? this.isActive,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper para parsear int de forma segura
  static int _parseInt(dynamic value) {
    if (value == null) {
      debugPrint('[RestaurantCategory] - ⚠️ ID es null, usando 0');
      return 0;
    }
    if (value is int) return value;
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) return parsed;
      debugPrint('[RestaurantCategory] - ⚠️ No se pudo parsear ID');
      return 0;
    }
    return 0;
  }

  // Helper para parsear DateTime de forma segura
  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        debugPrint('[RestaurantCategory] - ⚠️ Error parseando fecha: $value');
        return null;
      }
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RestaurantCategoryModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'RestaurantCategory(id: $id, name: $name, slug: $slug)';
}