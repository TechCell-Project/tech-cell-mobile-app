// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_app/API/api_product.dart';
import 'package:my_app/Providers/product_provider.dart';
import 'package:my_app/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
        decoration: BoxDecoration(
          color: Color.fromRGBO(244, 244, 244, 1),
        ),
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

              return Consumer<ProductProvider>(
                  builder: (context, value, child) {
                final products = value.products;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    mainAxisExtent: 350,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductItemCart(product: product);
                  },
                );
              });
            },
          ),
        ),
      ),
    );
  }
}

class ProductItemCart extends StatelessWidget {
  ProductModel? product;
  ProductItemCart({this.product});

  bool isThumbnail = false;

  final formatCurrency =
      new NumberFormat.currency(locale: 'id', decimalDigits: 0, name: 'đ');

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ProductDetail(
          //       producdetail: product,
          //     ),
          //   ),
          // );
        },
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Container(
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     physics: BouncingScrollPhysics(),
                //     itemCount: product!.generalImages.length,
                //     itemBuilder: (context, position) {
                //       return Column(
                //         children: <Widget>[
                //           Center(
                //             child: product!.generalImages[position]
                //                         .isThumbnail ==
                //                     true
                //                 ? Image(
                //                     image: NetworkImage(
                //                       '${product!.generalImages[position].url}',
                //                     ),
                //                     height: 200,
                //                     fit: BoxFit.cover,
                //                   )
                //                 : SizedBox(),
                //           ),
                //         ],
                //       );
                //     },
                //   ),
                // ),
                SizedBox(height: 10),
                Text(
                  '${product!.name}',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: product!.variations.length = 1,
                    itemBuilder: (context, position) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                '${formatCurrency.format(product!.variations[position].price.sale)}',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 8),
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 13,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '${formatCurrency.format(product!.variations[position].price.base)}',
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Đã bán' +
                                    ' ' +
                                    '${product!.variations[position].stock}' +
                                    '+',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
