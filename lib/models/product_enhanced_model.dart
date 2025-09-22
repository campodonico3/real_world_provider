class Product {
  final String id;
  final String name;
  final double price;
  final String? imageUrl;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    this.isAvailable = true,
    required this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: _validateString(json['id'], 'id'),
        name: _validateString(json['name'], 'name'),
        price: _validatePrice(json['price']),
        imageUrl: _validateUrl(json['imageUrl']),
        isAvailable: json['isAvailable'] ?? true,
        createdAt: _parseDateTime(json['createdAt'], 'createdAt'),
        updatedAt: json['updatedAt'] != null
            ? _parseDateTime(json['updatedAt'], 'updatedAt')
            : null,
      );
    } catch (e) {
      throw FormatException('Error parsing Product from JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'isAvailable': isAvailable,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      map['imageUrl'] = imageUrl;
    }
    if (updatedAt != null) {
      map['updatedAt'] = updatedAt!.toUtc().toIso8601String();
    }

    return map;
  }

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Product(id: $id, name: $name, price: \$${price.toStringAsFixed(2)})';

  // Métodos helper
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

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

  static double _validatePrice(dynamic value) {
    if (value == null) throw ArgumentError('price cannot be null');
    final price = (value is num) ? value.toDouble() : double.tryParse(value.toString());

    if (price == null) {
      throw ArgumentError('Invalid price format: $value');
    }

    if (price < 0.0) {
      throw ArgumentError('Price cannot be negative: $price');
    }

    return price;
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

class ProductEnhanced extends Product {
  final String restaurantId;
  final String categoryId;
  final String description;
  final List<String> allergens;
  final int preparationTime; // in minutes
  final bool isVegetarian;
  final bool isVegan;
  final bool isGlutenFree;
  final bool isSpicy;
  final List<ProductVariant> variants;
  final List<ProductAddon> addons;
  final double rating; // 0.0 to 5.0
  final int reviewCount;
  final bool isPopular;
  final bool isNew;
  final bool isFeatured;
  final int calories;
  final String? nutritionInfo;
  final List<String> tags;
  final int stockQuantity;
  final ProductStatus status;

  const ProductEnhanced({
    required super.id,
    required super.name,
    required super.price,
    super.imageUrl,
    super.isAvailable,
    required super.createdAt,
    super.updatedAt,
    required this.restaurantId,
    required this.categoryId,
    required this.description,
    this.allergens = const [],
    this.preparationTime = 15,
    this.isVegetarian = false,
    this.isVegan = false,
    this.isGlutenFree = false,
    this.isSpicy = false,
    this.variants = const [],
    this.addons = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isPopular = false,
    this.isNew = false,
    this.isFeatured = false,
    this.calories = 0,
    this.nutritionInfo,
    this.tags = const [],
    this.stockQuantity = -1, // -1 significa stock ilimitado
    this.status = ProductStatus.active,
  });

  factory ProductEnhanced.fromJson(Map<String, dynamic> json) {
    try {
      return ProductEnhanced(
        id: _validateString(json['id'], 'id'),
        name: _validateString(json['name'], 'name'),
        price: _validatePrice(json['price']),
        imageUrl: _validateUrl(json['imageUrl']),
        isAvailable: json['isAvailable'] ?? true,
        createdAt: _parseDateTime(json['createdAt'], 'createdAt'),
        updatedAt: json['updatedAt'] != null
            ? _parseDateTime(json['updatedAt'], 'updatedAt')
            : null,
        restaurantId: _validateString(json['restaurantId'], 'restaurantId'),
        categoryId: _validateString(json['categoryId'], 'categoryId'),
        description: _validateString(json['description'], 'description'),
        allergens: _parseStringList(json['allergens']) ?? [],
        preparationTime: _validatePositiveInt(json['preparationTime'] ?? 15, 'preparationTime'),
        isVegetarian: json['isVegetarian'] == true,
        isVegan: json['isVegan'] == true,
        isGlutenFree: json['isGlutenFree'] == true,
        isSpicy: json['isSpicy'] == true,
        variants: _parseVariants(json['variants']),
        addons: _parseAddons(json['addons']),
        rating: _validateRating(json['rating']),
        reviewCount: _validateNonNegativeInt(json['reviewCount'], 'reviewCount'),
        isPopular: json['isPopular'] == true,
        isNew: json['isNew'] == true,
        isFeatured: json['isFeatured'] == true,
        calories: _validateNonNegativeInt(json['calories'], 'calories'),
        nutritionInfo: json['nutritionInfo']?.toString().trim(),
        tags: _parseStringList(json['tags']) ?? [],
        stockQuantity: json['stockQuantity'] != null
            ? _validateStockQuantity(json['stockQuantity'])
            : -1,
        status: _parseProductStatus(json['status']),
      );
    } catch (e) {
      throw FormatException('Error parsing ProductEnhanced from JSON: $e');
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'isAvailable': isAvailable,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'restaurantId': restaurantId,
      'categoryId': categoryId,
      'description': description,
      'allergens': allergens,
      'preparationTime': preparationTime,
      'isVegetarian': isVegetarian,
      'isVegan': isVegan,
      'isGlutenFree': isGlutenFree,
      'isSpicy': isSpicy,
      'variants': variants.map((v) => v.toJson()).toList(),
      'addons': addons.map((a) => a.toJson()).toList(),
      'rating': rating,
      'reviewCount': reviewCount,
      'isPopular': isPopular,
      'isNew': isNew,
      'isFeatured': isFeatured,
      'calories': calories,
      'tags': tags,
      'stockQuantity': stockQuantity,
      'status': status.name,
    };

    // Solo incluir campos opcionales si no son null o vacíos
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      map['imageUrl'] = imageUrl;
    }
    if (updatedAt != null) {
      map['updatedAt'] = updatedAt!.toUtc().toIso8601String();
    }
    if (nutritionInfo != null && nutritionInfo!.isNotEmpty) {
      map['nutritionInfo'] = nutritionInfo;
    }

    return map;
  }

  ProductEnhanced copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? restaurantId,
    String? categoryId,
    String? description,
    List<String>? allergens,
    int? preparationTime,
    bool? isVegetarian,
    bool? isVegan,
    bool? isGlutenFree,
    bool? isSpicy,
    List<ProductVariant>? variants,
    List<ProductAddon>? addons,
    double? rating,
    int? reviewCount,
    bool? isPopular,
    bool? isNew,
    bool? isFeatured,
    int? calories,
    String? nutritionInfo,
    List<String>? tags,
    int? stockQuantity,
    ProductStatus? status,
  }) {
    return ProductEnhanced(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      restaurantId: restaurantId ?? this.restaurantId,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      allergens: allergens ?? this.allergens,
      preparationTime: preparationTime ?? this.preparationTime,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isVegan: isVegan ?? this.isVegan,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isSpicy: isSpicy ?? this.isSpicy,
      variants: variants ?? this.variants,
      addons: addons ?? this.addons,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isPopular: isPopular ?? this.isPopular,
      isNew: isNew ?? this.isNew,
      isFeatured: isFeatured ?? this.isFeatured,
      calories: calories ?? this.calories,
      nutritionInfo: nutritionInfo ?? this.nutritionInfo,
      tags: tags ?? this.tags,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      status: status ?? this.status,
    );
  }

  @override
  String toString() => 'ProductEnhanced(id: $id, name: $name, rating: $rating, status: ${status.name})';

  // Métodos helper específicos del negocio
  bool get isHealthy => isVegetarian || isVegan || isGlutenFree;
  bool get hasVariants => variants.isNotEmpty;
  bool get hasAddons => addons.isNotEmpty;
  bool get hasRequiredAddons => addons.any((addon) => addon.isRequired);
  bool get isInStock => stockQuantity != 0;
  bool get hasUnlimitedStock => stockQuantity == -1;
  String get formattedPreparationTime => '$preparationTime min';
  String get formattedRating => rating > 0 ? '${rating.toStringAsFixed(1)} ⭐' : 'Sin calificación';
  List<String> get dietaryRestrictions {
    final restrictions = <String>[];
    if (isVegetarian) restrictions.add('Vegetariano');
    if (isVegan) restrictions.add('Vegano');
    if (isGlutenFree) restrictions.add('Sin Gluten');
    if (isSpicy) restrictions.add('Picante');
    return restrictions;
  }

  double get basePrice => price;
  double get minPriceWithVariants {
    if (variants.isEmpty) return price;
    final minVariantPrice = variants.map((v) => v.additionalPrice).reduce((a, b) => a < b ? a : b);
    return price + minVariantPrice;
  }

  double get maxPriceWithVariants {
    if (variants.isEmpty) return price;
    final maxVariantPrice = variants.map((v) => v.additionalPrice).reduce((a, b) => a > b ? a : b);
    return price + maxVariantPrice;
  }

  // Métodos de validación estáticos
  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];

    if (value is List) {
      return value.map((e) => e.toString().trim()).where((s) => s.isNotEmpty).toList();
    } else if (value is String) {
      return value.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    }

    return [];
  }

  static List<ProductVariant> _parseVariants(dynamic value) {
    if (value == null) return [];

    if (value is List) {
      return value.map((v) => ProductVariant.fromJson(v)).toList();
    }

    return [];
  }

  static List<ProductAddon> _parseAddons(dynamic value) {
    if (value == null) return [];

    if (value is List) {
      return value.map((a) => ProductAddon.fromJson(a)).toList();
    }

    return [];
  }

  static double _validateRating(dynamic value) {
    if (value == null) return 0.0;
    final rating = (value is num) ? value.toDouble() : double.tryParse(value.toString());

    if (rating == null) return 0.0;

    if (rating < 0.0 || rating > 5.0) {
      throw ArgumentError('Rating must be between 0.0 and 5.0: $rating');
    }

    return rating;
  }

  static int _validateStockQuantity(dynamic value) {
    if (value == null) return -1;
    final stock = (value is num) ? value.toInt() : int.tryParse(value.toString());

    if (stock == null) {
      throw ArgumentError('Invalid stockQuantity format: $value');
    }

    if (stock < -1) {
      throw ArgumentError('stockQuantity cannot be less than -1: $stock');
    }

    return stock;
  }

  static ProductStatus _parseProductStatus(dynamic value) {
    if (value == null) return ProductStatus.active;

    final stringValue = value.toString().toLowerCase();
    return ProductStatus.values.firstWhere(
          (status) => status.name.toLowerCase() == stringValue,
      orElse: () => ProductStatus.active,
    );
  }

  // Reutilizar métodos de validación de la clase base
  static String _validateString(dynamic value, String fieldName) => Product._validateString(value, fieldName);
  static String? _validateUrl(dynamic value) => Product._validateUrl(value);
  static double _validatePrice(dynamic value) => Product._validatePrice(value);
  static DateTime _parseDateTime(dynamic value, String fieldName) => Product._parseDateTime(value, fieldName);

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
}

enum ProductStatus {
  active,
  inactive,
  outOfStock,
  discontinued,
  seasonal;

  String get displayName {
    switch (this) {
      case ProductStatus.active:
        return 'Activo';
      case ProductStatus.inactive:
        return 'Inactivo';
      case ProductStatus.outOfStock:
        return 'Agotado';
      case ProductStatus.discontinued:
        return 'Descontinuado';
      case ProductStatus.seasonal:
        return 'Temporal';
    }
  }

  bool get isAvailable => this == ProductStatus.active || this == ProductStatus.seasonal;

}

class ProductVariant {
  final String id;
  final String name;
  final double additionalPrice;
  final bool isDefault;
  final bool isAvailable;
  final String? description;
  final int stockQuantity; // -1 for unlimited
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ProductVariant({
    required this.id,
    required this.name,
    this.additionalPrice = 0.0,
    this.isDefault = false,
    this.isAvailable = true,
    this.description,
    this.stockQuantity = -1,
    required this.createdAt,
    this.updatedAt,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    try {
      return ProductVariant(
        id: _validateString(json['id'], 'id'),
        name: _validateString(json['name'], 'name'),
        additionalPrice: _validateAdditionalPrice(json['additionalPrice']),
        isDefault: json['isDefault'] == true,
        isAvailable: json['isAvailable'] ?? true,
        description: json['description']?.toString().trim(),
        stockQuantity: json['stockQuantity'] != null
            ? _validateStockQuantity(json['stockQuantity'])
            : -1,
        createdAt: _parseDateTime(json['createdAt'], 'createdAt'),
        updatedAt: json['updatedAt'] != null
            ? _parseDateTime(json['updatedAt'], 'updatedAt')
            : null,
      );
    } catch (e) {
      throw FormatException('Error parsing ProductVariant from JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'additionalPrice': additionalPrice,
      'isDefault': isDefault,
      'isAvailable': isAvailable,
      'stockQuantity': stockQuantity,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };

    if (description != null && description!.isNotEmpty) {
      map['description'] = description;
    }
    if (updatedAt != null) {
      map['updatedAt'] = updatedAt!.toUtc().toIso8601String();
    }

    return map;
  }

  ProductVariant copyWith({
    String? id,
    String? name,
    double? additionalPrice,
    bool? isDefault,
    bool? isAvailable,
    String? description,
    int? stockQuantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductVariant(
      id: id ?? this.id,
      name: name ?? this.name,
      additionalPrice: additionalPrice ?? this.additionalPrice,
      isDefault: isDefault ?? this.isDefault,
      isAvailable: isAvailable ?? this.isAvailable,
      description: description ?? this.description,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductVariant && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ProductVariant(id: $id, name: $name, additionalPrice: \$${additionalPrice.toStringAsFixed(2)})';

  // Métodos helper
  bool get isInStock => stockQuantity != 0;
  bool get hasUnlimitedStock => stockQuantity == -1;
  String get formattedAdditionalPrice {
    if (additionalPrice == 0) return 'Sin costo adicional';
    if (additionalPrice > 0) return '+\$${additionalPrice.toStringAsFixed(2)}';
    return '-\$${additionalPrice.abs().toStringAsFixed(2)}';
  }

  static String _validateString(dynamic value, String fieldName) {
    if (value == null || value.toString().trim().isEmpty) {
      throw ArgumentError('$fieldName cannot be null or empty');
    }
    return value.toString().trim();
  }

  static double _validateAdditionalPrice(dynamic value) {
    if (value == null) return 0.0;
    final price = (value is num) ? value.toDouble() : double.tryParse(value.toString());

    if (price == null) {
      throw ArgumentError('Invalid additionalPrice format: $value');
    }

    // Permitir precios negativos para descuentos
    return price;
  }

  static int _validateStockQuantity(dynamic value) {
    if (value == null) return -1;
    final stock = (value is num) ? value.toInt() : int.tryParse(value.toString());

    if (stock == null) {
      throw ArgumentError('Invalid stockQuantity format: $value');
    }

    if (stock < -1) {
      throw ArgumentError('stockQuantity cannot be less than -1: $stock');
    }

    return stock;
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

class ProductAddon {
  final String id;
  final String name;
  final double price;
  final bool isRequired;
  final int maxQuantity;
  final int minQuantity;
  final bool isAvailable;
  final String? description;
  final String? category; // "Extras", "Bebidas", etc.
  final int stockQuantity; // -1 for unlimited
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ProductAddon({
    required this.id,
    required this.name,
    required this.price,
    this.isRequired = false,
    this.maxQuantity = 1,
    this.minQuantity = 0,
    this.isAvailable = true,
    this.description,
    this.category,
    this.stockQuantity = -1,
    required this.createdAt,
    this.updatedAt,
  });

  factory ProductAddon.fromJson(Map<String, dynamic> json) {
    try {
      return ProductAddon(
        id: _validateString(json['id'], 'id'),
        name: _validateString(json['name'], 'name'),
        price: _validatePrice(json['price']),
        isRequired: json['isRequired'] == true,
        maxQuantity: _validatePositiveInt(json['maxQuantity'] ?? 1, 'maxQuantity'),
        minQuantity: _validateNonNegativeInt(json['minQuantity'], 'minQuantity'),
        isAvailable: json['isAvailable'] ?? true,
        description: json['description']?.toString().trim(),
        category: json['category']?.toString().trim(),
        stockQuantity: json['stockQuantity'] != null
            ? _validateStockQuantity(json['stockQuantity'])
            : -1,
        createdAt: _parseDateTime(json['createdAt'], 'createdAt'),
        updatedAt: json['updatedAt'] != null
            ? _parseDateTime(json['updatedAt'], 'updatedAt')
            : null,
      );
    } catch (e) {
      throw FormatException('Error parsing ProductAddon from JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'isRequired': isRequired,
      'maxQuantity': maxQuantity,
      'minQuantity': minQuantity,
      'isAvailable': isAvailable,
      'stockQuantity': stockQuantity,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };

    if (description != null && description!.isNotEmpty) {
      map['description'] = description;
    }
    if (category != null && category!.isNotEmpty) {
      map['category'] = category;
    }
    if (updatedAt != null) {
      map['updatedAt'] = updatedAt!.toUtc().toIso8601String();
    }

    return map;
  }

  ProductAddon copyWith({
    String? id,
    String? name,
    double? price,
    bool? isRequired,
    int? maxQuantity,
    int? minQuantity,
    bool? isAvailable,
    String? description,
    String? category,
    int? stockQuantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductAddon(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      isRequired: isRequired ?? this.isRequired,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      minQuantity: minQuantity ?? this.minQuantity,
      isAvailable: isAvailable ?? this.isAvailable,
      description: description ?? this.description,
      category: category ?? this.category,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductAddon && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ProductAddon(id: $id, name: $name, price: \$${price.toStringAsFixed(2)}, required: $isRequired)';

  // Métodos helper
  bool get isInStock => stockQuantity != 0;
  bool get hasUnlimitedStock => stockQuantity == -1;
  String get formattedPrice => price > 0 ? '+\$${price.toStringAsFixed(2)}' : 'Gratis';
  bool get hasQuantityLimits => maxQuantity > 1;
  String get quantityRange => minQuantity == maxQuantity ? '$minQuantity' : '$minQuantity-$maxQuantity';

  static String _validateString(dynamic value, String fieldName) {
    if (value == null || value.toString().trim().isEmpty) {
      throw ArgumentError('$fieldName cannot be null or empty');
    }
    return value.toString().trim();
  }

  static double _validatePrice(dynamic value) {
    if (value == null) throw ArgumentError('price cannot be null');
    final price = (value is num) ? value.toDouble() : double.tryParse(value.toString());

    if (price == null) {
      throw ArgumentError('Invalid price format: $value');
    }

    if (price < 0.0) {
      throw ArgumentError('Price cannot be negative: $price');
    }

    return price;
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

  static int _validateStockQuantity(dynamic value) {
    if (value == null) return -1;
    final stock = (value is num) ? value.toInt() : int.tryParse(value.toString());

    if (stock == null) {
      throw ArgumentError('Invalid stockQuantity format: $value');
    }

    if (stock < -1) {
      throw ArgumentError('stockQuantity cannot be less than -1: $stock');
    }

    return stock;
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