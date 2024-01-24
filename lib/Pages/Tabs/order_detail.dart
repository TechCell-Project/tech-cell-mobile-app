// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_app/models/order_model.dart';
import 'package:my_app/utils/constant.dart';

class OrderDetail extends StatefulWidget {
  OrderUser orderUser;
  OrderDetail({super.key, required this.orderUser});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
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
    );
  }
}
