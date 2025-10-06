import 'enums/restaurant_status_enum.dart';

class RestaurantModel {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final String? logoUrl;
  final String? bannerUrl;

  // Ubicación
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final double latitude;
  final double longitude;

  // Contacto
  final String phone;
  final String? email;

  // Configuración de delivery
  final double deliveryFee;
  final double minimumOrder;
  final double deliveryRadius;
  final int estimatedDeliveryTime;

  // Estado y ratings
  final RestaurantStatus status;
  final bool isOpen;
  final double averageRating;
  final int totalReviews;
  final int totalOrders;

  // Featured
  final bool isFeatured;
  final int featuredOrder;

  final DateTime createdAt;
  final DateTime? updatedAt;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.logoUrl,
    this.bannerUrl,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
    required this.phone,
    this.email,
    required this.deliveryFee,
    required this.minimumOrder,
    required this.deliveryRadius,
    required this.estimatedDeliveryTime,
    required this.status,
    required this.isOpen,
    required this.averageRating,
    required this.totalReviews,
    required this.totalOrders,
    required this.isFeatured,
    required this.featuredOrder,
    required this.createdAt,
    this.updatedAt,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      logoUrl: json['logo_url'] as String?,
      bannerUrl: json['banner_url'] as String?,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zip_code'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      phone: json['phone'] as String,
      email: json['email'] as String?,
      deliveryFee: double.parse(json['delivery_fee'].toString()),
      minimumOrder: double.parse(json['minimum_order'].toString()),
      deliveryRadius: (json['delivery_radius'] as num).toDouble(),
      estimatedDeliveryTime: json['estimated_delivery_time'] as int,
      status: RestaurantStatus.fromString(json['status'] as String),
      isOpen: json['is_open'] as bool,
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: json['total_reviews'] as int? ?? 0,
      totalOrders: json['total_orders'] as int? ?? 0,
      isFeatured: json['is_featured'] as bool,
      featuredOrder: json['featured_order'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'logo_url': logoUrl,
      'banner_url': bannerUrl,
      'street': street,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
      'email': email,
      'delivery_fee': deliveryFee.toString(),
      'minimum_order': minimumOrder.toString(),
      'delivery_radius': deliveryRadius,
      'estimated_delivery_time': estimatedDeliveryTime,
      'status': status.name,
      'is_open': isOpen,
      'average_rating': averageRating,
      'total_reviews': totalReviews,
      'total_orders': totalOrders,
      'is_featured': isFeatured,
      'featured_order': featuredOrder,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  String get fullAddress => '$street, $city, $state $zipCode';

  String get deliveryTimeText => '$estimatedDeliveryTime min';

  RestaurantModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? logoUrl,
    String? bannerUrl,
    String? street,
    String? city,
    String? state,
    String? zipCode,
    double? latitude,
    double? longitude,
    String? phone,
    String? email,
    double? deliveryFee,
    double? minimumOrder,
    double? deliveryRadius,
    int? estimatedDeliveryTime,
    RestaurantStatus? status,
    bool? isOpen,
    double? averageRating,
    int? totalReviews,
    int? totalOrders,
    bool? isFeatured,
    int? featuredOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      minimumOrder: minimumOrder ?? this.minimumOrder,
      deliveryRadius: deliveryRadius ?? this.deliveryRadius,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      status: status ?? this.status,
      isOpen: isOpen ?? this.isOpen,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
      totalOrders: totalOrders ?? this.totalOrders,
      isFeatured: isFeatured ?? this.isFeatured,
      featuredOrder: featuredOrder ?? this.featuredOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}