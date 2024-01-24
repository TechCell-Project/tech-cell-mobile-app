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
            builder: (context) => ProductDetail(producdetail: widget.product),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                maxLines: 2,
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
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.product.variations.length,
                  itemBuilder: (context, index) {
                    final variation = widget.product.variations[index];
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
                                '${formatCurrency.format(variation.price.base)}',
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 13,
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
    );
  }
}
