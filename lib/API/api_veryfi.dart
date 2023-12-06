import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/Pages/Tabs/recovery_tap.dart';
import 'package:my_app/utils/constant.dart';
import 'package:my_app/utils/snackbar.dart';
import 'package:http/http.dart' as http;

class Verify {
  Future<void> forgotPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${uri}auth/forgot-password'),
        body: jsonEncode(
          {'email': email},
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBarSuccess(context, 'Check email');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contex) => RecoveryTap(
                        email: email,
                        context: contex,
                      )));
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBarError(context, e.toString());
    }
  }

  Future<void> verifyForgotPassword({
    required BuildContext context,
    required String email,
    required String otpCode,
    required String password,
    // ignore: non_constant_identifier_names
    required String re_password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${uri}auth/verify-forgot-password'),
        body: jsonEncode(
          {
            'email': email,
            'otpCode': otpCode,
            'password': password,
            're_password': re_password,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBarSuccess(context, 'thay doi thanh cong');
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBarError(context, e.toString());
    }
  }
}
