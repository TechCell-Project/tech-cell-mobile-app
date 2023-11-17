import 'package:flutter/material.dart';
import 'package:my_app/Widgets/HomeScreen/banner_slider.dart';
import 'package:my_app/Widgets/HomeScreen/header.dart';
import 'package:my_app/Widgets/HomeScreen/category.dart';
import 'package:my_app/Widgets/HomeScreen/prodcut_card.dart';
import 'package:my_app/Widgets/HomeScreen/products_hot_sale.dart';
import 'package:my_app/Widgets/HomeScreen/title_with_more_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = TrackingScrollController();

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
                TitleWithMoreBtn(text: 'KHUYẾN MÃI HOT'),
                ProductHotSale(),
                SizedBox(height: 15),
                TitleWithMoreBtn(text: 'SẢN PHẨM MỚI '),
                ProductCart(),
                SizedBox(height: 5),
              ],
            ),
          ),
          Header(_scrollController),
        ],
      ),
    );
  }
}
