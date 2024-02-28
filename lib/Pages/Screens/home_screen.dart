import 'package:flutter/material.dart';
import 'package:my_app/Widgets/HomeScreen/banner_slider.dart';
import 'package:my_app/Widgets/HomeScreen/category.dart';
import 'package:my_app/Widgets/HomeScreen/header_home.dart';
import 'package:my_app/Widgets/HomeScreen/prodcut_card.dart';
import 'package:my_app/Widgets/HomeScreen/product_hot_sale.dart';
import 'package:my_app/Widgets/HomeScreen/title_with_more_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                BannerSlider(),
                Category(),
                TitleWithMoreBtn(text: 'Sản phẩm nổi bật'),
                ProductHotSale(),
                SizedBox(height: 15),
                TitleWithMoreBtn(text: 'SẢN PHẨM MỚI '),
                ProductCart(),
                SizedBox(height: 5),
              ],
            ),
          ),
          HeaderHome(_scrollController),
        ],
      ),
    );
  }
}
