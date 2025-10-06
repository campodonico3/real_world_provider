class ProductOptionGroupModel {
  final int id;
  final int productId;
  final String name;
  final bool isRequired;
  final int minSelection;
  final int maxSelection;
  final int displayOrder;
  final DateTime createdAt;

  const ProductOptionGroupModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.isRequired,
    required this.minSelection,
    required this.maxSelection,
    required this.displayOrder,
    required this.createdAt,
  });

  factory ProductOptionGroupModel.fromJson(Map<String, dynamic> json) {
    return ProductOptionGroupModel(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      name: json['name'] as String,
      isRequired: json['is_required'] as bool,
      minSelection: json['min_selection'] as int? ?? 0,
      maxSelection: json['max_selection'] as int? ?? 1,
      displayOrder: json['display_order'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'name': name,
      'is_required': isRequired,
      'min_selection': minSelection,
      'max_selection': maxSelection,
      'display_order': displayOrder,
      'created_at': createdAt.toIso8601String(),
    };
  }

  bool get isMultipleChoice => maxSelection > 1;

  String get selectionText {
    if (isRequired) {
      return maxSelection == 1
          ? 'Selecciona 1 opción'
          : 'Selecciona hasta $maxSelection opciones';
    }
    return 'Opcional';
  }

  ProductOptionGroupModel copyWith({
    int? id,
    int? productId,
    String? name,
    bool? isRequired,
    int? minSelection,
    int? maxSelection,
    int? displayOrder,
    DateTime? createdAt,
  }) {
    return ProductOptionGroupModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      isRequired: isRequired ?? this.isRequired,
      minSelection: minSelection ?? this.minSelection,
      maxSelection: maxSelection ?? this.maxSelection,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}