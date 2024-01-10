// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/models/cart_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Order {
  Future<void> createOrder({
    required BuildContext context,
    required String paymentMethod,
    required int addressSelected,
    required List<Product> product,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String accessToken = userProvider.user.accessToken;
      http.Response res = await http.post(
        Uri.parse('${uri}order'),
        body: jsonEncode({
          "paymentMethod": paymentMethod,
          "addressSelected": addressSelected,
          "productSelected": product,
        }),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBarSuccess(context, 'Thanh cong');
          });
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }
}
