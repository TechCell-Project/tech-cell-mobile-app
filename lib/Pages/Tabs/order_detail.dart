// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/API/api_order.dart';
import 'package:my_app/Providers/product_provider.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/models/order_model.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:provider/provider.dart';

class OrderDetail extends StatefulWidget {
  OrderUser orderUser;
  OrderDetail({super.key, required this.orderUser});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> productProvider =
        Provider.of<ProductProvider>(context, listen: false).products;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đơn hàng của bạn',
          style: TextStyle(color: Colors.black),
        ),
        foregroundColor: primaryColors,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BuildButtonNavigationBar(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              styleOderStatus(),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey),
                          Text(
                            'Địa chỉ nhận hàng',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(widget
                              .orderUser.shippingOrder.toAddress.addressName)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10),
                    child: Row(
                      children: [
                        Icon(Icons.store),
                        SizedBox(width: 5),
                        Text(
                          'TechCell',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.orderUser.product.length,
                    itemBuilder: (context, indexFirst) {
                      final itemCart = widget.orderUser.product[indexFirst];
                      return Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: productProvider.length,
                          itemBuilder: (context, indexSecond) {
                            final itemProduct = productProvider[indexSecond];
                            if (itemCart.productId == itemProduct.id) {
                              return Container(
                                width: 400,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            itemProduct.variations.length,
                                        itemBuilder: (context, indexThird) {
                                          final variation = itemProduct
                                              .variations[indexThird];

                                          if (itemCart.sku == variation.sku) {
                                            return Row(
                                              children: [
                                                Container(
                                                  height: 120,
                                                  width: 120,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        variation.images.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final image = variation
                                                          .images[index];
                                                      if (image.isThumbnail ==
                                                          true) {
                                                        return Image(
                                                          image: NetworkImage(
                                                              '${image.url}'),
                                                        );
                                                      } else if (index == 0) {
                                                        return Image(
                                                          image: NetworkImage(
                                                              '${image.url}'),
                                                        );
                                                      }
                                                      return Container();
                                                    },
                                                  ),
                                                ),

                                                // SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 200,
                                                      child: Text(
                                                        '${itemProduct.name}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        Text('Phân loại:'),
                                                        Container(
                                                          height:
                                                              15, // Adjust the height as needed
                                                          width: 150,
                                                          child:
                                                              ListView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount: variation
                                                                .attributes
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final attribute =
                                                                  variation
                                                                          .attributes[
                                                                      index];
                                                              return Text(
                                                                ' ${attribute.v.toUpperCase()}${attribute.u ?? ''}',
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    if (variation.price.sale !=
                                                            variation
                                                                .price.base &&
                                                        variation.price.sale !=
                                                            0)
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${formatCurrency.format(variation.price.sale)}',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            '-',
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            '${formatCurrency.format(variation.price.base)}',
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    else if (variation
                                                            .price.special !=
                                                        0)
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${formatCurrency.format(variation.price.special)}',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            '-',
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            '${formatCurrency.format(variation.price.base)}',
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    else
                                                      Text(
                                                        '${formatCurrency.format(variation.price.base)}',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      'Số lượng: ${itemCart.quantity.toString()}',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ),
                                                    ),
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
                              );
                            }
                            return Container();
                          },
                        ),
                      );
                    },
                  ),
                  const Divider(
                    thickness: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Tạm tính'),
                            Spacer(),
                            Text(formatCurrency.format(
                                widget.orderUser.checkoutOrder.totalPrice)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Phí vận chuyển'),
                            Spacer(),
                            Text(formatCurrency.format(
                                widget.orderUser.checkoutOrder.shippingFee)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Giảm giá'),
                            Spacer(),
                            Text(formatCurrency.format(widget
                                .orderUser.checkoutOrder.totalApplyDiscount)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Voucher từ shop'),
                            Spacer(),
                            Text(formatCurrency.format(widget
                                .orderUser.checkoutOrder.totalApplyDiscount)),
                          ],
                        ),
                        Divider(
                          thickness: 0.5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Thành tiền',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Text(
                              formatCurrency.format(
                                  widget.orderUser.checkoutOrder.totalPrice),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Image(
                              image: AssetImage(
                                'assets/logos/favicon.ico',
                              ),
                              width: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Phương thúc thanh toán',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        if (widget.orderUser.paymentOrder.method == 'COD')
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text('Thanh toán khi nhận hàng'),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text(widget.orderUser.paymentOrder.method),
                          ),
                      ]),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            'Mã đơn hàng',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          Spacer(),
                          Text(
                            widget.orderUser.trackingCode,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Row(
                        children: [
                          Text('Ngày đặt đơn'),
                          Spacer(),
                          Text(formatTimestamp(widget.orderUser.createdAt)),
                        ],
                      ),
                    ),
                    if (widget.orderUser.oderStatus == 'completed')
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, bottom: 10),
                        child: Row(
                          children: [
                            Text('Ngày nhận đơn'),
                            Spacer(),
                            Text(formatTimestamp(widget.orderUser.updatedAt)),
                          ],
                        ),
                      )
                    else
                      Container(),
                  ],
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  Widget styleOderStatus() {
    if (widget.orderUser.oderStatus == 'completed') {
      return Container(
        height: 100,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(color: Color.fromARGB(255, 0, 197, 154)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Đơn hàng đã hoàn Thành',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              Text('Cảm ơn bạn đã mua hàng tại Techcell',
                  style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      );
    } else if (widget.orderUser.oderStatus == 'pending') {
      return Container(
        height: 100,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(color: Colors.yellow[800]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đơn hàng đang chờ xử lý',
                style: TextStyle(color: Colors.white),
              ),
              Text('Vui lòng chờ đợi', style: TextStyle(color: Colors.white)),
              Text('Cảm ơn bạn đã mua hàng tại Techcell',
                  style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      );
    } else
      return Container(
        height: 100,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(color: Colors.yellow[400]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đơn hàng đang chờ xử lý',
                style: TextStyle(color: Colors.white),
              ),
              Text('Vui lòng chờ đợi', style: TextStyle(color: Colors.white)),
              Text('Cảm ơn bạn đã mua hàng tại Techcell',
                  style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      );
  }

  BuildButtonNavigationBar() {
    if (widget.orderUser.oderStatus == 'completed') {
      return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ButtonSendrequest(text: 'Mua lại', submit: () {}));
    } else if (widget.orderUser.oderStatus == 'pending') {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ButtonSendrequest(
            text: 'Hủy đơn hàng',
            submit: () {
              OrderApi().cancelOrder(context, orderId: widget.orderUser.id);
            }),
      );
    } else
      return null;
  }

  String formatTimestamp(String timestamp) {
    // Parse the input timestamp
    DateTime dateTime = DateTime.parse(timestamp);

    // Format the date and time
    String formattedDate =
        DateFormat('HH:mm || dd \'Tháng\' M, y').format(dateTime);

    return formattedDate;
  }
}
