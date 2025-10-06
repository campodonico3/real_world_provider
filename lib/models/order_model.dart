import 'enums/order_status_enum.dart';
import 'enums/payment_method_enum.dart';
import 'enums/payment_status_enum.dart';

class OrderModel {
  final int id;
  final String orderNumber;

  // Relaciones
  final int userId;
  final int restaurantId;
  final int addressId;

  // Estado
  final OrderStatus status;

  // Montos
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double tax;
  final double total;

  // Pago
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;

  // Notas
  final String? customerNotes;
  final String? restaurantNotes;
  final String? cancellationReason;

  // Tiempos
  final DateTime? estimatedDeliveryTimeAt;
  final DateTime? confirmedAt;
  final DateTime? preparingAt;
  final DateTime? readyAt;
  final DateTime? onDeliveryAt;
  final DateTime? deliveredAt;
  final DateTime? cancelledAt;

  final DateTime createdAt;
  final DateTime? updatedAt;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.userId,
    required this.restaurantId,
    required this.addressId,
    required this.status,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.tax,
    required this.total,
    required this.paymentMethod,
    required this.paymentStatus,
    this.customerNotes,
    this.restaurantNotes,
    this.cancellationReason,
    this.estimatedDeliveryTimeAt,
    this.confirmedAt,
    this.preparingAt,
    this.readyAt,
    this.onDeliveryAt,
    this.deliveredAt,
    this.cancelledAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int,
      orderNumber: json['order_number'] as String,
      userId: json['user_id'] as int,
      restaurantId: json['restaurant_id'] as int,
      addressId: json['address_id'] as int,
      status: OrderStatus.fromString(json['status'] as String),
      subtotal: double.parse(json['subtotal'].toString()),
      deliveryFee: double.parse(json['delivery_fee'].toString()),
      discount: double.parse(json['discount'].toString()),
      tax: double.parse(json['tax'].toString()),
      total: double.parse(json['total'].toString()),
      paymentMethod: PaymentMethod.fromString(json['payment_method'] as String),
      paymentStatus: PaymentStatus.fromString(json['payment_status'] as String),
      customerNotes: json['customer_notes'] as String?,
      restaurantNotes: json['restaurant_notes'] as String?,
      cancellationReason: json['cancellation_reason'] as String?,
      estimatedDeliveryTimeAt: json['estimated_delivery_time_at'] != null
          ? DateTime.parse(json['estimated_delivery_time_at'] as String)
          : null,
      confirmedAt: json['confirmed_at'] != null
          ? DateTime.parse(json['confirmed_at'] as String)
          : null,
      preparingAt: json['preparing_at'] != null
          ? DateTime.parse(json['preparing_at'] as String)
          : null,
      readyAt: json['ready_at'] != null
          ? DateTime.parse(json['ready_at'] as String)
          : null,
      onDeliveryAt: json['on_delivery_at'] != null
          ? DateTime.parse(json['on_delivery_at'] as String)
          : null,
      deliveredAt: json['delivered_at'] != null
          ? DateTime.parse(json['delivered_at'] as String)
          : null,
      cancelledAt: json['cancelled_at'] != null
          ? DateTime.parse(json['cancelled_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_number': orderNumber,
      'user_id': userId,
      'restaurant_id': restaurantId,
      'address_id': addressId,
      'status': status.name,
      'subtotal': subtotal.toString(),
      'delivery_fee': deliveryFee.toString(),
      'discount': discount.toString(),
      'tax': tax.toString(),
      'total': total.toString(),
      'payment_method': paymentMethod.name,
      'payment_status': paymentStatus.name,
      'customer_notes': customerNotes,
      'restaurant_notes': restaurantNotes,
      'cancellation_reason': cancellationReason,
      'estimated_delivery_time_at': estimatedDeliveryTimeAt?.toIso8601String(),
      'confirmed_at': confirmedAt?.toIso8601String(),
      'preparing_at': preparingAt?.toIso8601String(),
      'ready_at': readyAt?.toIso8601String(),
      'on_delivery_at': onDeliveryAt?.toIso8601String(),
      'delivered_at': deliveredAt?.toIso8601String(),
      'cancelled_at': cancelledAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  bool get isActive => status != OrderStatus.delivered &&
      status != OrderStatus.cancelled &&
      status != OrderStatus.rejected;

  bool get canBeCancelled => status == OrderStatus.pending ||
      status == OrderStatus.confirmed;

  OrderModel copyWith({
    int? id,
    String? orderNumber,
    int? userId,
    int? restaurantId,
    int? addressId,
    OrderStatus? status,
    double? subtotal,
    double? deliveryFee,
    double? discount,
    double? tax,
    double? total,
    PaymentMethod? paymentMethod,
    PaymentStatus? paymentStatus,
    String? customerNotes,
    String? restaurantNotes,
    String? cancellationReason,
    DateTime? estimatedDeliveryTimeAt,
    DateTime? confirmedAt,
    DateTime? preparingAt,
    DateTime? readyAt,
    DateTime? onDeliveryAt,
    DateTime? deliveredAt,
    DateTime? cancelledAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      userId: userId ?? this.userId,
      restaurantId: restaurantId ?? this.restaurantId,
      addressId: addressId ?? this.addressId,
      status: status ?? this.status,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      customerNotes: customerNotes ?? this.customerNotes,
      restaurantNotes: restaurantNotes ?? this.restaurantNotes,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      estimatedDeliveryTimeAt: estimatedDeliveryTimeAt ?? this.estimatedDeliveryTimeAt,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      preparingAt: preparingAt ?? this.preparingAt,
      readyAt: readyAt ?? this.readyAt,
      onDeliveryAt: onDeliveryAt ?? this.onDeliveryAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}