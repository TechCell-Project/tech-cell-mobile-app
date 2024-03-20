// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_app/API/api_product.dart';
import 'package:my_app/Providers/product_provider.dart';
import 'package:my_app/Widgets/ProductHome/in_frame.dart';
import 'package:my_app/models/product_model.dart';
import 'package:provider/provider.dart';

class ProductHotSale extends StatefulWidget {
  const ProductHotSale({super.key});

  @override
  State<ProductHotSale> createState() => _ProductHotSaleState();
}

class _ProductHotSaleState extends State<ProductHotSale> {
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
        decoration: BoxDecoration(color: Color.fromRGBO(230, 230, 230, 1)),
        child: FutureBuilder<List<ProductModel>>(
          future: ProductAPI().getAllProducts(),
          builder: (context, snapshot) {
            if ((snapshot.hasError) || (!snapshot.hasData)) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

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
            return SizedBox(
              height: 325,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: (products != null && products.length >= 5)
                      ? 5
                      : products?.length ?? 0,
                  itemBuilder: (context, index) {
                    final product = products![products.length - index - 1];
                    return Container(
                      width: 180,
                      child: InFrame(product: product),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
