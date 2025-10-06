class FavoriteModel {
  final int id;
  final int userId;
  final int? restaurantId;
  final int? productId;
  final DateTime createdAt;

  const FavoriteModel({
    required this.id,
    required this.userId,
    this.restaurantId,
    this.productId,
    required this.createdAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      restaurantId: json['restaurant_id'] as int?,
      productId: json['product_id'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'restaurant_id': restaurantId,
      'product_id': productId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  bool get isRestaurantFavorite => restaurantId != null;
  bool get isProductFavorite => productId != null;

  FavoriteModel copyWith({
    int? id,
    int? userId,
    int? restaurantId,
    int? productId,
    DateTime? createdAt,
  }) {
    return FavoriteModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      restaurantId: restaurantId ?? this.restaurantId,
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
