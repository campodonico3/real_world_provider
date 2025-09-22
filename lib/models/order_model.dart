import 'package:real_world_provider/models/discount_model.dart';
import 'package:real_world_provider/models/payment_method_model.dart';
import 'package:real_world_provider/models/product_enhanced_model.dart';
import 'package:real_world_provider/models/user_model.dart';

class Order {
  final String id;
  final String userId;
  final String restaurantId;
  final List<OrderItem> items;
  final Address deliveryAddress;
  final OrderStatus status;
  final PaymentMethod paymentMethod;
  final double subtotal;
  final double deliveryFee;
  final double tax; // impuesto
  final double discount;
  final double total;
  final DateTime createdAt;
  final DateTime? estimatedDeliveryTime;
  final DateTime? deliveredAt;
  final String? specialInstructions;
  final AppliedDiscount? appliedDiscount;

  const Order({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.items,
    required this.deliveryAddress,
    required this.status,
    required this.paymentMethod,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.discount,
    required this.total,
    required this.createdAt,
    this.estimatedDeliveryTime,
    this.deliveredAt,
    this.specialInstructions,
    this.appliedDiscount,
  });
}

class OrderItem {
  final ProductEnhanced product;
  final int quantity;
  final List<ProductVariant> selectedVariants;
  final List<ProductAddon> selectedAddons;
  final String? specialInstructions;
  final double unitPrice;
  final double totalPrice;

  const OrderItem({
    required this.product,
    required this.quantity,
    this.selectedVariants = const [],
    this.selectedAddons = const [],
    this.specialInstructions,
    required this.unitPrice,
    required this.totalPrice,
  });
}

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  pickedUp,
  onTheWay,
  delivered,
  cancelled,
  refunded
}