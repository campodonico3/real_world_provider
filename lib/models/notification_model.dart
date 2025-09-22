import 'package:flutter/cupertino.dart';

class AppNotification {
  final String id;
  final String userId;
  final NotificationType type;
  final String title;
  final String body;
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime createdAt;

  const AppNotification({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    this.data,
    this.isRead = false,
    required this.createdAt,
  });
}

enum NotificationType {
  orderConfirmed,
  orderPreparing,
  orderOnTheWay,
  orderDelivered,
  promotion,
  general
}