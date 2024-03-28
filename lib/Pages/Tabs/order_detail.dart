// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_app/API/api_product.dart';
import 'package:my_app/Pages/Tabs/product_detail.dart';

import 'package:my_app/Pages/Tabs/reason_cancelled_order.dart';


import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/models/order_model.dart';
import 'package:my_app/models/product_model.dart';
import 'package:my_app/utils/constant.dart';


class OrderDetail extends StatefulWidget {
  OrderUser orderDetail;
  OrderDetail({super.key, required this.orderDetail});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  String reaSonCancelled = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đơn hàng của bạn",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: BackButton(),
        backgroundColor: Colors.white,
        foregroundColor: primaryColors,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              styleOderStatus(),
              Divider(thickness: 0.5),
              _buildShippingAddressOrder(),
              Divider(thickness: 0.5),
              _buildProductOrder(),
              Divider(thickness: 0.5),
              __buildPaymentMethodAndSingleCode(),
              Divider(thickness: 0.5),
              _buildOrdersInvoice(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildButtonNavigationBar(),
    );
  }

  Widget styleOderStatus() {
    if (widget.orderDetail.oderStatus == 'completed') {
      return Container(
        height: 100,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(color: Color.fromARGB(255, 0, 197, 154)),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đơn hàng đã hoàn Thành',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                'Cảm ơn bạn đã mua hàng tại Techcell',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      );
    } else if (widget.orderDetail.oderStatus == 'pending') {
      return Container(
        height: 100,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(color: Colors.yellow[800]),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

          padding: const EdgeInsets.all(20.0),
          child: Row(

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đơn hàng đang chờ xử lý',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text('Vui lòng chờ đợi',
                      style: TextStyle(color: Colors.white)),
                  Text('Cảm ơn bạn đã mua hàng tại Techcell',
                      style: TextStyle(color: Colors.white))
                ],
              ),
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
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đơn hàng đang chờ xử lý',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Vui lòng chờ đợi',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Cảm ơn bạn đã mua hàng tại Techcell',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      );
  }

  Widget _buildShippingAddressOrder() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: primaryColors,
              ),
              SizedBox(width: 5),
              Text(
                "Địa chỉ nhận hàng",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${widget.orderDetail.shippingOrder.toAddress.customerName}',
                    ),
                    SizedBox(
                      height: 18,
                      child: VerticalDivider(
                        color: Colors.black54,
                        thickness: 1,
                      ),
                    ),
                    Text(
                      '${widget.orderDetail.shippingOrder.toAddress.phoneNumbers}',
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '${widget.orderDetail.shippingOrder.toAddress.detail}',
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      '${widget.orderDetail.shippingOrder.toAddress.wardLevel.wardName}, ',
                    ),
                    Text(
                      '${widget.orderDetail.shippingOrder.toAddress.districtLevel.district_name}, ',
                    ),
                    Text(
                      '${widget.orderDetail.shippingOrder.toAddress.provinceLevel.province_name}',
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductOrder() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, left: 10),
          child: Row(
            children: [
              Image(
                image: AssetImage(
                  'assets/logos/favicon.ico',
                ),
                width: 20,
              ),
              SizedBox(width: 5),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'TechCell',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 0.5),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.orderDetail.product.length,
          itemBuilder: (context, indexOrderDetail) {
            final orderProduct = widget.orderDetail.product[indexOrderDetail];
            return FutureBuilder<List<ProductModel>>(
              future: ProductAPI().getAllProducts(),
              builder: (context, snapshot) {
                if ((snapshot.hasError) || (!snapshot.hasData)) {
                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                List<ProductModel>? products = snapshot.data;
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: products?.length,
                    itemBuilder: (context, indexProduct) {
                      final itemProduct = products?[indexProduct];
                      if (orderProduct.productId == itemProduct!.id) {
                        return Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: itemProduct.variations.length,
                            itemBuilder: (context, indexVariation) {
                              final variation =
                                  itemProduct.variations[indexVariation];
                              if (orderProduct.sku == variation.sku) {
                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetail(
                                                productDetail: itemProduct),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 120,
                                        width: 120,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: variation.images.length,
                                          itemBuilder: (context, index) {
                                            final image =
                                                variation.images[index];
                                            if (image.isThumbnail == true) {
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
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 250,
                                          child: Text(
                                            '${itemProduct.name}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
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
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    variation.attributes.length,
                                                itemBuilder: (context, index) {
                                                  final attribute = variation
                                                      .attributes[index];
                                                  return Text(
                                                    ' ${attribute.v.toUpperCase()}${attribute.u ?? ''}',
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text(
                                              '${formatCurrency.format(variation.price.special)}',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              '-',
                                              style: TextStyle(
                                                color:
                                                    Colors.grey.withOpacity(1),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              '${formatCurrency.format(variation.price.base)}',
                                              style: TextStyle(
                                                color:
                                                    Colors.grey.withOpacity(1),
                                                fontWeight: FontWeight.w400,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Số lượng: ${orderProduct.quantity}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
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
                        );
                      }
                      return Container();
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget __buildPaymentMethodAndSingleCode() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.payments_outlined,
                  color: primaryColors,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phương thúc thanh toán',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    if (widget.orderDetail.paymentOrder.method == 'COD')
                      Text(
                        'Thanh toán khi nhận hàng',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    else
                      Text(widget.orderDetail.paymentOrder.method)
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.code_outlined,
                  color: primaryColors,
                ),
                SizedBox(width: 10),
                Text(
                  'Mã đơn hàng',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  widget.orderDetail.trackingCode,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.date_range,
                  color: primaryColors,
                ),
                SizedBox(width: 10),
                Text(
                  'Ngày đặt đơn',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  '${formatTimestamp(widget.orderDetail.createdAt)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (widget.orderDetail.oderStatus == 'completed')
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
              child: Row(
                children: [
                  Text('Ngày nhận đơn'),
                  Spacer(),
                  Text(
                    '${formatTimestamp(widget.orderDetail.updatedAt)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }

  Widget _buildOrdersInvoice() {
    int totalPrice = widget.orderDetail.checkoutOrder.totalPrice;
    int shippingFee = widget.orderDetail.checkoutOrder.shippingFee;
    int totalDiscount = widget.orderDetail.checkoutOrder.totalApplyDiscount;

    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Tạm tính',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                '${formatCurrency.format(totalPrice)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Text(
                'Phí vận chuyển',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                '${formatCurrency.format(shippingFee)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Text(
                'Giảm giá',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                '${formatCurrency.format(totalDiscount)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Text(
                'Voucher từ shop',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                '${formatCurrency.format(widget.orderDetail.checkoutOrder.totalApplyDiscount)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Divider(thickness: 1),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                Text(
                  'Thành tiền',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  '${formatCurrency.format(totalPrice + shippingFee - totalDiscount)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: primaryColors,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildButtonNavigationBar() {
    if (widget.orderDetail.oderStatus == 'completed') {
      return Padding(
          padding: EdgeInsets.all(10.0),
          child: ButtonSendrequest(text: 'Mua lại', submit: () {}));
    } else if (widget.orderDetail.oderStatus == 'pending') {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: ButtonSendrequest(
            text: 'Hủy đơn hàng',
            submit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) =>
                      ReaSonCancelledOrder(orderId: widget.orderDetail.id)),
                ),
              );
            }),
      );
    } else
      return null;
  }
}
