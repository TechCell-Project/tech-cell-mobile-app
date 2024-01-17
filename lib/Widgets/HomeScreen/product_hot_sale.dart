// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_app/API/api_product.dart';
import 'package:my_app/Pages/Tabs/product_detail.dart';
import 'package:my_app/Providers/product_provider.dart';
import 'package:my_app/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
        height: 380,
        decoration: BoxDecoration(color: Color.fromRGBO(244, 244, 244, 1)),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: FutureBuilder<List<ProductModel>>(
            future: ProductAPI().getAllProducts(),
            builder: (context, snapshot) {
              if ((snapshot.hasError) || (!snapshot.hasData)) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
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

              return Consumer<ProductProvider>(
                builder: (context, value, child) {
                  final products = value.products;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductItem(product: product);
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  ProductModel product;
  ProductItem({required this.product});

  bool isThumbnail = false;

  final formatCurrency =
      new NumberFormat.currency(locale: 'id', decimalDigits: 0, name: 'đ');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      child: GestureDetector(
        onTap: () {
          // FocusScope.of(context).requestFocus(FocusNode());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetail(producdetail: product),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: product.generalImages.length,
                    itemBuilder: (context, index) {
                      var image;
                      try {
                        final generalImage = product.generalImages[index];
                        if (generalImage.isThumbnail == true) {
                          return image = Image(
                            image: NetworkImage('${generalImage.url}'),
                            height: 200,
                            fit: BoxFit.cover,
                          );
                        }
                      } catch (e) {
                        image = Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Image.asset(
                            "assets/images/no_image.jpg",
                            fit: BoxFit.cover,
                          ),
                        );
                      }

                      return Container(
                        child: image,
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${product.name}',
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
                    itemCount: product.variations.length,
                    itemBuilder: (context, index) {
                      final variation = product.variations[index];
                      if (index == 0) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '${formatCurrency.format(variation.price.sale)}',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
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
                                  '${formatCurrency.format(variation.price.base)}',
                                  style: TextStyle(
                                    color: Colors.grey.withOpacity(0.7),
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Đã bán' + ' ' + '${variation.stock}' + '+',
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
                      }
                      return SizedBox();
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
