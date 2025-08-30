import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    var products = productProvider.products;

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Badge(
                label: Text(cart.items.length.toString()),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                ),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          return ProductTile(product: product);
        },
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;

  ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);

    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: Icon(Icons.add_shopping_cart),
        onPressed: () {
          cartProvider.addToCart(product);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${product.name} added to cart!')),
          );
        },
      ),
    );
  }
}