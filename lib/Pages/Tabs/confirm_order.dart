// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_app/API/api_order.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/Widgets/Address/button_in_address.dart';
import 'package:my_app/Widgets/Login/button.dart';
import 'package:my_app/models/address_model.dart';
import 'package:my_app/models/cart_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:provider/provider.dart';

class ConfirmOrder extends StatefulWidget {
  double totalOrder;
  List<String> image;
  List<String> title;
  List<int> price;
  int totalQuantity;
  int indexAddress;
  List<Product> product;

  ConfirmOrder({
    super.key,
    required this.totalOrder,
    required this.image,
    required this.price,
    required this.title,
    required this.indexAddress,
    required this.product,
    required this.totalQuantity,
  });

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  int delivery = 0;
  int discount = 20;
  int valueMethodPayment = 1;
  String? paymentMethod = 'COD';
  double getCartTotal() {
    double total =
        widget.totalOrder + delivery - (widget.totalOrder * (20 / 100));
    return total;
  }

  void createOder() {
    Order().createOrder(
      context: context,
      paymentMethod: paymentMethod!,
      addressSelected: widget.indexAddress,
      product: widget.product,
    );
  }

  openDiaologCart() => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Don hang cua ban'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.title.length,
                itemBuilder: ((context, index) {
                  return Row(
                    children: [
                      Image.asset(
                        widget.image[index],
                        width: 50,
                      ),
                      Text(widget.title[index]),
                    ],
                  );
                })),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Dong')),
          ],
        );
      });

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
          textInAddress: 'Thanh toan',
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
                                  addressUser[widget.indexAddress].customerName,
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
                                  addressUser[widget.indexAddress].phoneNumbers,
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
                                Text(addressUser[widget.indexAddress].detail),
                                Row(
                                  children: [
                                    Text(
                                        "${addressUser[widget.indexAddress].wardLevel.wardName}, "),
                                    Text(
                                        "${addressUser[widget.indexAddress].districtLevel.district_name}, "),
                                    Text(
                                        "${addressUser[widget.indexAddress].provinceLevel.province_name},"),
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
                  submit: openDiaologCart,
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
                            'Thanh toán qua VNPay',
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
                                paymentMethod = 'VNPay';
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
                            "Tổng so hang",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            "${widget.totalQuantity}",
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
                            "${widget.totalOrder}",
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
                            "$delivery VND",
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
                            "Giảm giá",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            "$discount %",
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
                            getCartTotal().toString(),
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
