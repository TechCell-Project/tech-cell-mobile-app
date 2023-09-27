import 'package:flutter/material.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/models/product_model.dart';

class ProductsHotSale extends StatefulWidget {
  const ProductsHotSale({super.key});

  @override
  State<ProductsHotSale> createState() => _ProductsHotSaleState();
}

class _ProductsHotSaleState extends State<ProductsHotSale> {
  List<ProductModel> products = [];

  void _getProduct() {
    products = ProductModel.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    _getProduct();
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: SizedBox(
        height: 250,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 250,
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {},
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
                                    width: 150,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    products[index].name,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${products[index].price}',
                                    style: const TextStyle(
                                      fontSize: 14,
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
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
