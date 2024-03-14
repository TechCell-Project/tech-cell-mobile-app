import 'package:flutter/material.dart';
import 'package:my_app/Widgets/HomeScreen/header_home.dart';
import 'package:my_app/Widgets/HomeScreen/prodcut_card.dart';
import 'package:my_app/Widgets/HomeScreen/title_with_more_btn.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                SizedBox(height: 100),
                TitleWithMoreBtn(text: 'Sản phẩm yêu thích:'),
                ProductCart(scrollController),
              ],
            ),
          ),
          HeaderHome(scrollController),
        ],
      ),
    );
  }
}
