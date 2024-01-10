// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:my_app/models/cart_model.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:provider/provider.dart';

class CartApi {
  Future<CartModel> getCart(BuildContext context) async {
    CartModel cartModel = CartModel(
        id: '', userId: '', cartCountProduct: 1, product: [], cartState: '');

    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String accessToken = userProvider.user.accessToken;
      var headers = {
        'Authorization': 'Bearer $accessToken',
      };
      http.Response res = await http.get(
        Uri.parse(
          '${uri}carts',
        ),
        headers: headers,
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          String jsonres = res.body;
          dynamic decodeData = jsonDecode(jsonres);
          cartModel = CartModel.fromMap(decodeData);
          // List<CartModel> productCart =
          // (decodeData['products'] as List<dynamic>)
          //     .map<CartModel>((cartData) => CartModel.fromMap(cartData))
          //     .toList();
        },
      );
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
    return cartModel;
  }

  Future updateCart({
    required BuildContext context,
    required String productId,
    required String sku,
    required int quantity,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String accessToken = userProvider.user.accessToken;
      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      };
      http.Response res = await http.post(
        Uri.parse(
          '${uri}carts',
        ),
        headers: headers,
        body: jsonEncode(
          {
            "productId": productId,
            "sku": sku,
            "quantity": quantity,
          },
        ),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBarSuccess(context, 'thanh cong');
        },
      );
    } catch (e) {
      showSnackBarError(context, e.toString());
    }
  }
}