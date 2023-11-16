// ignore: avoid_web_libraries_in_flutter
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:my_app/Providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:provider/provider.dart';

class Avatar {
  Future<void> postImage(
      {required BuildContext context, FormData? image}) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String accessToken = userProvider.user.accessToken;
      http.Response res = await http.post(
        Uri.parse('${uri}images'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'multipart/form-data',
        },
        body: image,
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBarSuccess(context, 'day len thanh cong');
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBarError(context, e.toString());
    }
  }
}
