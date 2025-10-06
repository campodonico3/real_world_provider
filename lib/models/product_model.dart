class ProductModel {
  final int id;
  final int restaurantId;
  final int? categoryId;

  // Información básica
  final String name;
  final String slug;
  final String? description;
  final String? imageUrl;

  // Precio y disponibilidad
  final double price;
  final double? originalPrice;
  final bool isAvailable;
  final int? stock;

  // Metadata
  final int? preparationTime;
  final int? calories;
  final bool isVegetarian;
  final bool isVegan;
  final bool isGlutenFree;
  final bool isSpicy;
  final int? spicyLevel;

  // Popular y destacado
  final bool isPopular;
  final bool isFeatured;
  final int displayOrder;

  // Stats
  final int totalOrders;
  final double averageRating;
  final int totalReviews;

  final DateTime createdAt;
  final DateTime? updatedAt;

  const ProductModel({
    required this.id,
    required this.restaurantId,
    this.categoryId,
    required this.name,
    required this.slug,
    this.description,
    this.imageUrl,
    required this.price,
    this.originalPrice,
    required this.isAvailable,
    this.stock,
    this.preparationTime,
    this.calories,
    required this.isVegetarian,
    required this.isVegan,
    required this.isGlutenFree,
    required this.isSpicy,
    this.spicyLevel,
    required this.isPopular,
    required this.isFeatured,
    required this.displayOrder,
    required this.totalOrders,
    required this.averageRating,
    required this.totalReviews,
    required this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      restaurantId: json['restaurant_id'] as int,
      categoryId: json['category_id'] as int?,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      price: double.parse(json['price'].toString()),
      originalPrice: json['original_price'] != null
          ? double.parse(json['original_price'].toString())
          : null,
      isAvailable: json['is_available'] as bool,
      stock: json['stock'] as int?,
      preparationTime: json['preparation_time'] as int?,
      calories: json['calories'] as int?,
      isVegetarian: json['is_vegetarian'] as bool? ?? false,
      isVegan: json['is_vegan'] as bool? ?? false,
      isGlutenFree: json['is_gluten_free'] as bool? ?? false,
      isSpicy: json['is_spicy'] as bool? ?? false,
      spicyLevel: json['spicy_level'] as int?,
      isPopular: json['is_popular'] as bool? ?? false,
      isFeatured: json['is_featured'] as bool? ?? false,
      displayOrder: json['display_order'] as int? ?? 0,
      totalOrders: json['total_orders'] as int? ?? 0,
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: json['total_reviews'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant_id': restaurantId,
      'category_id': categoryId,
      'name': name,
      'slug': slug,
      'description': description,
      'image_url': imageUrl,
      'price': price.toString(),
      'original_price': originalPrice?.toString(),
      'is_available': isAvailable,
      'stock': stock,
      'preparation_time': preparationTime,
      'calories': calories,
      'is_vegetarian': isVegetarian,
      'is_vegan': isVegan,
      'is_gluten_free': isGlutenFree,
      'is_spicy': isSpicy,
      'spicy_level': spicyLevel,
      'is_popular': isPopular,
      'is_featured': isFeatured,
      'display_order': displayOrder,
      'total_orders': totalOrders,
      'average_rating': averageRating,
      'total_reviews': totalReviews,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  double get discountPercentage {
    if (!hasDiscount) return 0;
    return ((originalPrice! - price) / originalPrice!) * 100;
  }

  List<String> get badges {
    final List<String> badges = [];
    if (isVegetarian) badges.add('Vegetariano');
    if (isVegan) badges.add('Vegano');
    if (isGlutenFree) badges.add('Sin Gluten');
    if (isSpicy) badges.add('Picante');
    if (isPopular) badges.add('Popular');
    return badges;
  }

  ProductModel copyWith({
    int? id,
    int? restaurantId,
    int? categoryId,
    String? name,
    String? slug,
    String? description,
    String? imageUrl,
    double? price,
    double? originalPrice,
    bool? isAvailable,
    int? stock,
    int? preparationTime,
    int? calories,
    bool? isVegetarian,
    bool? isVegan,
    bool? isGlutenFree,
    bool? isSpicy,
    int? spicyLevel,
    bool? isPopular,
    bool? isFeatured,
    int? displayOrder,
    int? totalOrders,
    double? averageRating,
    int? totalReviews,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      isAvailable: isAvailable ?? this.isAvailable,
      stock: stock ?? this.stock,
      preparationTime: preparationTime ?? this.preparationTime,
      calories: calories ?? this.calories,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isVegan: isVegan ?? this.isVegan,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isSpicy: isSpicy ?? this.isSpicy,
      spicyLevel: spicyLevel ?? this.spicyLevel,
      isPopular: isPopular ?? this.isPopular,
      isFeatured: isFeatured ?? this.isFeatured,
      displayOrder: displayOrder ?? this.displayOrder,
      totalOrders: totalOrders ?? this.totalOrders,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}