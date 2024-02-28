import 'package:flutter/material.dart';
import 'package:my_app/Widgets/HomeScreen/header_home.dart';
import 'package:my_app/Widgets/HomeScreen/prodcut_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final TrackingScrollController _scrollController = TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(height: 100),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Sản phẩm yêu thích tuần này:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                ProductCart(),
              ],
            ),
          ),
          HeaderHome(_scrollController),
        ],
      ),
    );
  }
}
