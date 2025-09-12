import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:real_world_provider/widgets/double_text.dart';
import 'package:real_world_provider/widgets/ofertas_widget.dart';

import '../widgets/categories_widget.dart';
import '../widgets/order_action_bar.dart';
import '../widgets/search_bar_filter_widget.dart';
import '../widgets/welcome_header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _amount = 1;

  String _priceForAmount(int amount) {
    final unit = 5.49;
    return '\$${(unit * amount).toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final state = OrderState(amount: _amount, totalPrice: _priceForAmount(_amount));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WelcomeHeaderWidget(),
                    SizedBox(height: 12),
                    SearchBarWithFilterWidget(
                      editingController: TextEditingController(),
                      onFilterTap: () {},
                      onChanged: (text) {
                        print("Buscando: $text");
                      },
                    ),
                    SizedBox(height: 12),
                    AppDoubleText(
                      bigText: 'Today’s Menu',
                      smallText: '',
                      fun: () {},
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: allOffers
                            .map(
                              (singleOffers) => Offers(offerData: singleOffers),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 24),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CategoriesWidget(
                            title: 'Burgers',
                            imagePath: 'assets/images/hamburger.png',
                          ),
                          SizedBox(width: 10),
                          CategoriesWidget(
                            title: 'Fries',
                            imagePath: 'assets/images/chips.png',
                            color: Color(0xFFF5CAC3),
                          ),
                          SizedBox(width: 10),
                          CategoriesWidget(
                            title: 'Drinks',
                            imagePath: 'assets/images/drink.png',
                            color: Color(0xFFB6D7CF),
                          ),
                          SizedBox(width: 10),
                          CategoriesWidget(
                            title: 'Hot Dogs',
                            imagePath: 'assets/images/hot-dog.png',
                            color: Color(0xFFA9D7DA),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: OrderActionBar(
          state: state,
          onAddItemClicked: () => setState(() => _amount++),
          onRemoveItemClicked: () => setState(() => _amount = (_amount > 1) ? _amount - 1 : 1),
          onCheckOutClicked: () {
            // navegar al checkout, mostrar dialog, etc.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Checkout: ${state.totalPrice}')),
            );
          },
        ),
      ),
    );
  }
}
