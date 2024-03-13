// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_app/API/api_product.dart';
import 'package:my_app/Widgets/ProductHome/in_frame.dart';
import 'package:my_app/models/product_model.dart';

class ProductCart extends StatefulWidget {
  final ScrollController scrollController;
  ProductCart(this.scrollController);

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  List<ProductModel> products = [];
  int page = 1;
  int pageSize = 4;
  bool isLoading = false;

  Future<void> _fetchProducts(int index) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      try {
        final fetchedProducts =
            await ProductAPI.getProductsByQuantity(index, pageSize);
        setState(() {
          products.addAll(fetchedProducts);
          page++;
          isLoading = false;
        });
      } catch (error) {
        print('Error fetching products: $error');
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _scrollListener() {
    if (widget.scrollController.position.pixels ==
        widget.scrollController.position.maxScrollExtent) {
      _fetchProducts(page);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts(page);
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(230, 230, 230, 1)),
        child: Column(
          children: [
            _buildProduct(products),
            _buildProgressIndicator(isLoading),
          ],
        ),
      ),
    );
  }

  Widget _buildProduct(products) {
    return Padding(
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
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return InFrame(product: product);
        },
      ),
    );
  }

  Widget _buildProgressIndicator(isLoading) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 0.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
