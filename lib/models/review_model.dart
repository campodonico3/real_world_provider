class ReviewModel {
  final int id;
  final int userId;
  final int? restaurantId;
  final int? productId;
  final int? orderId;

  final int rating;
  final String? comment;

  // Ratings específicos
  final int? foodRating;
  final int? serviceRating;
  final int? deliveryRating;

  final bool isVerifiedPurchase;

  final DateTime createdAt;
  final DateTime? updatedAt;

  const ReviewModel({
    required this.id,
    required this.userId,
    this.restaurantId,
    this.productId,
    this.orderId,
    required this.rating,
    this.comment,
    this.foodRating,
    this.serviceRating,
    this.deliveryRating,
    required this.isVerifiedPurchase,
    required this.createdAt,
    this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      restaurantId: json['restaurant_id'] as int?,
      productId: json['product_id'] as int?,
      orderId: json['order_id'] as int?,
      rating: json['rating'] as int,
      comment: json['comment'] as String?,
      foodRating: json['food_rating'] as int?,
      serviceRating: json['service_rating'] as int?,
      deliveryRating: json['delivery_rating'] as int?,
      isVerifiedPurchase: json['is_verified_purchase'] as bool? ?? false,
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
      'restaurant_id': restaurantId,
      'product_id': productId,
      'order_id': orderId,
      'rating': rating,
      'comment': comment,
      'food_rating': foodRating,
      'service_rating': serviceRating,
      'delivery_rating': deliveryRating,
      'is_verified_purchase': isVerifiedPurchase,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  bool get isRestaurantReview => restaurantId != null;
  bool get isProductReview => productId != null;

  ReviewModel copyWith({
    int? id,
    int? userId,
    int? restaurantId,
    int? productId,
    int? orderId,
    int? rating,
    String? comment,
    int? foodRating,
    int? serviceRating,
    int? deliveryRating,
    bool? isVerifiedPurchase,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      restaurantId: restaurantId ?? this.restaurantId,
      productId: productId ?? this.productId,
      orderId: orderId ?? this.orderId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      foodRating: foodRating ?? this.foodRating,
      serviceRating: serviceRating ?? this.serviceRating,
      deliveryRating: deliveryRating ?? this.deliveryRating,
      isVerifiedPurchase: isVerifiedPurchase ?? this.isVerifiedPurchase,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}