// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:my_app/API/api_order.dart';
import 'package:my_app/Pages/Tabs/order_detail.dart';
import 'package:my_app/models/order_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';

class OrderUserTap extends StatefulWidget {
  const OrderUserTap({super.key});

  @override
  State<OrderUserTap> createState() => _OrderUserTapState();
}

class _OrderUserTapState extends State<OrderUserTap> {
  ScrollController _scrollController = ScrollController();
  OrderResponse orderUser = OrderResponse(
    data: [],
    page: 1,
    pageSize: 1,
    totalPage: 1,
    totalRecord: 1,
  );
  String status = '';

  Future<void> getOderUser() async {
    try {
      OrderResponse orderdata = await OrderApi().getOrderUser(context);
      setState(() {
        orderUser = orderdata;
      });
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }

  int getTotalQuantity(int index) {
    int total = orderUser.data[index].product.length;
    return total;
  }

  int getTotalOrder() {
    int total = orderUser.data.length;
    return total;
  }

  void scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {}
  }

  @override
  void initState() {
    super.initState();
    getOderUser();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 231, 231, 231),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  height: 70,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              getTotalOrder().toString(),
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text('Đơn hàng'),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        const Column(
                          children: [
                            Text(
                              '0đ',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text('Tổng tiền'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: orderUser.data.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDetail(
                                        orderUser: orderUser.data[index])));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(Icons.store),
                                        Text('Techcell'),
                                      ],
                                    ),
                                    const Spacer(),
                                    getOrderStatus(index),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 218, 218, 218))),
                                      child: const Image(
                                        image: AssetImage(
                                            'assets/images/galaxy-z-fold-5-xanh-1.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        orderUser.data[index].product[0].sku,
                                        maxLines: 2,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "x${orderUser.data[index].product[0].quantity.toString()}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${getTotalQuantity(index).toString()} sản phẩm",
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    const Spacer(),
                                    const Image(
                                      image: AssetImage(
                                        'assets/logos/favicon.ico',
                                      ),
                                      width: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text("Thành tiền: "),
                                    Text(
                                      orderUser
                                          .data[index].checkoutOrder.totalPrice
                                          .toString(),
                                      style: const TextStyle(
                                          color: primaryColors, fontSize: 16),
                                    )
                                  ],
                                ),
                                const Divider(thickness: 1),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColors),
                                        onPressed: () {},
                                        child: const Text('Mua lại')),
                                  ],
                                )
                              ],
                            ),
                          )),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget styleOrderStatus(Color? color, String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Row(
        children: [
          const Icon(Icons.local_shipping_outlined),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget getOrderStatus(int index) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            if (orderUser.data[index].oderStatus == 'pending')
              styleOrderStatus(Colors.yellow[300], 'Đang chờ xác nhận')
            else if (orderUser.data[index].oderStatus == 'completed')
              styleOrderStatus(Colors.green, 'Đã hoàn thành')
          ],
        ));
  }

  Widget getMethodPayment(int index) {
    return Row(
      children: [
        if (orderUser.data[index].paymentOrder.method == 'COD')
          const Text('Thanh toán khi nhận hàng')
        else
          Text("Thanh toán qua ${orderUser.data[index].paymentOrder.method}"),
      ],
    );
  }
}
