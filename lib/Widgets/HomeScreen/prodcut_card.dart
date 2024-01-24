// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_app/API/api_product.dart';
import 'package:my_app/Providers/product_provider.dart';
import 'package:my_app/Widgets/ProductHome/in_frame.dart';
import 'package:my_app/models/product_model.dart';
import 'package:provider/provider.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({super.key});

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductProvider>(context, listen: false).getProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(244, 244, 244, 1)),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: FutureBuilder<List<ProductModel>>(
            future: ProductAPI().getAllProducts(),
            builder: (context, snapshot) {
              if ((snapshot.hasError) || (!snapshot.hasData))
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

              if (snapshot.data == null) {
                return Center(
                  child: Text('No Data!'),
                );
              }

              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text('Data Empty!'),
                );
              }
              List<ProductModel>? products = snapshot.data;
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  mainAxisExtent: 320,
                ),
                itemCount: products?.length,
                itemBuilder: (context, index) {
                  final product = products?[index];
                  return InFrame(product: product!);
                },
              );

              // return Consumer<ProductProvider>(
              //     builder: (context, value, child) {
              //   final products = value.products;
              //   return GridView.builder(
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 0,
              //       mainAxisSpacing: 0,
              //       mainAxisExtent: 330,
              //     ),
              //     itemCount: products.length,
              //     itemBuilder: (context, index) {
              //       final product = products[index];
              //       return InFrame(product: product);
              //     },
              //   );
              // });
            },
          ),
        ),
      ),
    );
  }
}
