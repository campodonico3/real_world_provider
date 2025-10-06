import 'enums/discount_type_enum.dart';

class CouponModel {
  final int id;
  final String code;
  final String? description;

  // Tipo de descuento
  final DiscountType discountType;
  final double discountValue;

  // Restricciones
  final double? minimumOrderAmount;
  final double? maxDiscountAmount;
  final int maxUsesPerUser;
  final int? maxTotalUses;
  final int currentUses;

  // Aplicabilidad
  final int? restaurantId;

  // Vigencia
  final DateTime validFrom;
  final DateTime validUntil;
  final bool isActive;

  final DateTime createdAt;
  final DateTime? updatedAt;

  const CouponModel({
    required this.id,
    required this.code,
    this.description,
    required this.discountType,
    required this.discountValue,
    this.minimumOrderAmount,
    this.maxDiscountAmount,
    required this.maxUsesPerUser,
    this.maxTotalUses,
    required this.currentUses,
    this.restaurantId,
    required this.validFrom,
    required this.validUntil,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] as int,
      code: json['code'] as String,
      description: json['description'] as String?,
      discountType: DiscountType.fromString(json['discount_type'] as String),
      discountValue: double.parse(json['discount_value'].toString()),
      minimumOrderAmount: json['minimum_order_amount'] != null
          ? double.parse(json['minimum_order_amount'].toString())
          : null,
      maxDiscountAmount: json['max_discount_amount'] != null
          ? double.parse(json['max_discount_amount'].toString())
          : null,
      maxUsesPerUser: json['max_uses_per_user'] as int? ?? 1,
      maxTotalUses: json['max_total_uses'] as int?,
      currentUses: json['current_uses'] as int? ?? 0,
      restaurantId: json['restaurant_id'] as int?,
      validFrom: DateTime.parse(json['valid_from'] as String),
      validUntil: DateTime.parse(json['valid_until'] as String),
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'discount_type': discountType.name,
      'discount_value': discountValue.toString(),
      'minimum_order_amount': minimumOrderAmount?.toString(),
      'max_discount_amount': maxDiscountAmount?.toString(),
      'max_uses_per_user': maxUsesPerUser,
      'max_total_uses': maxTotalUses,
      'current_uses': currentUses,
      'restaurant_id': restaurantId,
      'valid_from': validFrom.toIso8601String(),
      'valid_until': validUntil.toIso8601String(),
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  bool get isValid {
    final now = DateTime.now();
    return isActive &&
        now.isAfter(validFrom) &&
        now.isBefore(validUntil) &&
        (maxTotalUses == null || currentUses < maxTotalUses!);
  }

  bool canBeAppliedTo(double orderAmount) {
    return isValid &&
        (minimumOrderAmount == null || orderAmount >= minimumOrderAmount!);
  }

  double calculateDiscount(double orderAmount) {
    if (!canBeAppliedTo(orderAmount)) return 0;

    double discount = 0;
    if (discountType == DiscountType.percentage) {
      discount = orderAmount * (discountValue / 100);
    } else {
      discount = discountValue;
    }

    // Aplicar límite máximo si existe
    if (maxDiscountAmount != null && discount > maxDiscountAmount!) {
      discount = maxDiscountAmount!;
    }

    return discount;
  }

  String get discountText {
    if (discountType == DiscountType.percentage) {
      return '${discountValue.toInt()}% de descuento';
    } else {
      return 'S/ ${discountValue.toStringAsFixed(2)} de descuento';
    }
  }

  CouponModel copyWith({
    int? id,
    String? code,
    String? description,
    DiscountType? discountType,
    double? discountValue,
    double? minimumOrderAmount,
    double? maxDiscountAmount,
    int? maxUsesPerUser,
    int? maxTotalUses,
    int? currentUses,
    int? restaurantId,
    DateTime? validFrom,
    DateTime? validUntil,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CouponModel(
      id: id ?? this.id,
      code: code ?? this.code,
      description: description ?? this.description,
      discountType: discountType ?? this.discountType,
      discountValue: discountValue ?? this.discountValue,
      minimumOrderAmount: minimumOrderAmount ?? this.minimumOrderAmount,
      maxDiscountAmount: maxDiscountAmount ?? this.maxDiscountAmount,
      maxUsesPerUser: maxUsesPerUser ?? this.maxUsesPerUser,
      maxTotalUses: maxTotalUses ?? this.maxTotalUses,
      currentUses: currentUses ?? this.currentUses,
      restaurantId: restaurantId ?? this.restaurantId,
      validFrom: validFrom ?? this.validFrom,
      validUntil: validUntil ?? this.validUntil,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}