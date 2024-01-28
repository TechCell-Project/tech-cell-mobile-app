import 'package:flutter/material.dart';
import 'package:my_app/API/api_login.dart';
import 'package:my_app/Pages/Tabs/cart_tap.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: AuthLogin.getAccessToken(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          } else {
            return CartTap();
          }
        },
      ),
    );
  }
}
