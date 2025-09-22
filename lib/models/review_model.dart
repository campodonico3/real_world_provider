class Review {
  final String id;
  final String userId;
  final String userName;
  final String? userImage;
  final String restaurantId;
  final String? orderId;
  final double rating;
  final String? comment;
  final DateTime createdAt;
  final List<String>? images;

  const Review({
    required this.id,
    required this.userId,
    required this.userName,
    this.userImage,
    required this.restaurantId,
    this.orderId,
    required this.rating,
    this.comment,
    required this.createdAt,
    this.images,
  });
}