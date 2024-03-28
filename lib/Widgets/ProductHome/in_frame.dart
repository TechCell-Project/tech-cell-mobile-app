// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_app/Pages/Tabs/product_detail.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/utils/constant.dart';

class InFrame extends StatefulWidget {
  ProductModel product;
  InFrame({super.key, required this.product});

  @override
  State<InFrame> createState() => _InFrameState();
}

class _InFrameState extends State<InFrame> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(productDetail: widget.product),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.product.generalImages.length,
                  itemBuilder: (context, index) {
                    final image = widget.product.generalImages[index];
                    if (image.isThumbnail == true) {
                      return Image(
                        image: NetworkImage('${image.url}'),
                        height: 200,
                        fit: BoxFit.cover,
                      );
                    } else if (index == 0) {
                      return Image(
                        image: NetworkImage('${image.url}'),
                        height: 200,
                        fit: BoxFit.cover,
                      );
                    }
                    return Container();
                  },
                ),
              ),
              SizedBox(height: 5),
              Text(
                '${widget.product.name}',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.product.variations.length,
                  itemBuilder: (context, index) {
                    final variation = widget.product.variations[index];
                    if (index == 0) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (variation.price.special != 0)
                                Row(
                                  children: [
                                    Text(
                                      '${formatCurrency.format(variation.price.special)}',
                                      style: TextStyle(
                                        color: primaryColors,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      '${formatCurrency.format(variation.price.base)}',
                                      style: TextStyle(
                                        color: Colors.grey.withOpacity(0.5),
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Text(
                                  '${formatCurrency.format(variation.price.base)}',
                                  style: TextStyle(
                                    color: primaryColors,
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
                              SizedBox(height: 8),
                            ],
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
