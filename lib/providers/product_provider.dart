import 'package:flutter/foundation.dart';
import 'package:real_world_provider/models/product_model.dart';

class ProductProvider with ChangeNotifier{
  List<Product> _products = [
    Product(id: '1', name: 'Laptop', price: 10.00),
    Product(id: '2', name: 'Smartphone', price: 40.00),
    Product(id: '3', name: 'Headphones', price: 9.99),
    Product(id: '4', name: 'Smartwatch', price: 13.00),
    Product(id: '5', name: 'Tablet', price: 45.00),
  ];

  List<Product> get products => _products;
}