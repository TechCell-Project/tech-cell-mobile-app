import 'package:flutter/material.dart';
import 'package:my_app/Widgets/HomeScreen/header_home.dart';
import 'package:my_app/Widgets/ProductHome/in_frame.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/utils/constant.dart';

class SearchCategory extends StatefulWidget {
  final String category;
  final List<ProductModel> products;

  SearchCategory({required this.products, required this.category});

  @override
  State<SearchCategory> createState() => _SearchCategoryState();
}

class _SearchCategoryState extends State<SearchCategory> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 120),
                _buildNameCategory(),
                _buildProductInCategory(),
              ],
            ),
          ),
          HeaderHome(scrollController),
        ],
      ),
    );
  }

  Widget _buildNameCategory() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 35,
              color: primaryColors,
            ),
          ),
          SizedBox(width: 15),
          Text(
            'Sản phẩm: ${widget.category}',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: primaryColors,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInCategory() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(230, 230, 230, 1)),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              mainAxisExtent: 320,
            ),
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              final product = widget.products[index];
              return InFrame(product: product);
            },
          ),
        ),
      ),
    );
  }
}
