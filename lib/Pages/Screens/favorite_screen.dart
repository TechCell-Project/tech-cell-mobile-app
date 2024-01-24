import 'package:flutter/material.dart';
import 'package:my_app/API/api_login.dart';
import 'package:my_app/Pages/Tabs/cart_tab.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: AuthLogin.getAccessToken(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          } else {
            return CartTab();
          }
        },
      ),
    );
  }
}
