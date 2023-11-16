import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Tabs/product_detail.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/models/product_model.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List<ProductModel> products = [];

  void _getProduct() {
    products = ProductModel.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    _getProduct();
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 25,
          childAspectRatio: 0.6,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 290,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetail(
                                            image: products[index].image,
                                            name: products[index].name,
                                            price: products[index].price,
                                          )));
                            },
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: primaryColors.withOpacity(0.3),
                                      blurRadius: 11,
                                    )
                                  ]),
                                  child: ClipRRect(
                                    child: Image.asset(
                                      "assets/images/${products[index].image}.png",
                                      width: 300,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              primaryColors.withOpacity(0.2))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        products[index].name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${products[index].price}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColors,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          Text('(${products[index].reView})'),
                                          const Spacer(),
                                          const Icon(
                                            CupertinoIcons.heart,
                                            color: Colors.red,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
