import 'package:flutter/material.dart';
import 'package:my_app/Pages/Tabs/cart_tap.dart';
import 'package:my_app/Pages/Tabs/login_tap.dart';
import 'package:my_app/Providers/token_manager.dart';
import 'package:my_app/models/user_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User?>(
        future: TokenManager.getUserfromStorage(),
        builder: (context, snapshoot) {
          if (snapshoot.data == null) {
            return LoginTap();
          } else {
            return CartTap();
          }
        },
      ),
    );
  }
}
