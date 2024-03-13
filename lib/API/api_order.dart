// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_app/API/api_login.dart';
import 'package:my_app/Pages/Tabs/confirm_order.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/models/cart_model.dart';
import 'package:my_app/models/order_model.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderApi {
  Future<void> createOrder({
    required BuildContext context,
    required String paymentMethod,
    required int addressSelected,
    required List<Product> product,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String accessToken = userProvider.user.accessToken;
      if (accessToken.isEmpty) {
        final newAccessToken = await AuthLogin.getAccessToken();
        accessToken = newAccessToken!;
      }

      List<dynamic> listProductObj = product
          .map((e) =>
              {"productId": e.productId, "quantity": e.quantity, "sku": e.sku})
          .toList();
      http.Response res = await http.post(
        Uri.parse('${uri}order'),
        body: jsonEncode({
          "paymentMethod": paymentMethod,
          "addressSelected": addressSelected,
          "productSelected": listProductObj,
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

  Future<void> reviewOrder({
    required BuildContext context,
    required int addressSelected,
    required List<Product> productSelected,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String accessToken = userProvider.user.accessToken;
      if (accessToken.isEmpty) {
        final newAccessToken = await AuthLogin.getAccessToken();
        accessToken = newAccessToken!;
      }

      List<dynamic> listProductObj = productSelected
          .map((e) =>
              {"productId": e.productId, "quantity": e.quantity, "sku": e.sku})
          .toList();

      var bodyData = jsonEncode({
        'addressSelected': addressSelected,
        'productSelected': listProductObj,
      });

      http.Response res = await http.post(
        Uri.parse('${uri}order/review'),
        body: bodyData,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
          "accept": "application/json, text/plain, */*",
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          dynamic decodeData = jsonDecode(res.body);
          OrderReviewResponse orderReviewResponse =
              OrderReviewResponse.fromJson(decodeData);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ConfirmOrder(orderResponse: orderReviewResponse)));
        },
      );
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }

  Future<OrderResponse> getOrderUser(
      BuildContext context, String orderStatus) async {
    OrderResponse orederResPonse = OrderResponse(
        page: 1, pageSize: 5, totalPage: 11, totalRecord: 11, data: []);
    var userId = Provider.of<UserProvider>(context, listen: false).user.id;
    try {
      var accessToken =
          Provider.of<UserProvider>(context, listen: false).user.accessToken;
      if (accessToken.isEmpty) {
        final newAccessToken = await AuthLogin.getAccessToken();
        accessToken = newAccessToken!;
      }
      http.Response res = await http.get(
        Uri.parse('${uri}orders-mnt?userId=$userId&orderStatus=$orderStatus'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          dynamic decodedData = json.decode(res.body);
          for (var item in decodedData['data']) {
            orederResPonse.data.add(OrderUser.fromMap(item));
          }
        },
      );
    } catch (e) {
      // showSnackBarError(context, e.toString());
    }
    return orederResPonse;
  }

  Future cancelOrder(BuildContext context, {required String orderId}) async {
    try {
      var accessToken =
          Provider.of<UserProvider>(context, listen: false).user.accessToken;
      if (accessToken.isEmpty) {
        final newAccessToken = await AuthLogin.getAccessToken();
        accessToken = newAccessToken!;
      }
      http.Response res =
          await http.patch(Uri.parse('${uri}orders-mnt/$orderId'), headers: {
        'Authorization': 'Bearer $accessToken',
      }, body: {
        "orderStatus": "cancelled"
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.pop(context);
          showSnackBarSuccess(context, 'Thanh cong');
        },
      );
    } catch (e) {}
  }
}
