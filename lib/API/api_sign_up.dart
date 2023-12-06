import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';

class AuthSignUp {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String userName,
    required String firstName,
    required String lastName,
    required String password,
    required String rePassword,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${uri}auth/register'),
        body: json.encode({
          'email': email,
          'userName': userName,
          'password': password,
          're_password': rePassword,
          'firstName': firstName,
          'lastName': lastName
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBarSuccess(context, 'Đăng ký thành công');
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBarError(context, e.toString());
    }
  }
}
