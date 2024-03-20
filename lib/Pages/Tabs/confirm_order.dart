// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_app/API/api_order.dart';
import 'package:my_app/Pages/Screens/main_screen.dart';
import 'package:my_app/Providers/product_provider.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/Widgets/Address/button_in_address.dart';
import 'package:my_app/models/address_model.dart';
import 'package:my_app/models/order_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:provider/provider.dart';

class ConfirmOrder extends StatefulWidget {
  OrderReviewResponse orderResponse;

  ConfirmOrder({
    super.key,
    required this.orderResponse,
  });

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  int valueMethodPayment = 1;
  String? paymentMethod = 'COD';

  int getCartTotal() {
    int total = widget.orderResponse.totalPrice +
        widget.orderResponse.shipping.giaohangnhanh.serviceFee;
    formatCurrency.format(total);
    return total;
  }

  int getQuantity() {
    int total = 0;
    for (int i = 0; i < widget.orderResponse.product.length; i++) {
      total += widget.orderResponse.product[i].quantity;
    }
    return total;
  }

  void createOder() {
    OrderApi().createOrder(
      context: context,
      paymentMethod: paymentMethod!,
      addressSelected: widget.orderResponse.addressSelected,
      product: widget.orderResponse.product,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
    );
    showSnackBarSuccess(context, 'Đặt hàng thành công');
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thanh toán",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColors,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShippingAddress(),
                Divider(thickness: 1, color: Colors.black54),
                _buildPaymentProduct(),
                Divider(thickness: 1, color: Colors.black54),
                _buildPaymentMethods(),
                Divider(thickness: 1, color: Colors.black54),
                _buildBill(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildShippingAddress() {
    List<AddressModel> addressUser =
        Provider.of<UserProvider>(context).user.address;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
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
          Container(
            padding: EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${addressUser[widget.orderResponse.addressSelected].customerName}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 18,
                          child: VerticalDivider(
                            color: Colors.black54,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          '${addressUser[widget.orderResponse.addressSelected].phoneNumbers}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${addressUser[widget.orderResponse.addressSelected].detail}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              '${addressUser[widget.orderResponse.addressSelected].wardLevel.wardName},',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${addressUser[widget.orderResponse.addressSelected].districtLevel.district_name},  ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${addressUser[widget.orderResponse.addressSelected].provinceLevel.province_name}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentProduct() {
    List<Widget> productWidgets = [];

    for (int i = 0; i < widget.orderResponse.product.length; i++) {
      final product = widget.orderResponse.product[i];
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false).products;
      productWidgets.add(
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: productProvider.length,
          itemBuilder: (context, index) {
            final itemProduct = productProvider[index];
            if (product.productId == itemProduct.id) {
              return Container(
                width: 400,
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.symmetric(vertical: 5),
                // decoration: BoxDecoration(
                //   color: Color.fromARGB(255, 240, 239, 239),
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: itemProduct.variations.length,
                        itemBuilder: (context, indexVariation) {
                          final variation =
                              itemProduct.variations[indexVariation];

                          if (product.sku == variation.sku) {
                            return Row(
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: variation.images.length,
                                    itemBuilder: (context, index) {
                                      final image = variation.images[index];
                                      if (image.isThumbnail == true) {
                                        return Image(
                                          image: NetworkImage('${image.url}'),
                                        );
                                      } else if (index == 0) {
                                        return Image(
                                          image: NetworkImage('${image.url}'),
                                        );
                                      }
                                      return Container();
                                    },
                                  ),
                                ),
                                SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 220,
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
                                        Text(
                                          'Phân loại:',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Container(
                                          height:
                                              15, // Adjust the height as needed
                                          width: 150,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                variation.attributes.length,
                                            itemBuilder: (context, index) {
                                              final attribute =
                                                  variation.attributes[index];
                                              return Text(
                                                ' ${attribute.v.toUpperCase()}${attribute.u ?? ''}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
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
                                            color: Colors.grey.withOpacity(1),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '${formatCurrency.format(variation.price.base)}',
                                          style: TextStyle(
                                            color: Colors.grey.withOpacity(1),
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
                                      'Số lượng: ${product.quantity}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 5),
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
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: productWidgets,
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      padding: EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Color(0xFF475269).withOpacity(0.3),
      //       spreadRadius: 1,
      //       blurRadius: 5,
      //     ),
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phương thức thanh toán',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Thanh toán khi nhận hàng',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Radio(
                activeColor: primaryColors,
                value: 1,
                groupValue: valueMethodPayment,
                onChanged: (check) {
                  setState(() {
                    valueMethodPayment = check!;
                    paymentMethod = 'COD';
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Thanh toán qua VNPAY',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Radio(
                activeColor: primaryColors,
                value: 2,
                groupValue: valueMethodPayment,
                onChanged: (check) {
                  setState(() {
                    valueMethodPayment = check!;
                    paymentMethod = 'VNPAY';
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBill() {
    return Container(
      padding: EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10),
      //   boxShadow: [
      //     BoxShadow(
      //       color: const Color(0xFF475269).withOpacity(0.3),
      //       spreadRadius: 1,
      //       blurRadius: 5,
      //     ),
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chi tiết hóa đơn",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tổng số lượng",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                getQuantity().toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tổng tiền hàng",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${formatCurrency.format(widget.orderResponse.totalPrice)}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Phí vận chuyển",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${formatCurrency.format(widget.orderResponse.shipping.giaohangnhanh.total)}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tổng thanh toán",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                formatCurrency.format(getCartTotal()),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColors,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: EdgeInsets.all(10),
      child: ButtonInAddress(
        textInAddress: 'Đặt hàng',
        functionAddress: createOder,
      ),
    );
  }
}
