class OrderItemOptionModel {
  final int id;
  final int orderItemId;
  final int optionId;

  // Snapshot
  final String optionName;
  final double priceModifier;

  final DateTime createdAt;

  const OrderItemOptionModel({
    required this.id,
    required this.orderItemId,
    required this.optionId,
    required this.optionName,
    required this.priceModifier,
    required this.createdAt,
  });

  factory OrderItemOptionModel.fromJson(Map<String, dynamic> json) {
    return OrderItemOptionModel(
      id: json['id'] as int,
      orderItemId: json['order_item_id'] as int,
      optionId: json['option_id'] as int,
      optionName: json['option_name'] as String,
      priceModifier: double.parse(json['price_modifier'].toString()),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_item_id': orderItemId,
      'option_id': optionId,
      'option_name': optionName,
      'price_modifier': priceModifier.toString(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  OrderItemOptionModel copyWith({
    int? id,
    int? orderItemId,
    int? optionId,
    String? optionName,
    double? priceModifier,
    DateTime? createdAt,
  }) {
    return OrderItemOptionModel(
      id: id ?? this.id,
      orderItemId: orderItemId ?? this.orderItemId,
      optionId: optionId ?? this.optionId,
      optionName: optionName ?? this.optionName,
      priceModifier: priceModifier ?? this.priceModifier,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}