import 'package:flutter/material.dart';
import 'package:my_app/Widgets/HomeScreen/category.dart';
import 'package:my_app/Widgets/HomeScreen/prodcut_card.dart';
import 'package:my_app/Widgets/HomeScreen/products_hot_sale.dart';
import 'package:my_app/Widgets/HomeScreen/search_bar.dart';
import 'package:my_app/Widgets/HomeScreen/title_with_more_btn.dart';
import 'package:my_app/models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> products = [];

  void _getProduct() {
    products = ProductModel.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    _getProduct();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 248, 119, 110),
      ),
      body: const SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SearchTextField(),
              SizedBox(height: 30),
              Category(),
              SizedBox(height: 30),
              TitleWithMoreBtn(text: 'KHUYẾN MÃI HOT'),
              SizedBox(height: 10),
              ProductsHotSale(),
              SizedBox(height: 10),
              TitleWithMoreBtn(text: 'SẢN PHẨM MỚI '),
              ProductCard(),
            ],
          ),
        ),
      ),
    );
  }
}
