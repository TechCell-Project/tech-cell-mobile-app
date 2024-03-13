// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_app/API/api_order.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/Widgets/Address/button_in_address.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/models/address_model.dart';
import 'package:my_app/models/order_model.dart';
import 'package:my_app/utils/constant.dart';
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
  }

  // openDiaologCart() => showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Don hang cua ban'),
  //         content: SizedBox(
  //           width: double.maxFinite,
  //           child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: widget.title.length,
  //               itemBuilder: ((context, index) {
  //                 return Row(
  //                   children: [
  //                     Image.asset(
  //                       widget.image[index],
  //                       width: 50,
  //                     ),
  //                     Text(widget.title[index]),
  //                   ],
  //                 );
  //               })),
  //         ),
  //         actions: [
  //           ElevatedButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text('Dong')),
  //         ],
  //       );
  //     });

  List<AddressModel> addressUser = [];
  @override
  Widget build(BuildContext context) {
    List<AddressModel> addressUser =
        Provider.of<UserProvider>(context).user.address;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Xác nhận đơn hàng",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColors,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: ButtonInAddress(
          textInAddress: 'Thanh toán',
          functionAddress: createOder,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: const Color.fromARGB(255, 244, 243, 247),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Thông tin nhận hàng",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    width: 300,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  addressUser[
                                          widget.orderResponse.addressSelected]
                                      .customerName,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 18,
                                  child: VerticalDivider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                ),
                                Text(
                                  addressUser[
                                          widget.orderResponse.addressSelected]
                                      .phoneNumbers,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(addressUser[
                                        widget.orderResponse.addressSelected]
                                    .detail),
                                Row(
                                  children: [
                                    Text(
                                        "${addressUser[widget.orderResponse.addressSelected].wardLevel.wardName}, "),
                                    Text(
                                        "${addressUser[widget.orderResponse.addressSelected].districtLevel.district_name}, "),
                                    Text(
                                        "${addressUser[widget.orderResponse.addressSelected].provinceLevel.province_name},"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ButtonSendrequest(
                  text: 'Kiểm tra đơn hàng',
                  submit: () {},
                ),
                const SizedBox(height: 30),
                const Text(
                  'Phương thức thanh toán',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF475269).withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Thanh toán khi nhận hàng',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
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
                          const Text(
                            'Thanh toán qua VNPAY',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
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
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF475269).withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tổng số hàng",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            getQuantity().toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 30,
                        thickness: 0.5,
                        color: Color(0xFF475269),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tổng đơn hàng",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            "${formatCurrency.format(widget.orderResponse.totalPrice)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 30,
                        thickness: 0.5,
                        color: Color(0xFF475269),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Phí vận chuyển",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            "${formatCurrency.format(widget.orderResponse.shipping.giaohangnhanh.total)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 30,
                        thickness: 0.5,
                        color: Color(0xFF475269),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tổng hóa đơn",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            formatCurrency.format(getCartTotal()),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColors,
                            ),
                          ),
                        ],
                      ),
                    ],
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
