class ProductOptionModel {
  final int id;
  final int groupId;
  final String name;
  final double priceModifier;
  final bool isAvailable;
  final bool isDefault;
  final int displayOrder;
  final DateTime createdAt;

  const ProductOptionModel({
    required this.id,
    required this.groupId,
    required this.name,
    required this.priceModifier,
    required this.isAvailable,
    required this.isDefault,
    required this.displayOrder,
    required this.createdAt,
  });

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) {
    return ProductOptionModel(
      id: json['id'] as int,
      groupId: json['group_id'] as int,
      name: json['name'] as String,
      priceModifier: double.parse(json['price_modifier'].toString()),
      isAvailable: json['is_available'] as bool,
      isDefault: json['is_default'] as bool? ?? false,
      displayOrder: json['display_order'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'name': name,
      'price_modifier': priceModifier.toString(),
      'is_available': isAvailable,
      'is_default': isDefault,
      'display_order': displayOrder,
      'created_at': createdAt.toIso8601String(),
    };
  }

  bool get hasAdditionalCost => priceModifier > 0;

  String get priceText {
    if (priceModifier == 0) return '';
    return priceModifier > 0 ? '+S/ $priceModifier' : 'S/ $priceModifier';
  }

  ProductOptionModel copyWith({
    int? id,
    int? groupId,
    String? name,
    double? priceModifier,
    bool? isAvailable,
    bool? isDefault,
    int? displayOrder,
    DateTime? createdAt,
  }) {
    return ProductOptionModel(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      priceModifier: priceModifier ?? this.priceModifier,
      isAvailable: isAvailable ?? this.isAvailable,
      isDefault: isDefault ?? this.isDefault,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}