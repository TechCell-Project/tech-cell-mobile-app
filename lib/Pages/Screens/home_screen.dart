import 'package:flutter/material.dart';

import 'package:my_app/Widgets/HomeScreen/banner_slider.dart';
import 'package:my_app/Widgets/HomeScreen/category.dart';
import 'package:my_app/Widgets/HomeScreen/header_home.dart';
import 'package:my_app/Widgets/HomeScreen/prodcut_card.dart';
import 'package:my_app/Widgets/HomeScreen/product_hot_sale.dart';
import 'package:my_app/Widgets/HomeScreen/title_with_more_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                BannerSlider(),
                Category(),
                TitleWithMoreBtn(text: 'Sản phẩm nổi bật:'),
                ProductHotSale(),
                TitleWithMoreBtn(text: 'Gợi ý cho bạn:'),
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
