import 'package:flutter/material.dart';
import 'package:my_app/API/api_product.dart';
import 'package:my_app/Widgets/ProductHome/in_frame.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/utils/constant.dart';

class SearchProduct extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.close,
          size: 30,
          color: primaryColors,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        size: 30,
        color: primaryColors,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: FutureBuilder<List<ProductModel>>(
          future: ProductAPI().getAllProducts(query: query),
          builder: (context, snapshot) {
            if (snapshot.hasError || !snapshot.hasData)
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
              return Column(
                children: [
                  Container(
                    height: 150,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Sản phẩm không tồn tại!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 250,
                    width: 400,
                    color: Colors.white,
                    child: Image.asset(
                      'assets/images/data_empty.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
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
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                height: 470,
                width: 400,
                child: Image.asset(
                  'assets/images/search.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
